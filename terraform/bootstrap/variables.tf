variable "project" {
    type = string
}

variable "region" {
    type = string
}
#-------------------------------------------------
# IAM
#-------------------------------------------------
variable "account_id" {
    type = string 
    description = "Account id of the service account"
} 

variable "tf_serv_account_roles" {
    type = set(string)
    description = "IAM roles to assign to the service account"
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