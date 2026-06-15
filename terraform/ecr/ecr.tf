resource "aws_ecr_repository" "eks-demo" {
  name = "eks-demo"
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "IMMUTABLE"
}

resource "aws_ecr_repository_policy" "eks-demo" {
  repository = aws_ecr_repository.eks-demo.name
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
          ]
        },
        "Action" : [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages"
        ]
      }
    ]
  })
}