resource "aws_ecr_repository" "eks-sandbox" {
  name = "eks-sandbox"
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "IMMUTABLE"
}