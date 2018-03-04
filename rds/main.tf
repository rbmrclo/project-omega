resource "aws_db_subnet_group" "private" {
  name       = "main"
  subnet_ids = ["${var.subnet_ids}"]

  tags {
    Name = "Private DB Subnet Group"
  }
}

resource "aws_security_group" "allow_all_rds" {
  name        = "allow_all_rds"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_all_rds"
  }
}

resource "aws_db_instance" "main" {
  engine = "mysql"
  engine_version = "5.6.27"
  storage_type = "gp2"
  allocated_storage = 5

  instance_class = "${var.instance_class}"

  parameter_group_name = "default.mysql5.6"
  db_subnet_group_name = "${aws_db_subnet_group.private.name}"
  publicly_accessible = "${var.publicly_accessible}"

  identifier = "${var.identifier}"
  name = "${var.name}"
  username = "${var.username}"
  password = "${var.password}"

  vpc_security_group_ids = ["${aws_security_group.allow_all_rds.id}"]
}
