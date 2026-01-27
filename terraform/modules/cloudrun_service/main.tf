resource "google_cloud_run_service" "services" {
    for_each = var.services

    name = each.key
    location = var.region
    project = var.project

    template {
        spec {
            containers {
                image = each.value.image

                resources {
                    limits = {
                        cpu = each.value.cpu
                        memory = each.value.memory
                    }
                }

                dynamic "env" {
                    for_each = each.value.env_vars
                    content {
                        name = env.key
                        value = env.value
                    }
                }
            }
        }

        metadata {
          annotations = {
            "autoscaling.knative.dev/minScale" = toString(each.value.min_instances)
            "autoscaling.knative.dev/maxScale" = toString(each.value.max_instances)
          }
        }
    }

    traffic {
        percent = 100
        latest_revision = true
    }
}