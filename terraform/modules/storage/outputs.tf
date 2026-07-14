output "bucket_id" {
  value = aws_s3_bucket.frontend.id
}

output "bucket_arn" {
  description = "ARN of the frontend bucket"
  value       = aws_s3_bucket.frontend.arn
}

output "bucket_name" {
  description = "Frontend S3 bucket name"
  value       = aws_s3_bucket.frontend.bucket
}

output "bucket_regional_domain_name" {
  description = "Regional domain name of the frontend S3 bucket"
  value       = aws_s3_bucket.frontend.bucket_regional_domain_name
}

output "ecr_repository_name" {
  value = aws_ecr_repository.backend.name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.backend.repository_url
}
