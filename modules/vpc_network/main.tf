resource "google_compute_network" "vpc" {
  name                    = "${var.resource_prefix}-vpc-${var.environment}"
  auto_create_subnetworks = false
}

resource "google_vpc_access_connector" "vpc_connector" {
  name          = "${var.resource_prefix}-connector-${var.environment}"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.vpc_connector_cidr
  depends_on    = [google_compute_network.vpc]
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.resource_prefix}-subnet-${var.environment}"
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  depends_on    = [google_compute_network.vpc]
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "${var.resource_prefix}-private-ip-${var.environment}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.name
  depends_on    = [google_compute_network.vpc]
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
  provider                = google-beta
  depends_on              = [google_compute_global_address.private_ip_address]
}
