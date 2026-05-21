# data "aws_iam_policy_document" "loki_s3" {
#   # Bucket 자체 조회 권한
#   statement {
#     sid    = "LokiBucketAccess"
#     effect = "Allow"

#     actions = [
#       "s3:ListBucket",
#       "s3:GetBucketLocation"
#     ]

#     resources = [
#       aws_s3_bucket.loki.arn
#     ]
#   }
# }