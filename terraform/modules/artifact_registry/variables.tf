variable "region" {
    type = string
}

variable "project" {
  type = string
}

variable "repos" {
    type = map(object({
      name = string
      description = string
    }))
}
