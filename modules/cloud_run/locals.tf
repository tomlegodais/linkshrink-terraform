data "google_secret_manager_secret_version" "app_user_password" {
  secret  = var.postgres_db.password_secret_id
  version = "latest"
}

locals {
  postgres = {
    url = "postgresql://${var.postgres_db.username}:${data.google_secret_manager_secret_version.app_user_password.secret_data}@${var.postgres_db.host}/${var.postgres_db.name}"
  }
}