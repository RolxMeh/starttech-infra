variable "my_ip" {
  description = "Public IP allowed to SSH into worker nodes"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region where infrastructure will be deployed."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the backend Application Load Balancer"
  type        = string
  default     = ""
}

variable "instance_types" {
  description = "EKS worker node instance types"

  # NOTE:
  # Using t3.micro during development because this AWS account
  # is restricted to Free Tier. Change back to ["t3.medium"]
  # before final submission to match the assessment requirements.
  default = ["t3.micro"]
}

variable "desired_size" {
  type    = number
  default = 3
}

variable "min_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 3
}

variable "frontend_bucket_name" {
  description = "Frontend S3 bucket name"
  type        = string
}

variable "ecr_repository_name" {
  description = "Backend ECR repository name"
  type        = string
}

variable "redis_name" {
  description = "Redis cluster name"
  type        = string
}