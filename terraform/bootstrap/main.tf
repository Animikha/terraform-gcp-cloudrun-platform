module "vpc" {
    source = "../modules/vpc"
}

module "artifact_registry" {
    source = "../modules/artifact_registry"
}

module "iam" {
    source = "../modules/iam"
}