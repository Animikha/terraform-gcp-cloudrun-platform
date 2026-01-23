provider "google" {
  credentials = file("")
  project     = var.project_id
  region      = var.region
  impersonate_service_account = 
}

module "vpc" {
    source = "../modules/vpc"
    vpc_name = var.vpc_name
    subnets = var.subnets
    internal_source_ranges = var.internal_source_ranges

}