resource "aws_ecr_repository" "k8s_assignment" {
  name                 = "k8s_assignment"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
