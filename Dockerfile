# Dockerfile used to build the pre‑built base image:
#   registry.gitlab.com/animikha/terraform-gcp-cloudrun-platform/base-image:latest
#
# Note:
# - This base image is stored in GitLab’s Container Registry.
# - It is NOT built as part of this pipeline.
# - This pipeline only PULLS the image for use.

FROM google/cloud-sdk:latest
 
RUN apt-get update && apt-get install -y unzip wget \
  && wget https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_amd64.zip \
  && unzip terraform_1.9.5_linux_amd64.zip -d /usr/local/bin/ \
  && terraform version
