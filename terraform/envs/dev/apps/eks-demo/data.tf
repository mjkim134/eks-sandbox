data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "eks-sandbox-apne2-tfstate"
    key    = "envs/dev/eks/terraform.tfstate"
    region = "ap-northeast-2"
  }
}