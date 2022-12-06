resource "aws_iam_role" "iam_for_lambda" {
  name = "iam-for-lambda"

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

resource "aws_iam_role_policy" "lambda_to_s3" {
  name = "allow-lambda-access-to-${var.domain_bucket}"
  role = aws_iam_role.iam_for_lambda.name
  policy = templatefile("${path.module}/policies/lambda_policy.json",{
      DOMAIN_BUCKET = var.domain_bucket
  })
}