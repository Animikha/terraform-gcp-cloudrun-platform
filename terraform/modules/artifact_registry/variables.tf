variable "region" {
    type = string
}

variable "project_id" {
  type = string
}

variable "repos" {
    type = map(object({
      name = string
      description = string
    }))
}
