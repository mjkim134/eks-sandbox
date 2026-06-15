resource "aws_iam_role" "github-actions-iam" {
  name               = "github-actions-iam"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role_document.json
}

data "aws_iam_policy_document" "github_actions_assume_role_document" {
  statement {
    effect = "Allow"

    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:mjkim134/eks-sandbox:*",
      ]
    }

    actions = ["sts:AssumeRoleWithWebIdentity", ]
  }
}

resource "aws_iam_role_policy" "github-actions-ecr" {
  name   = "github-actions-ecr"
  role   = aws_iam_role.github-actions-iam.id
  policy = data.aws_iam_policy_document.github_actions_ecr.json

}

data "aws_iam_policy_document" "github_actions_ecr" {
  statement {
    sid       = "AllowGetAuthTokenAccess"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowReadECRAccess"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
    resources = ["*"]
  }
}

output "github_actions_arn" {
  value = aws_iam_role.github-actions-iam.arn
}
