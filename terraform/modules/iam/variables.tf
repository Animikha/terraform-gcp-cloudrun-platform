variable "project" {
  type = string
}

variable "account_id" {
    type = string 
    description = "Account id of the service account"
} 

variable "tf_account_roles" {
    type = set(string)
    description = "IAM roles to assign to the service account"
}