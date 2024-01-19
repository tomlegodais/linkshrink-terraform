data "google_secret_manager_secret_version" "postgres_root_password_secret" {
  secret  = var.postgres_root_password_secret_id
  version = "latest"
}

data "google_secret_manager_secret_version" "app_user_password_secret" {
  secret  = var.app_user_password_secret_id
  version = "latest"
}

resource "google_sql_database_instance" "postgres_instance" {
  name             = "${var.database_name}-postgres-instance-${var.environment}"
  database_version = "POSTGRES_13"
  region           = var.region
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      private_network = var.vpc_self_link
    }
  }
  root_password       = data.google_secret_manager_secret_version.postgres_root_password_secret.secret_data
  deletion_protection = false
}

resource "google_sql_database" "postgres_db" {
  name     = var.database_name
  instance = google_sql_database_instance.postgres_instance.name
}

resource "google_sql_user" "app_user" {
  name     = "${var.database_name}-app-user"
  instance = google_sql_database_instance.postgres_instance.name
  password = data.google_secret_manager_secret_version.app_user_password_secret.secret_data
}
