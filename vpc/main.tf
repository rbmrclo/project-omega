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
