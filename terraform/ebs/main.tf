resource "aws_ebs_volume" "teamcity_data" {
    availability_zone = "ap-northeast-2a"
    size              = 30
    type              = "gp3"
}