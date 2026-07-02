data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "hyumin-tfstate"
    key    = "envs/dev/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

module "eks" {
  source = "../../../modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  my_ip_cidr      = var.my_ip_cidr

  instance_types = var.instance_types
  capacity_type  = var.capacity_type
  min_size       = var.min_size
  max_size       = var.max_size
  desired_size   = var.desired_size

  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnets = data.terraform_remote_state.vpc.outputs.private_subnets
  intra_subnets   = data.terraform_remote_state.vpc.outputs.intra_subnets
}