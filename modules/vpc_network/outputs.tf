output "name" {
  value       = google_compute_network.vpc.name
  description = "The name of the VPC network"
}

output "self_link" {
  value       = google_compute_network.vpc.self_link
  description = "The URI of the VPC network"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "The name of the subnet"
}

output "vpc_connector" {
  value       = google_vpc_access_connector.vpc_connector.id
  description = "The name of the VPC connector"
}
