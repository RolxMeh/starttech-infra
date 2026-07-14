variable "frontend_bucket_name" {
  description = "Frontend S3 bucket"
  type        = string
}

variable "ecr_repository_name" {
  description = "Backend ECR repository"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "cloudfront_distribution_arn" {
  description = "CloudFront Distribution ARN allowed to access the bucket"
  type        = string
  default     = ""
}
