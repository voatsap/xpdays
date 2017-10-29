resource "aws_db_subnet_group" "default_db_subnet_group" {
  name       = "main"
  subnet_ids = ["${var.default_db_subnet_group_subnet_ids[var.region]}"]
  tags {
    Name = "Default DB subnet group"
  }
}

resource "aws_db_instance" "db-instance" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.17"
  instance_class       = "db.t2.micro"
  name                 = "wisehandsdb"
  username             = "root"
  password             = "53N4CsNmQrxh2"
  db_subnet_group_name = "${aws_db_subnet_group.default_db_subnet_group.id}"
  final_snapshot_identifier = "snapshot-defaultdbinstance${count.index + 1}"
  skip_final_snapshot  = true
  publicly_accessible  = true
  tags {
      key   = "Name"
      value = "default-db-instance${count.index + 1}-${var.environment}"
    }
}

output "database_endpoint" {
  value = "${aws_db_instance.db-instance.username}:${aws_db_instance.db-instance.password}@${aws_db_instance.db-instance.endpoint}/${aws_db_instance.db-instance.name}"
}
