# Template for initial configuration bash script
data "template_file" "init" {
  template = "${file("files/init.tpl")}"
  count = "${length(var.instance_suffix)}"
  
  vars {
    dbendpoint="${aws_db_instance.db-instance.username}:${aws_db_instance.db-instance.password}@${aws_db_instance.db-instance.endpoint}\\/${aws_db_instance.db-instance.name}"
    instancehostname="xpdays-${var.instance_suffix[count.index]}-${count.index}"
  }
}

# Define the instance
resource "aws_instance" "xpdays-instance" {
    ami = "${data.aws_ami.xpdays-ami.id}"
    vpc_security_group_ids = [ "${var.vpc_security_group_ids}" ]
    instance_type = "${lookup(var.instance_type, var.environment)}"
    user_data = "${data.template_file.init.*.rendered[count.index]}" 

    tags {
        Name = "xpdays${count.index + 1}"
    }

    count = "${length(var.instance_suffix)}"
}

## Print Output
output "xpdays_instance_public_ip" {
	  value = "${join(",",aws_instance.xpdays-instance.*.public_ip)}"
	
}
