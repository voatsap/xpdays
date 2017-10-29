# Template for initial configuration bash script
data "template_file" "init" {
  template = "${file("files/init.tpl")}"
  count = "${length(var.instance_suffix)}"
  
  vars {
    dbendpoint="${aws_db_instance.db-instance.username}:${aws_db_instance.db-instance.password}@${aws_db_instance.db-instance.endpoint}\\/${aws_db_instance.db-instance.name}"
    instancehostname="xpdays-${var.instance_suffix[count.index]}-${count.index}"
  }
}

resource "aws_launch_configuration" "launch-xpdays" {
#  name          = "${var.environment}-launch-xpdays${count.index + 1}"
   image_id      = "${data.aws_ami.xpdays-ami.id}"
   instance_type = "${lookup(var.instance_type, var.environment)}"
   iam_instance_profile = "${aws_iam_instance_profile.ec2-instance-profile.name}"
   associate_public_ip_address   = true
   enable_monitoring = true
   user_data = "${data.template_file.init.*.rendered[count.index]}"
  lifecycle {
    create_before_destroy = true
  }
  count = "${length(var.instance_suffix)}"
}

## Add Autoscaling group
resource "aws_autoscaling_group" "asg-xpdays" {
    lifecycle { create_before_destroy = true }
   # depends_on = ["aws_launch_configuration.launch-xpdays"]
    desired_capacity          = "${element(var.instance_count_xpdays_desired[var.environment],count.index)}"
    max_size                  = "${lookup(var.instance_count_xpdays_max, var.environment)}"
    min_size                  = "${lookup(var.instance_count_xpdays_min, var.environment)}"
    health_check_grace_period = 300
    health_check_type         = "EC2"
    launch_configuration      = "${element(aws_launch_configuration.launch-xpdays.*.name, count.index)}"
    name                      = "asg-xpdays${count.index + 1}-${var.environment}"
    availability_zones        = ["${lookup(var.default_subnet_availability_zone, var.environment)}"]
    vpc_zone_identifier       =  ["${list(aws_subnet.default_subnet.id)}"]
#    load_balancers            =  ["${module.m-elb-xpdays.elb_id}"]
    #wait_for_elb_capacity     = "${element(var.instance_count_xpdays_desired[var.environment],count.index)}"
#    enabled_metrics = "${var.asg_enabled_metrics}"

    tag {
        key   = "Name"
        value = "xpdays-${var.instance_suffix[count.index]}-${count.index}"
        propagate_at_launch = true
    }
 count     = "${length(var.instance_suffix)}"
}

