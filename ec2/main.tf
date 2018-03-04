resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_all"
  }
}

resource "aws_ebs_volume" "main_ebs" {
  availability_zone = "${var.availability_zone}"
  size = 8
  tags {
    Name = "${var.role}"
  }
}

resource "aws_key_pair" "root" {
   key_name = "sudo"

   # dummy key (for demo purposes only)
   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

resource "aws_instance" "main" {
  ami           = "${var.ami_default}"
  instance_type = "${var.instance_type}"
  ebs_optimized = "${var.ebs_optimized}"
  subnet_id     = "${var.subnet_id}"

  vpc_security_group_ids = ["${var.security_group_ids}"]

  availability_zone = "${var.availability_zone}"

  key_name = "${aws_key_pair.root.key_name}"

  user_data = "${file("${path.module}/scripts.txt")}"

  tags {
    Name = "General EC2"
    Role = "${var.role}"
    OS   = "${var.ami_default}"
  }
}

resource "aws_volume_attachment" "main_ebs_attachment" {
  device_name = "/dev/sdf"
  volume_id   = "${aws_ebs_volume.main_ebs.id}"
  instance_id = "${aws_instance.main.id}"
}

