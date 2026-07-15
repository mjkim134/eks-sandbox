module "irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "eks-demo-prod-role"

  oidc_providers = {
    this = {
      provider_arn               = data.terraform_remote_state.eks.outputs.oidc_provider_arn
      namespace_service_accounts = ["eks-demo:eks-demo"]
    }
  }

  policies = {
    sqs_policy = aws_iam_policy.sqs_policy.arn
  }
}

resource "aws_iam_policy" "sqs_policy" {
  name = "eks-demo-prod-sqs-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ]
        Resource = [
          module.sqs.queue_arn,
          module.sqs.dead_letter_queue_arn
        ]
      }
    ]
  })
}