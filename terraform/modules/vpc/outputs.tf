output "vpc_self_link" {
    description = "Name of the vpc network"
    value = google_compute_network.vpc.self_link
}

output "lb_subnet_self_link" {
    description = "Name of the subnet where load balancer would be"
    value = google_compute_subnetwork.subnet["subnet-1"].self_link
}