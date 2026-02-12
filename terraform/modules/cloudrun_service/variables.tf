variable "project" {
    type = string
}

variable "region" {
    type = string
}

variable "services" {
    type = map(object({
        image = string
        cpu = string
        memory = string
        min_instances = number
        max_instances = number
        env_vars = map(string)
    }))
}

variable "vpc_connector" {
    type = string
}