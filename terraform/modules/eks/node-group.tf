# Managed Node Group
resource "aws_eks_node_group" "main" {
  cluster_name = aws_eks_cluster.main.name

  node_group_name = "starttech-node-group"

  node_role_arn = aws_iam_role.node.arn

  ami_type = "AL2023_x86_64_STANDARD"

  subnet_ids = var.private_subnet_ids

  instance_types = var.instance_types

  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  update_config {
    max_unavailable = 1
  }

  # remote_access {
  #   ec2_ssh_key               = aws_key_pair.main.key_name
  #   source_security_group_ids = [aws_security_group.ssh.id]
  # }

  tags = merge(
    local.common_tags,
    {
      Name = "starttech-node-group"
    }
  )

  depends_on = [
    aws_eks_cluster.main,

    aws_iam_role_policy_attachment.worker_node,
    aws_iam_role_policy_attachment.ecr_readonly,
    aws_iam_role_policy_attachment.cni
  ]
}