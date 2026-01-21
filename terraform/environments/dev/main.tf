provider "google" {
  credentials = file("")
  project     = var.project_id
  region      = var.region
}

module "vpc" {
    source = "../modules/vpc"
    vpc_name = var.vpc_name
    subnets = var.subnets
    internal_source_ranges = var.internal_source_range

}