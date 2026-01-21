resource "google_artifact_registry_repository" "service_repos" {
    for_each = var.repos
    repository_id = "{each.value.name}-service"
    format = "DOCKER"
}