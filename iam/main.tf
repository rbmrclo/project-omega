resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/users/"
}

resource "aws_iam_user" "robbie" {
  name = "robbie"
}

resource "aws_iam_user" "moreno" {
  name = "moreno"
}

resource "aws_iam_user" "marcelo" {
  name = "marcelo"
}

resource "aws_iam_group_membership" "developers" {
  name = "project-omega-developers"

  users = [
    "${aws_iam_user.robbie.name}",
    "${aws_iam_user.moreno.name}",
    "${aws_iam_user.marcelo.name}",
  ]

  group = "${aws_iam_group.developers.name}"
}
