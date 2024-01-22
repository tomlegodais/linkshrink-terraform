# linkshrink-terraform

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Configuration Steps](#configuration-steps)
  - [Terraform Cloud Setup](#1-terraform-cloud-setup)
  - [Workspace Creation](#2-workspace-creation)
  - [GCP Service Account](#3-gcp-service-account)
  - [Terraform Cloud Configuration](#4-terraform-cloud-configuration)
  - [Terraform Configuration](#5-terraform-configuration)
  - [Initialization and Deployment](#6-initialization-and-deployment)
  - [Workspace Switching](#7-workspace-switching)
- [Usage](#usage)
- [Contribution](#contribution)

## Overview
`linkshrink-terraform` is a Terraform project for provisioning and deploying the LinkShrink Web App and its backend API on Google Cloud Platform (GCP). This project uses Terraform Cloud for remote state management and follows the principle of one project per environment in GCP.

## Prerequisites
- Terraform installed locally
- A GCP account with appropriate permissions
- Terraform Cloud account

## Configuration Steps

### 1. Terraform Cloud Setup
- Run `terraform login` and follow the instructions to authenticate your Terraform CLI with Terraform Cloud.

### 2. Workspace Creation
- Create workspaces in Terraform Cloud for each environment, e.g., `linkshrink-dev`, `linkshrink-prod`.

### 3. GCP Service Account
- In each GCP project (e.g., `linkshrink-dev`, `linkshrink-prod`), create a service account named `gcp-tf-infra-operator`.
- Assign the following roles to this account:
  - Artifact Registry Administrator
  - Cloud Memorystore Redis Admin
  - Cloud Run Admin
  - Cloud SQL Admin
  - DNS Administrator
  - Secret Manager Admin
  - Serverless VPC Access Admin
  - Serverless VPC Access Service Agent
  - Service Account User
  - Service Networking Service Agent
- Generate a private key (JSON format) for this service account.

### 4. Terraform Cloud Configuration
For each workspace in Terraform Cloud, set the following variables:
- `environment`: The deployment environment (e.g., `prod`)
- `gcp_tf_infra_operator_key`: The raw JSON key of the GCP service account
- `project_id`: The GCP project ID (e.g., `linkshrink-prod`)
- `region`: The GCP region for resource deployment (e.g., `us-east1`)
- `service_version`: The version of the Docker image `linkshrink-service` to deploy (e.g., `v1.0.0`)
- `web_app_version`: The version of the Docker image `linkshrink-web-app` to deploy (e.g., `v1.0.0`)
- `subnet_cidr`: CIDR for the VPC Subnet (e.g., `10.0.0.0/24`)
- `vpc_connector_cidr`: CIDR for the VPC Connector (e.g., `10.0.1.0/28`)

### 5. Terraform Configuration
- Edit `providers.tf` to configure the remote backend with your Terraform Cloud organization name and workspace prefix.

### 6. Initialization and Deployment
- Run `terraform init`. Select a workspace if prompted.
- Execute `terraform plan` and `terraform apply` to deploy resources.

### 7. Workspace Switching
- To switch workspaces, use `terraform workspace select <workspace>`.

## Usage
After completing the setup, you can manage your GCP resources for each environment by switching between Terraform Cloud workspaces and running Terraform commands as needed.

## Contribution
Contributions to `linkshrink-terraform` are welcome. Please follow the standard Git workflow for submitting changes.
