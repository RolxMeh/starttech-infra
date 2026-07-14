resource "aws_elasticache_subnet_group" "redis" {
  name        = "${var.redis_name}-subnet-group"
  description = "Subnet group for Redis"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.redis_name}-subnet-group"
    Environment = var.environment
  }
}