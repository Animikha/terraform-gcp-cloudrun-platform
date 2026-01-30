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

