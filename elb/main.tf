resource "aws_elb" "main-elb" {
  name = "main-elb"
  subnets = ["${var.subnet_ids}"]
  security_groups = ["${var.security_group_ids}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }

  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "main-elb"
  }
}
