variable "instance_class" { default = "db.t2.micro" }
variable "subnet_ids" { type = "list" }

variable "username" {
  description = "Username for the master DB user"
}

variable "password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
}

variable "name" {
  description = "The DB name to create. If omitted, no database is created initially"
  default = ""
}

variable "identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  default     = false
}
