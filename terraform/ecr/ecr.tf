resource "aws_ecr_repository" "eks-demo" {
  name = "eks-demo"
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "IMMUTABLE"
}