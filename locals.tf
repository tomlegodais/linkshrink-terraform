locals {
  provider_config = {
    gcp = {
      credentials = var.gcp_tf_infra_operator_key
      project     = var.project_id
      region      = var.region
    }
  }
  dockerimage = {
    service_url = "${var.region}-docker.pkg.dev/${var.project_id}/linkshrink-service/linkshrink:${var.service_version}"
  }
}
