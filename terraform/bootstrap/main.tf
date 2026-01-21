provider "google" {
  credentials = file("")
  project     = var.project_id
  region      = var.region
}

module "artifact_registry" {
  source = "../modules/artifact_registry"
  repos = var.repos 
}

module "iam" {
    source = "../modules/iam"

}