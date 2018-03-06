output "main_elb_name" {
  value = "${aws_elb.main-elb.name}"
}

output "main_elb_dns_name" {
	value = "${aws_elb.main-elb.dns_name}"
}
