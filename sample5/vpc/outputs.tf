output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "vpc_default_security_group" {
  value = "${aws_vpc.vpc.default_security_group_id}"
}

output "vpc_main_route_table_id" {
  value = "${aws_vpc.vpc.main_route_table_id}"
}

