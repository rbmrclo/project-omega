resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr_block}"

  tags {
    Name = "${var.role}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.role}"
  }
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "${var.role}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "private"
  }
}

resource "aws_route" "main" {
  route_table_id         = "${aws_route_table.main.id}"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = "${aws_vpc.main.id}"
  route_table_id = "${aws_route_table.main.id}"
}

resource "aws_network_acl" "bastion" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "bastion"
  }
}

resource "aws_network_acl_rule" "bastion_inbound" {
  network_acl_id = "${aws_network_acl.bastion.id}"
  rule_number    = 90
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  to_port        = 22
  from_port      = 22
}

resource "aws_network_acl_rule" "bastion_outbound" {
  network_acl_id = "${aws_network_acl.bastion.id}"
  rule_number    = 90
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  to_port        = 22
  from_port      = 22
}

resource "aws_subnet" "public_a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.public_subnets["a"]}"
  availability_zone = "${var.public_availability_zones["a"]}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.public_subnet_tags["a"]}"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.public_subnets["b"]}"
  availability_zone = "${var.public_availability_zones["b"]}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.public_subnet_tags["b"]}"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.public_subnets["c"]}"
  availability_zone = "${var.public_availability_zones["c"]}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.public_subnet_tags["c"]}"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.private_subnets["a"]}"
  availability_zone = "${var.private_availability_zones["a"]}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.private_subnet_tags["a"]}"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.private_subnets["b"]}"
  availability_zone = "${var.private_availability_zones["b"]}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.private_subnet_tags["b"]}"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.private_subnets["c"]}"
  availability_zone = "${var.private_availability_zones["c"]}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.private_subnet_tags["c"]}"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = "${aws_subnet.private_a.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = "${aws_subnet.private_b.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = "${aws_subnet.private_c.id}"
  route_table_id = "${aws_route_table.private.id}"
}
