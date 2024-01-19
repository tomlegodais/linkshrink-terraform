output "postgres_root_password_secret_id" {
  value = google_secret_manager_secret.postgres_root_password_secret.secret_id
}

output "app_user_password_secret_id" {
  value = google_secret_manager_secret.app_user_password_secret.secret_id
}
