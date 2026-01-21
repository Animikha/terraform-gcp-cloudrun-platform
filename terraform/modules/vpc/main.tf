terraform {
  required_version = ">=1.5.0"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">=5.0.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region = var.region
}

#---------------------------------------------
# VPC
#----------------------------------------------

resource "google_compute_network" "vpc" {
  name = var.vpc_name
  auto_create_subnetworks = false
  routing_mode = var.routing_mode
  delete_default_routes_on_create = true
  description = "Strictly private internal VPC (no internet egress)"

}

#---------------------------------------------
# Subnets
#----------------------------------------------

resource "google_compute_subnetwork" "subnet" {
  for_each = var.subnets

  name = each.value.name
  ip_cidr_rage = each.value.cidr
  region = each.value.region
  network = google_compute_network.vpc.id

  # Alllow access to Google APIs from VMs without external IPs
  private_ip_google_access = true
}

#---------------------------------------------
# Firewall rule: Allows Internal
#---------------------------------------------

resource "google_compute_firewall" "allow_internal" {
  name = "${var.vpc_name}-allow-internal"
  network = google_compute_network.vpc.id

  direction = "INGRESS"
  priority = 1000

  source_ranges = var.internal_source_ranges

  allows {
    protocol = "tcp"
    ports = ["0-65535"]
  }

  allows {
    protocol = "udp"
    ports = ["0-65535"]
  }

  allows {
    protocol = "icmp"
  }
}

#--------------------------------------------------------
# Firewall rule: Allows TCP/22 only from Google IAP's IPs 
# to VMs that have a target tag (iap-ssh)
#--------------------------------------------------------

resource "google_compute_firewall" "allow_iap_ssh" {
  
  network = google_compute_network.vpc.id

}