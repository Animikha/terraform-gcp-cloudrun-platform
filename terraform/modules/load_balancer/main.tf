resource "google_compute_region_network_endpoint_group" "cloud_run_negs" {
    for_each = var.lb_routes
    name = "${each.key}-neg"
    region = var.region
    network_endpoint_type = "SERVERLESS"

    cloud_run {
        service = each.key
    }
}

resource "google_compute_backend_service" "backends" {
    for_each = google_compute_region_network_endpoint_group.cloud_run_negs
    name = "${each.key}-backend"
    protocol = "HTTP"
    load_balancing_scheme = "INTERNAL_MANAGED"

    backend {
        group = each.value.id
    }
}

resource "google_compute_url_map" "internal_url_map" {
    name = var.lb_url_map_name 
    default_service = google_compute_backend_service.backends["frontend"].id

    host_rule {
        hosts = ["*"]
        path_matcher = "services"
    }

    path_matcher {
        name = "services"
        default_service = google_compute_backend_service.backends["frontend"].id

        dynamic path_rule {
            for_each = var.lb_routes
            content {
                paths = path_rule.value.paths
                service = google_compute_backend_service.backends[path_rule.key].id
            }
        }
    }
}

resource "google_compute_target_http_proxy" "internal_proxy" {
    name = var.lb_http_proxy_name
    url_map = google_compute_url_map.internal_url_map.id
}

resource "google_compute_forwarding_rule" "internal_lb" {
    name = var.lb_forwarding_rule_name
    load_balancing_scheme = "INTERNAL_MANAGED"
    ip_protocol = "TCP"
    port_range = "80"
    target = google_compute_target_http_proxy.internal_proxy.id
    network = var.vpc_name
    subnetwork = var.lb_subnet_name 
    ip_address = google_compute_address.lb_ip.address
}

resource "google_compute_address" "lb_ip" {
    name = var.lb_ip_name
    region = var.region
    subnetwork = var.lb_subnet_name 
    address_type = "INTERNAL"
}