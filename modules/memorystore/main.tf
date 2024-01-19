resource "google_redis_instance" "redis_instance" {
  name               = "${var.name}-redis-instance-${var.environment}"
  region             = var.region
  tier               = "BASIC"
  memory_size_gb     = 1
  authorized_network = var.vpc_self_link
}
