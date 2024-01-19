output "database_name" {
  value = google_sql_database.postgres_db.name
}

output "database_user" {
  value = google_sql_user.app_user.name
}

output "database_host" {
  value = google_sql_database_instance.postgres_instance.private_ip_address
}
