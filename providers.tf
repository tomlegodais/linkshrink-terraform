terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>5"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~>4"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3"
    }
  }
  backend "gcs" {
    bucket  = "linkshrink-terraform-state"
    prefix  = "terraform/state"
  }
}

provider "google" {
  credentials = local.provider_config.gcp.credentials
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  credentials = local.provider_config.gcp.credentials
  project     = var.project_id
  region      = var.region
}
