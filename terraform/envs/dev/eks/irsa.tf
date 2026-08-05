data "terraform_remote_state" "sqs" {
  backend = "s3"

  config = {
    bucket = "eks-sandbox-apne2-tfstate"
    key    = "envs/dev/apps/eks-demo/terraform.tfstate"
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

resource "aws_iam_role" "loki_role" {
  name = "eks-sandbox-dev-loki-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${module.eks.oidc_provider_arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${module.eks.oidc_provider_arn}:aud" : "sts.amazonaws.com",
            "${module.eks.oidc_provider_arn}:sub" : "system:serviceaccount:monitoring:loki"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "loki_policy" {
  name        = "eks-sandbox-dev-loki-policy"
  path        = "/"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": "arn:aws:s3:::eks-sandbox-dev-loki"
        },
        {
            "Sid": "List",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion"
            ],
            "Resource": "arn:aws:s3:::eks-sandbox-dev-loki/*"
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "loki_role_policy_attachment" {
  policy_arn = aws_iam_policy.loki_policy.arn
  role       = aws_iam_role.loki_role.name
}