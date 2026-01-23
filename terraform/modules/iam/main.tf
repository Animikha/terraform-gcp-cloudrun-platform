resource "google_service_account" "tf_service_account" {
    account_id = var.account_id
    display_name = "Terraform Service Account"
}

resource "google_project_iam_member" "tf_roles" {
    for_each = var.tf_account_roles
    project = var.project
    role = each.value
    member = "serviceAccount:${google_service_account.tf_service_account.email}"
}