provider "aws" {
  region = "${lookup(var.region, var.environment)}"
}

module "vpc" {
  source               = "./vpc"
  name                 = "${var.environment}"
  cidr                 = "${lookup(var.vpc_cidr, var.environment)}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name          = "${var.environment}"
    "Environment" = "${var.environment}"
  }
}

resource "aws_subnet" "default_subnet" {
  vpc_id                  = "${module.vpc.vpc_id}"
  cidr_block              = "${lookup(var.default_subnet_cidr_block, var.environment)}"
  availability_zone       = "${lookup(var.default_subnet_availability_zone, var.environment)}"
  map_public_ip_on_launch = true

  tags {
    Name          = "default-subnet-${var.environment}"
    "Environment" = "${var.environment}"
  }
}
resource "aws_subnet" "default_db_subnet" {
  vpc_id                  = "${module.vpc.vpc_id}"
  cidr_block              = "${lookup(var.default_db_subnet_cidr_block, var.environment)}"
  availability_zone       = "${lookup(var.default_db_subnet_availability_zone, var.environment)}"
  map_public_ip_on_launch = true

  tags {
    Name          = "default-db-subnet${var.environment}"
    "Environment" = "${var.environment}"
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = "${module.vpc.vpc_id}"

  tags {
    Name          = "${var.environment}"
    "Environment" = "${var.environment}"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = "${module.vpc.vpc_main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.vpc.vpc_default_security_group}"
}

resource "aws_security_group_rule" "allow_icmp" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.vpc.vpc_default_security_group}"
}

