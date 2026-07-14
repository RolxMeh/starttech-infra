resource "aws_elasticache_cluster" "redis" {
  cluster_id = var.redis_name

  engine          = "redis"
  engine_version  = var.redis_engine_version
  node_type       = var.redis_node_type
  num_cache_nodes = 1

  port = 6379

  subnet_group_name = aws_elasticache_subnet_group.redis.name

  security_group_ids = [
    aws_security_group.redis.id
  ]

  apply_immediately = true

  tags = {
    Name        = var.redis_name
    Environment = var.environment
  }

  depends_on = [
    aws_elasticache_subnet_group.redis,
    aws_security_group.redis
  ]
}