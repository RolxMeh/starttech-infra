output "cluster_role_arn" {
  description = "IAM role ARN for the EKS control plane."

  value = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  description = "IAM role ARN for the EKS worker nodes."

  value = aws_iam_role.node.arn
}

output "cluster_security_group_id" {
  description = "EKS cluster security group ID"

  value = aws_security_group.cluster.id
}

output "node_security_group_id" {
  description = "EKS worker node security group ID"

  value = aws_security_group.nodes.id
}

output "cluster_name" {
  description = "EKS Cluster Name"

  value = aws_eks_cluster.main.name
}

output "cluster_arn" {
  description = "EKS Cluster ARN"

  value = aws_eks_cluster.main.arn
}

output "cluster_endpoint" {
  description = "EKS API Endpoint"

  value = aws_eks_cluster.main.endpoint
}

output "cluster_certificate_authority" {
  description = "Cluster certificate authority"

  value = aws_eks_cluster.main.certificate_authority[0].data
}

output "node_grouxp_name" {
  description = "EKS Managed Node Group"

  value = aws_eks_node_group.main.node_group_name
}

