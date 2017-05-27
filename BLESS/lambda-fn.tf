resource "aws_lambda_function" "BLESS" {
  filename         = "bless_lambda.zip"
  function_name    = "BLESS"
  role             = "${aws_iam_role.BLESS-lambda.arn}"
  handler          = "bless_lambda.lambda_handler"
  source_code_hash = "${base64sha256(file("bless_lambda.zip"))}"
  runtime          = "python2.7"
  kms_key_arn      = "${aws_kms_key.BLESS.arn}"
}
