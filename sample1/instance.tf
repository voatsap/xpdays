## Define provider
provider "aws" {
	region = "eu-central-1"
}

## Get instance AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-16.04-amd64-server-*"]
  }
}
# Define the instance
resource "aws_instance" "test-ec2instance" {
	ami = "${data.aws_ami.ubuntu.id}"
	instance_type = "t2.micro"
}
