variable "project_id" {
    type = string
}

variable "region" {
    type = string
}


variable "routing_mode" {
    type = string
    default = "REGIONAL"
}


variable "subnets" {
    type = map(object({
        name = string
        cidr = string
        region = string
    }))
}

