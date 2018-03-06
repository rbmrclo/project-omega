variable "aws_region" {
  default = "us-east-1"
}

variable "amis" {
  type = "map"

  default = {
    us-east-1 = "ami-97785bed" # Amazon Linux
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "security_group_ids" { type = "list" }
variable "key_name" {}
variable "sns_topic_arn" {}
