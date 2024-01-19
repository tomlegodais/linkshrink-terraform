resource "random_password" "postgres_root_password" {
  length           = 16
  special          = true
  override_special = "!#$^&*()[]{}"
}

resource "random_password" "app_user_password" {
  length           = 16
  special          = true
  override_special = "!#$^&*()[]{}"
}

resource "google_secret_manager_secret" "postgres_root_password_secret" {
  secret_id = "postgres-root-password-${var.environment}"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret" "app_user_password_secret" {
  secret_id = "app-user-password-${var.environment}"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "postgres_root_password_secret_version" {
  secret      = google_secret_manager_secret.postgres_root_password_secret.id
  secret_data = random_password.postgres_root_password.result
}

resource "google_secret_manager_secret_version" "app_user_password_secret_version" {
  secret      = google_secret_manager_secret.app_user_password_secret.id
  secret_data = random_password.app_user_password.result
}
