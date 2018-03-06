resource "aws_launch_configuration" "auto_scaling_conf" {
  name_prefix     = "project-omega-lc"
  image_id        = "${lookup(var.amis, var.aws_region)}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${var.security_group_ids}"]
  key_name        = "${var.key_name}"

  associate_public_ip_address = false

  user_data = "${file("${path.module}/scripts.txt")}"
}

resource "aws_autoscaling_group" "main-asg" {
  name                      = "main-asg"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.auto_scaling_conf.name}"

  availability_zones = [
    "${var.aws_region}a",
    "${var.aws_region}b",
    "${var.aws_region}c",
  ]
}

# Scale up alarm
resource "aws_autoscaling_policy" "main-cpu-policy" {
  name                   = "main-cpu-policy"
  autoscaling_group_name = "${aws_autoscaling_group.main-asg.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

# Scale down alarm
resource "aws_autoscaling_policy" "main-cpu-policy-scaledown" {
  name                   = "main-cpu-policy-scaledown"
  autoscaling_group_name = "${aws_autoscaling_group.main-asg.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}
