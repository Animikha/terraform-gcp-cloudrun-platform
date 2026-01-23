output "repo_urls" {
    value = {
        for k, v in google_artifact_registry_repository.service_repos:
        k => "${v.location}-docker.pkg.dev/${var.project_id}/${v.repository_id}"
    }
}