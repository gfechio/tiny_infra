resource "aws_ecr_repository" "k8s_assignment" {
  count                = 1
  name                 = "k8s_assignment-${count.index}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
