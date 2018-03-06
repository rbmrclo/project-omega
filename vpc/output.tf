output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.main.cidr_block}"
}

# ---------------------------------------------------------------------------------------------------------------------
# Needed for our ec2 provisioning demo
#
output "subnet_public_a_id" {
  value = "${aws_subnet.public_a.id}"
}

output "subnet_public_b_id" {
  value = "${aws_subnet.public_b.id}"
}

output "subnet_public_c_id" {
  value = "${aws_subnet.public_c.id}"
}

# Needed for rds provisioning demo
#
output "subnet_private_a_id" {
  value = "${aws_subnet.private_a.id}"
}
#
output "subnet_private_b_id" {
  value = "${aws_subnet.private_b.id}"
}
#
output "subnet_private_c_id" {
  value = "${aws_subnet.private_c.id}"
}
#
output "vpc_default_security_group_id" {
  value = "${aws_vpc.main.default_security_group_id}"
}
# ---------------------------------------------------------------------------------------------------------------------
