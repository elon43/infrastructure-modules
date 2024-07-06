output "eks_name" {
  value = aws_eks_cluster.this.name
}

output "eks_security_group" {
  value = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}
