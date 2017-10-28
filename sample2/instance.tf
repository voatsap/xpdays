## Define provider
provider "aws" {
	region = "${var.region}"
}

# Define the instance
resource "aws_instance" "test-ec2instance" {
	ami = "${data.aws_ami.ubuntu.id}"
	vpc_security_group_ids = [ "${var.vpc_security_group_ids[1]}" ]
	instance_type = "${lookup(var.instance_type, var.environment)}"
    count = 1
}
