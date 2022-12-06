data "archive_file" "python_lambda_package"{
    type = "zip"
    source_file = "${path.module}/lambda/function.py"
    output_path = "function.zip"
}

resource "aws_lambda_function" "lambda" {
  filename      = "function.zip"
  function_name = "update-s3-policy"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "function.lambda_handler"
  runtime       = "python3.9"

  environment {
    variables = {
      BUCKET_NAME = var.domain_bucket
    }
  }
}