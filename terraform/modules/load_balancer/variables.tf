variable "project" {
    type = string
}

variable "region" {
    type = string
}

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

variable "vpc_self_link" {
    description = "Name of vpc"
    type = string
}

variable "lb_subnet_self_link" {
    description = "Name of subnet which would have the load balancer"
    type = string
}

variable "lb_ip_name" {
    description = "Name of ip address reserved for load balancer"
    type = string
}