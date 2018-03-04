variable "role" { default = "main" }
variable "instance_type" { default = "t2.micro" }
variable "ebs_optimized" { default = false }
variable "ami_default" { default = "ami-97785bed" } # Amazon Linux AMI 2017.09.1
variable "availability_zone" { default = "us-east-1a" } # public A
variable "security_group_ids" { type = "list" }
variable "subnet_id" {}
