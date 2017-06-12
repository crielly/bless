resource "aws_iam_role" "BLESS-lambda" {
  name        = "BLESS-lambda-${var.REGION}"
  description = "BLESS-lambda-${var.REGION}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com",
        "AWS": "arn:aws:sts::${data.aws_caller_identity.current.account_id}:assumed-role/${aws_iam_role.BLESS-invoke.name}/mfaassume"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "BLESS-lambda" {
  name        = "BLESS-lambda-${var.REGION}"
  description = "BLESS-lambda-${var.REGION}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:GenerateRandom",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "AllowKMSDecryption",
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Resource": [
        "${aws_kms_key.BLESS.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "BLESS-lambda" {
  role       = "${aws_iam_role.BLESS-lambda.name}"
  policy_arn = "${aws_iam_policy.BLESS-lambda.arn}"
}
