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
    protocol = HTTP
    load_balancing_scheme = "INTERNAL_MANAGED"

    backend {
        group = each.value.id
    }
}

resource "google_compute_url_map" "internal_url_map" {
    name = "lb-tgcp"
    default_service = google_compute_backend_service.backends["frontend"].id

    


    }