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
