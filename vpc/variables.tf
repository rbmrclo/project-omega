variable "vpc_cidr_block" { default = "172.31.0.0/16" }
variable "role" { default = "main" }

variable "public_subnets" {
  type = "map"

  default = {
    a = "172.31.0.0/20"
    b = "172.31.80.0/20"
    c = "172.31.16.0/20"
  }
}

variable "private_subnets" {
  type = "map"

  default = {
    a = "172.31.32.0/20"
    b = "172.31.48.0/20"
    c = "172.31.64.0/20"
  }
}

variable "public_subnet_tags" {
  type = "map"

  default = {
    a = "public_a"
    b = "public_b"
    c = "public_c"
  }
}

variable "private_subnet_tags" {
  type = "map"

  default = {
    a = "private_a"
    b = "private_b"
    c = "private_c"
  }
}

variable "public_availability_zones" {
  type = "map"

  default = {
    a = "us-east-1a"
    b = "us-east-1b"
    c = "us-east-1c"
  }
}

variable "private_availability_zones" {
  type = "map"

  default = {
    a = "us-east-1d"
    b = "us-east-1e"
    c = "us-east-1f"
  }
}
