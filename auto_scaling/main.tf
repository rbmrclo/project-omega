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

resource "aws_cloudwatch_metric_alarm" "main-cpu-alarm" {
  alarm_name          = "main-cpu-alarm"
  alarm_description   = "main-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.main-asg.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.main-cpu-policy.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "main-cpu-alarm-scaledown" {
  alarm_name          = "main-cpu-alarm-scaledown"
  alarm_description   = "main-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.main-asg.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.main-cpu-policy-scaledown.arn}"]
}

resource "aws_autoscaling_notification" "asg-notify" {
  group_names = ["${aws_autoscaling_group.main-asg.name}"]
  topic_arn   = "${var.sns_topic_arn}"
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
  ]
}

