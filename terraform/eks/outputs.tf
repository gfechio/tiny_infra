output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = aws_eks_cluster.eks_backbase.endpoint
}

output "cluster_name" {
  description = "Endpoint for EKS control plane."
  value       = aws_eks_cluster.eks_backbase.name
}

