output "ecr_url" {
  description = "ECR Repo URL."
  value       = aws_ecr_repository.k8s_assignment.*.repository_url
}
