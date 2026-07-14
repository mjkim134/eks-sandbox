module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"

  name = "eks-demo-prod-sqs"
  sqs_managed_sse_enabled = true
  
  create_dlq = true
}