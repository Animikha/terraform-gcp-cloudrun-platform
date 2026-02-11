project = "tough-history-483510-h3"
region = "europe-west2"


#-------------------------------------------------
# IAM
#-------------------------------------------------
account_id = "terraform-service-account"

tf_serv_account_roles = toset([
    "roles/compute.admin",
    "roles/artifactregistry.writer",
    "roles/artifactregistry.reader",
    "roles/storage.objectAdmin",
    "roles/iam.serviceAccountUser"

])

#-------------------------------------------------
# Artifact Registry
#-------------------------------------------------
repos = {
    frontend = {
        name = "frotend"
        description = "UI of the application"
    }

    auth = {
        name = "auth"
        description = "Authentication of the application"
    }

    api = {
        name = "api"
        description = "APIs of the application"
    }
    

}