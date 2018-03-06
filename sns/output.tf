output "autoscaling_group_topic_arn" {
  value = "${aws_sns_topic.auto_scaling_group_alert.arn}"
}
