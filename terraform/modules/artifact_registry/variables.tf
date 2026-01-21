variable "repos" {
    type = map(object({
      name = string
      description = string
    }))
}