variable "project_id" {
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
