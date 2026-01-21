variable "project_id" {
    type = string
}

variable "region" {
    type = string
}

#-------------------------------------------------
# Artifact Registry
#-------------------------------------------------
variable "repos" {
    type = map(object({
      name = string
      description = string
    }))
}