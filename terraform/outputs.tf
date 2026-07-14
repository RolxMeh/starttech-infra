output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.networking.private_subnet_ids
}

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

# output "bucket_name" {
#   description = "Frontend S3 bucket"
#   value       = module.storage.bucket_name
# }

output "ecr_repository_url" {
  description = "Backend ECR Repository URL"
  value       = module.storage.ecr_repository_url
}

output "redis_endpoint" {
  description = "Redis endpoint"
  value       = module.database.redis_endpoint
}

output "redis_port" {
  value = module.database.redis_port
}

output "frontend_bucket_name" {
  value = module.storage.bucket_name
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain"
  value       = module.cdn.cloudfront_domain_name
}

# output "cloudfront_domain_name" {
#   description = "CloudFront Distribution Domain Name"
#   value       = module.cdn.cloudfront_domain_name
# }

