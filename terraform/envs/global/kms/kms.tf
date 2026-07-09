data "aws_caller_identity" "current" {}
 
resource "aws_kms_key" "sops" {
  description         = "KMS key for encrypt with sops"
  enable_key_rotation = false
  deletion_window_in_days = 7
  policy = jsonencode({
    Version : "2012-10-17"
    Id : "key-sops-1"
    Statement : [
      {
        Sid : "Enable IAM Application Permissions",
        Effect : "Allow",
        Principal : {
          AWS : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action : "kms:*",
        Resource : "*"
      }
    ]
  })
}

resource "aws_kms_alias" "sops" {
  target_key_id = aws_kms_key.sops.key_id
  name          = "alias/sops"
}

output "sops_kms_key_arn" {
  value = aws_kms_key.sops.arn
}