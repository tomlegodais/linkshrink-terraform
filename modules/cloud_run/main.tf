resource "google_cloud_run_v2_job" "migration_job" {
  name     = "${var.name}-service-migration-${var.environment}"
  location = var.region
  project  = var.project_id
  template {
    template {
      containers {
        image   = var.service_dockerimage
        command = ["sh", "-c", "alembic upgrade head"]
        env {
          name  = "POSTGRES_URL"
          value = local.postgres.url
        }
      }
      vpc_access {
        connector = var.vpc_connector
        egress    = "ALL_TRAFFIC"
      }
    }
  }
}

resource "google_cloud_run_v2_service" "deployment" {
  name     = "${var.name}-service-${var.environment}"
  location = var.region
  project  = var.project_id
  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }
    containers {
      image = var.service_dockerimage
      ports {
        container_port = 8000
      }
      env {
        name  = "POSTGRES_URL"
        value = local.postgres.url
      }
      env {
        name  = "REDIS_URL"
        value = var.redis_url
      }
    }
    vpc_access {
      connector = var.vpc_connector
      egress    = "ALL_TRAFFIC"
    }
  }
  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }
}

resource "google_cloud_run_v2_service_iam_policy" "noauth" {
  location = google_cloud_run_v2_service.deployment.location
  project  = google_cloud_run_v2_service.deployment.project
  name     = google_cloud_run_v2_service.deployment.name
  policy_data = jsonencode({
    bindings = [
      {
        role    = "roles/run.invoker"
        members = ["allUsers"]
      }
    ]
  })
  depends_on = [google_cloud_run_v2_service.deployment]
}

resource "google_cloud_run_domain_mapping" "api_domain_mapping" {
  location = var.region
  name     = var.environment != "prod" ? "${var.environment}.api.lshr.ink" : "api.lshr.ink"
  metadata {
    namespace = var.project_id
  }
  spec {
    route_name = google_cloud_run_v2_service.deployment.name
  }
  depends_on = [google_cloud_run_v2_service.deployment]
}

resource "google_cloud_run_v2_service" "web_deployment" {
  name     = "${var.name}-web-${var.environment}"
  location = var.region
  project  = var.project_id
  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }
    containers {
      image = var.web_app_dockerimage
      ports {
        container_port = 3000
      }
      env {
        name  = "API_BASE_URL"
        value = google_cloud_run_v2_service.deployment.uri
      }
    }
    vpc_access {
      connector = var.vpc_connector
      egress    = "ALL_TRAFFIC"
    }
  }
  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }
  depends_on = [google_cloud_run_v2_service.deployment]
}

resource "google_cloud_run_v2_service_iam_policy" "web_noauth" {
  location = google_cloud_run_v2_service.web_deployment.location
  project  = google_cloud_run_v2_service.web_deployment.project
  name     = google_cloud_run_v2_service.web_deployment.name
  policy_data = jsonencode({
    bindings = [
      {
        role    = "roles/run.invoker"
        members = ["allUsers"]
      }
    ]
  })
  depends_on = [google_cloud_run_v2_service.web_deployment]
}

resource "google_cloud_run_domain_mapping" "web_domain_mapping" {
  location = var.region
  name     = var.environment != "prod" ? "${var.environment}.lshr.ink" : "lshr.ink"
  metadata {
    namespace = var.project_id
  }
  spec {
    route_name = google_cloud_run_v2_service.web_deployment.name
  }
  depends_on = [google_cloud_run_v2_service.web_deployment]
}