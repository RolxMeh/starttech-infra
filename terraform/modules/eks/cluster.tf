# Create the EKS Cluster
resource "aws_eks_cluster" "main" {
  name = var.cluster_name

  role_arn = aws_iam_role.cluster.arn

  version = var.cluster_version

  vpc_config {
    subnet_ids = var.private_subnet_ids

    security_group_ids = [
      aws_security_group.cluster.id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  tags = {
    Name        = var.cluster_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy
  ]
}