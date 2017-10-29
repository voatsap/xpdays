## Create LoadBalancer
module "m-elb-xpdays" {
  source           = "./elb"
  elb_name         = "elb-xpdays"
  vpc_id           = "${module.vpc.vpc_id}"
  subnet_az1       = "${aws_subnet.default_subnet.id}"
  subnet_az2       = "${aws_subnet.default_subnet.id}"
  backend_port     = "3334"
  backend_protocol = "http"

  #  ssl_certificate_id = "${data.aws_acm_certificate.wisehands.me.arn}"
  health_check_target = "HTTP:3334/"

  #  elb_security_group = "${aws_security_group.elb-sg.id}"
}

## Add rule for access to ELB SG into default SG
resource "aws_security_group_rule" "allow_3334_xpdays" {
  type                     = "ingress"
  from_port                = 3334
  to_port                  = 3334
  protocol                 = "tcp"
  source_security_group_id = "${module.m-elb-xpdays.elb_sg_id}"
  security_group_id        = "${module.vpc.vpc_default_security_group}"
}
