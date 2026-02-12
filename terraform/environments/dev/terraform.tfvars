project = "tough-history-483510-h3"
region = "europe-west2"

#------------------------------------
# VPC Module
#------------------------------------
vpc_name = "vpc-tgcp"

subnets = {
    subnet-1 = {
        cidr = "10.10.1.0/24"
        region = "europe-west2"
    }

    subnet-2 = {
        cidr = "10.10.2.0/24"
        region = "europe-west2"
    }
}

internal_source_ranges = ["10.10.1.0/24", "10.10.2.0/24"]

#-------------------------------
# VPC Connector
#-------------------------------
vpc_connector_name = "vpc-connector-tgcp"
connector_subnet_cidr = "10.10.8.0/28"


#---------------------------------
# Cloud Run Service
#---------------------------------
services = {
    frontend = {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        cpu = "1"
        memory = "512Mi"
        min_instances = 1
        max_instances = 1

        env_vars = {
            SERVICE_NAME = "frontend"
            LOG_LEVEL = "info"
        }
    }

    auth = {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        cpu = "1"
        memory = "512Mi"
        min_instances = 1
        max_instances = 1

        env_vars = {
            SERVICE_NAME = "auth"
            LOG_LEVEL = "info"
        }
    }

    api = {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        cpu = "1"
        memory = "512Mi"
        min_instances = 1
        max_instances = 1

        env_vars = {
            SERVICE_NAME = "api"
            LOG_LEVEL = "info"
        }
    }
}

#---------------------------------
# Load Balancer
#---------------------------------
lb_routes = {
    frontend = {
        paths = ["/login/*"]
    }

    auth = {
        paths = ["/auth/*"]
    }

    api = {
        paths = ["/api/*"]
    }
}

lb_url_map_name = "lb-url-map-tgcp"
lb_http_proxy_name = "http-proxy-tgcp"
lb_forwarding_rule_name = "lb-forwarding-rul-tgcp"
lb_ip_name = "lb-ip-tgcp"
