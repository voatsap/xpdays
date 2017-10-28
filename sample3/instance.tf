## Define provider
provider "aws" {
	region = "${var.region}"
}

# Define the instance
resource "aws_instance" "xpdays-instance" {
	ami = "${data.aws_ami.xpdays-ami.id}"
	vpc_security_group_ids = [ "${var.vpc_security_group_ids}" ]
	instance_type = "${lookup(var.instance_type, var.environment)}"
user_data = <<EOF
#!/bin/bash
hostname xpdays${count.index + 1} && hostname > /etc/hostname 
echo "127.0.0.1 localhost xpdays1" > /etc/hosts
cd /home/ubuntu
git clone https://bitbucket.org/bohdaq/wisehands.me.git
cd /home/ubuntu/wisehands.me/ && play deps
mkdir -p /home/ubuntu/wisehands.me/modules/guice-1.2
cd /home/ubuntu/wisehands.me/modules/guice-1.2
wget https://www.playframework.com/modules/guice-1.2.zip
unzip guice-1.2.zip
sed -i 's/mysql-database-endpoint/${aws_db_instance.db-instance.username}:${aws_db_instance.db-instance.password}@${aws_db_instance.db-instance.endpoint}\/${aws_db_instance.db-instance.name}/g' /home/ubuntu/wisehands.me/conf/application.conf
cd /home/ubuntu/wisehands.me/ && play run
EOF
    tags {
        Name = "xpdays${count.index + 1}"
    }

    count = 1
}

## Print Output
output "xpdays_instance_public_ip" {
	  value = "${join(",",aws_instance.xpdays-instance.*.public_ip)}"
	
}

