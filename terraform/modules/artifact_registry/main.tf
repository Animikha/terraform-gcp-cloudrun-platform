resource "google_artifact_registry_repository" "service_repos" {
    for_each = var.repos
    location = var.region
    repository_id = each.value.name
    description = each.value.description
    format = "DOCKER"

    docker_config {
      immutable_tags = false
    }
}