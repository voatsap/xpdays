## Get instance AMI
data "aws_ami" "xpdays-ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["xpdays-ami*"]
  }
}
