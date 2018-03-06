resource "aws_iam_role" "lambda_iam" {
  name = "lambda_iam"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "hello_lambda" {
  filename         = "hello_lambda.zip"
  function_name    = "hello_lambda"
  role             = "${aws_iam_role.lambda_iam.arn}"
  handler          = "hello_lambda.handler"
  source_code_hash = "${base64sha256(file("hello_lambda.zip"))}"
  runtime          = "python2.7"
}
