module "irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "keda-dev-role"

  oidc_providers = {
    this = {
      provider_arn               = data.terraform_remote_state.eks.outputs.oidc_provider_arn
      namespace_service_accounts = ["keda:keda"]
    }
  }

  policies = {
    sqs_policy = aws_iam_policy.sqs_policy.arn
  }
}

resource "aws_iam_policy" "sqs_policy" {
  name = "keda-dev-sqs-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:GetQueueAttributes"
        ]
        Resource = [
          module.sqs.queue_arn,
          module.sqs.dead_letter_queue_arn
        ]
      }
    ]
  })
}