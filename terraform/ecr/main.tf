resource "aws_ecr_repository" "tomcat_backbase" {
  name                 = "tomcat_backbase"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
