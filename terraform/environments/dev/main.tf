data "terraform_remote_state" "bootstrap" {
  backend = "gcs"
  config = {
    bucket = "tf-state-bootstrap-tgcp"
    prefix = "state"
  }
}
provider "google" {
  project     = var.project
  region      = var.region
  impersonate_service_account = data.terraform_remote_state.bootstrap.outputs.tf_serv_account_email
}

module "vpc" {
    source = "../../modules/vpc"
    vpc_name = var.vpc_name
    subnets = var.subnets
    internal_source_ranges = var.internal_source_ranges

}

module "vpc_connector" {
  source = "../../modules/vpc_connector"
  project     = var.project
  region      = var.region
  vpc_connector_name = var.vpc_connector_name
  vpc_name = module.vpc.network_name
  connector_subnet_cidr = var.connector_subnet_cidr
  depends_on = [ module.vpc ]
}

module "cloudrun_service" {
  source = "../../modules/cloudrun_service"
  project     = var.project
  region      = var.region
  services = var.services
  vpc_connector = module.vpc_connector.id
  depends_on = [ module.vpc_connector, module.vpc ]
}

module "load_balancer" {
  source = "../../modules/load_balancer"
  project = var.project
  region = var.region
  lb_routes = var.lb_routes
  lb_url_map_name = var.lb_url_map_name 
  lb_http_proxy_name = var.lb_http_proxy_name
  lb_forwarding_rule_name = var.lb_forwarding_rule_name
  vpc_name = module.vpc.network_name
  lb_subnet_name = module.vpc.lb_subnet_name
  lb_ip_name = var.lb_ip_name
  depends_on = [module.cloudrun_service, module.vpc_connector, module.vpc] 
}