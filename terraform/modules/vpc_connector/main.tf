resource "google_vpc_access_connector" "default" {
    name = var.vpc_connector_name
    region = var.region
    project = var.project
    network = var.vpc_self_link
    ip_cidr_range = var.connector_subnet_cidr

    min_throughput = 200
    max_throughput = 300
}