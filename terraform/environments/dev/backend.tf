terraform {
    backend "gcs" {
        bucket = "tf-state-dev-tgcp"
        prefix = "state"
    }
}