output "redis_instance_url" {
  value = "redis://${google_redis_instance.redis_instance.host}:${google_redis_instance.redis_instance.port}"
}
