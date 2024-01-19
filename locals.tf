locals {
  provider_config = {
    gcp = {
      credentials = file("env/${var.environment}/gcp-tf-infra-operator-key.json")
      project     = var.project_id
      region      = var.region
    }
  }
  dockerimage = {
    service_url = "${var.region}-docker.pkg.dev/${var.project_id}/linkshrink-service/linkshrink:${var.service_version}"
  }
}
