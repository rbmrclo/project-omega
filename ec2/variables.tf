variable "role" { default = "main" }
variable "instance_type" { default = "t2.micro" }
variable "ebs_optimized" { default = false }
variable "ami_ubuntu1604" { default = "ami-66506c1c" }
variable "availability_zone" { default = "us-east-1a" } # public A
variable "security_group_ids" { type = "list" }
variable "subnet_id" {}
