resource "aws_elb" "elb" {
  name            = "${var.elb_name}"
  subnets         = ["${var.subnet_az1}", "${var.subnet_az2}"]
  internal        = "${var.elb_is_internal}"
  security_groups = ["${aws_security_group.elb-sg.id}"]

    listener {
      instance_port = "${var.backend_port}"
      instance_protocol = "${var.backend_protocol}"
      lb_port = 443
      lb_protocol = "https"
      ssl_certificate_id = "${var.ssl_certificate_id}"
    }

  listener {
    instance_port     = "${var.backend_port}"
    instance_protocol = "${var.backend_protocol}"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.health_check_target}"
    interval            = 30
  }
  cross_zone_load_balancing = true
}

resource "aws_security_group" "elb-sg" {
  vpc_id      = "${var.vpc_id}"
  name        = "elb-sg-${var.elb_name}"
  description = "Security Group for ELB"
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb-sg.id}"
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb-sg.id}"
}

resource "aws_security_group_rule" "allow_outbound_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb-sg.id}"
}

