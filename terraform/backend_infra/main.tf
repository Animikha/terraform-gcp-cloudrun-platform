terraform {
  backend "local" {}
}

provider "google" {
  project     = var.project
  region      = var.region
}

resource "google_storage_bucket" "tf_state" {
    for_each = var.backends
    name = "tf-state-${each.value}-tgcp"
    location = var.region
    force_destroy = false

    versioning {
        enabled = true
    }

    uniform_bucket_level_access = true

}