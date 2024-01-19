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
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "linkshrink"
    workspaces {
      prefix = "linkshrink-"
    }
  }
}

provider "google" {
  credentials = local.provider_config.gcp.credentials
  project     = local.provider_config.gcp.project
  region      = local.provider_config.gcp.region
}

provider "google-beta" {
  credentials = local.provider_config.gcp.credentials
  project     = local.provider_config.gcp.project
  region      = local.provider_config.gcp.region
}
