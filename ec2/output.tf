output "allow_all_security_group_id" {
  value = "${aws_security_group.allow_all.id}"
}

output "key_name" {
  value = "${aws_key_pair.root.key_name}"
}
