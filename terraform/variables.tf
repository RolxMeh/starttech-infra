# variable "my_ip" {
#   description = "Public IP allowed to SSH into worker nodes"
#   type        = string
# }
#
# variable "key_name" {
#   description = "SSH key pair name"
#   type        = string
#   default     = "starttech-key"
# }
#
# variable "public_key_path" {
#   description = "Path to the public SSH key"
#   type        = string
#   default     = "~/.ssh/id_ed25519.pub"
# }

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.34"
}

variable "aws_region" {
  description = "AWS region where infrastructure will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "production"

}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"

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
  default     = "starttech-frontend-ayotunde"
}

variable "ecr_repository_name" {
  description = "Backend ECR repository name"
  type        = string
  default     = "starttech-backend-api"
}

variable "redis_name" {
  description = "Redis cluster name"
  type        = string
  default     = "starttech-redis"
}