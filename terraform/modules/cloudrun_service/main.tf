resource "google_cloud_run_v2_service" "services" {
  for_each = var.services
 
  name     = each.key
  location = var.region
  project  = var.project

  deletion_protection = false
 
  template {
    containers {
      image = each.value.image
 
      resources {
        limits = {
          cpu    = each.value.cpu
          memory = each.value.memory
        }
      }
 
      dynamic "env" {
        for_each = each.value.env_vars
        content {
          name  = env.key
          value = env.value
        }
      }
    }
 
    scaling {
      min_instance_count = each.value.min_instances
      max_instance_count = each.value.max_instances
    }
 
    dynamic "vpc_access" {
      for_each = var.vpc_connector == null ? [] : [1]
      content {
        connector = var.vpc_connector
        egress    = "ALL_TRAFFIC"
      }
    }
  }
 
  ingress = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
} 