terraform {
    backend "gcs" {
        bucket = "tf-state-bootstrap-tgcp"
        prefix = "state"
    }
}