resource "aws_route53_zone" "main" {
  name   = "${var.zone_name}"
  vpc_id = "${var.vpc_id}"
}

resource "aws_route53_zone_association" "to_main" {
  zone_id = "${aws_route53_zone.main.id}"
  vpc_id  = "${var.vpc_id}"
}

resource "aws_route53_record" "project_omega_rbmrclo" {
  zone_id = "${aws_route53_zone.main.id}"
  name = "${var.name}"
  type = "CNAME"
  ttl = "60"

  records = [
    "${var.elb_dns_names}"
  ]
}
