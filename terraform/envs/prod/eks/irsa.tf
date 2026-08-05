data "terraform_remote_state" "sqs" {
  backend = "s3"

  config = {
    bucket = "eks-sandbox-apne2-tfstate"
    key    = "envs/prod/apps/eks-demo/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

module "keda_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "${var.cluster_name}-keda-role"
  use_name_prefix = false

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
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
          data.terraform_remote_state.sqs.outputs.queue_arn,
          data.terraform_remote_state.sqs.outputs.dead_letter_queue_arn
        ]
      }
    ]
  })
}

module "eks_demo_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "${var.cluster_name}-eks-demo-role"
  use_name_prefix = false

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["eks-demo:eks-demo"]
    }
  }

  policies = {
    sqs_policy = aws_iam_policy.eks_demo_policy.arn
  }
}

resource "aws_iam_policy" "eks_demo_policy" {
  name = "${var.cluster_name}-eks-demo-policy"
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
          data.terraform_remote_state.sqs.outputs.queue_arn,
          data.terraform_remote_state.sqs.outputs.dead_letter_queue_arn
        ]
      }
    ]
  })
}