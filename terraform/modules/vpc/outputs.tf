output "network_name" {
    description = "Name of the vpc network"
    value = google_compute_network.vpc.name
}