module "keda_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "${var.cluster_name}-keda-role"
  use_name_prefix = false

  oidc_providers = {
    this = {
      provider_arn               = data.terraform_remote_state.eks.outputs.oidc_provider_arn
      namespace_service_accounts = [
        "keda:keda-metrics-server",
        "keda:keda-operator"
        ]
    }
  }

  policies = {
    sqs_policy = aws_iam_policy.keda_policy.arn
  }
}

resource "aws_iam_policy" "keda_policy" {
  name = "${var.cluster_name}-keda-policy"
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