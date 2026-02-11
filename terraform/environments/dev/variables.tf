variable "project" {
    type = string
}

variable "region" {
    type = string
}


#------------------------------------
# VPC Module
#------------------------------------
variable "vpc_name" {
    description = "Name of the VPC"
    type = string
}

variable "subnets" {
    description = "Subnets of the VPC"
    type = map(object({
        cidr = string
        region = string
    }))
}

variable "internal_source_ranges" {
    description = "The ip ranges whose resources can talk to each other"
    type = list(string)
}

#-------------------------------
# VPC Connector
#-------------------------------
variable "vpc_connector_name" {
    description = "Name of the vpc connector"
    type = string
}

variable "connector_subnet_cidr" {
    description = "CIDR of the vpc connector"
    type = string
}

#---------------------------------
# Cloud Run Service
#---------------------------------
variable "services" {
    type = map(object({
        name = string
        image = string
        cpu = string
        memory = string
        min_instances = number
        max_instances = number
        env_vars = map(string)
    }))
}

#---------------------------------
# Load Balancer
#---------------------------------
variable "lb_routes" {
    type = map(object({
        paths = list(string)
    }))
}

variable "lb_url_map_name" {
    description = "Name of url map"
    type = string
}

variable "lb_http_proxy_name" {
    description = "Name of the http proxy"
    type = string
}

variable "lb_forwarding_rule_name" {
    description = "Name of the forwarding rule"
    type = string
}

variable "lb_ip_name" {
    description = "Name of ip address reserved for load balancer"
    type = string
}