output "elb_id" {
  value = "${aws_elb.elb.id}"
}

output "elb_sg_id" {
  value = "${aws_security_group.elb-sg.id}"
}

output "elb_name" {
  value = "${aws_elb.elb.name}"
}

output "elb_dns_name" {
  value = "${aws_elb.elb.dns_name}"
}
