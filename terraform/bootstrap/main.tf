provider "google" {
  credentials = file("")
  project     = var.project
  region      = var.region
}

module "artifact_registry" {
  source = "../modules/artifact_registry"
  repos = var.repos
  project     = var.project
  region      = var.region
}

module "iam" {
    source = "../modules/iam"
    project     = var.project
    account_id = var.account_id
    tf_serv_account_roles = var.tf_serv_account_roles

}