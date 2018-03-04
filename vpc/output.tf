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
#
output "vpc_default_security_group_id" {
  value = "${aws_vpc.main.default_security_group_id}"
}
# ---------------------------------------------------------------------------------------------------------------------
