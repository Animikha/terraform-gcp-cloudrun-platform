data "terraform_remote_state" "bootstrap" {
  backend = "gcs"
  config = {
    bucket = "tf-state-bootstrap-tgcp"
    prefix = "state"
  }
}
provider "google" {
  credentials = file("")
  project     = var.project_id
  region      = var.region
  impersonate_service_account = data.terraform_remote_state.bootstrap.outputs.tf_serv_account_email
}

module "vpc" {
    source = "../modules/vpc"
    vpc_name = var.vpc_name
    subnets = var.subnets
    internal_source_ranges = var.internal_source_ranges

}