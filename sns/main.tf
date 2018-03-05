resource "aws_sns_topic" "auto_scaling_group_alert" {
  name = "ASGAlert"
  display_name = "ASGAlert"
}

resource "aws_sqs_queue" "auto_scaling_group_alert_queue" {
  name = "ASGAlertQueue"
}

resource "aws_sns_topic_subscription" "auto_scaling_group_sqs_target" {
  topic_arn = "${aws_sns_topic.auto_scaling_group_alert.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.auto_scaling_group_alert_queue.arn}"
}
