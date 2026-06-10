data "aws_ami" "ubuntu" {
    most_recent = true
    owners      = ["099720109477"]

    filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-noble-24.04-amd64-server-*"]
    }

    filter {
    name   = "virtualization-type"
    values = ["hvm"]
    }
}

resource "aws_instance" "teamcity_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.medium"
  subnet_id     = module.vpc.private_subnets[0]

  instance_market_options {
    market_type = "spot"
  }
}

resource "aws_ebs_volume" "teamcity_data" {
    availability_zone = module.vpc.azs[0]
    size              = 30
    type              = "gp3"
}

resource "aws_volume_attachment" "teamcity_data" {
    device_name = "/dev/sdf"
    volume_id   = aws_ebs_volume.teamcity_data.id
    instance_id = aws_instance.teamcity_server.id
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"
  
  name = "teamcity-dev-vpc"
  cidr = "10.121.0.0/22"

  enable_dns_hostnames = true
  enable_dns_support   = true

  azs             = ["ap-northeast-2a", "ap-northeast-2c"]
  private_subnets = ["10.121.0.0/24", "10.121.1.0/24"]
  public_subnets  = ["10.121.2.0/24", "10.121.3.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.ap-northeast-2.s3"
  route_table_ids = module.vpc.private_route_table_ids
}