output "cloud_run_service_url" {
  value = google_cloud_run_v2_service.deployment.uri
}

output "cloud_run_web_app_url" {
  value = google_cloud_run_v2_service.web_deployment.uri
}
