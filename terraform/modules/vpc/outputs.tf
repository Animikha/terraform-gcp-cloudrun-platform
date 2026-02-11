output "network_name" {
    description = "Name of the vpc network"
    value = google_compute_network.vpc.name
}

output "lb_subnet_name" {
    description = "Name of the subnet where load balancer would be"
    value = google_compute_subnetwork.subnet["subnet-1"].name
}