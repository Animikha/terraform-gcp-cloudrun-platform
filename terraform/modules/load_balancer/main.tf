resource "google_compute_region_network_endpoint_group" "cloud_run_negs" {
    for_each = var.services
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
    name = var.url_map_name #"lb-url-map-tgcp"
    default_service = google_compute_backend_service.backends["frontend"].id

    host_rule {
        hosts = ["*"]
        path_matcher = "services"
    }

    path_matcher {
        name = "services"
        default_service = google_compute_backend_service.backends["frontend"].id

        path_rule {
            paths = ["/auth/*"]
            service = google_compute_backend_service.backends["auth"].id

        }

        path_rule {
            paths = ["/api/*"]
            service = google_compute_backend_service.backends["api"].id
        }
    }
}

resource "google_compute_target_http_proxy" "internal_proxy" {
    name = var.proxy_name
    url_map = google_compute_url_map.internal_url_map.id
}

resource "google_compute_forwarding_rule" "internal_lb" {
    name = var.forwarding_rule_name
    region = var.region
    load_balancing_scheme = "INTERNAL_MANAGED"
    ip_protocol = "TCP"
    port_range = "80"
    target = google_compute_target_http_proxy.internal_proxy.id
    network = var.vpc_name
    subnetwork = var.subnet_name
}