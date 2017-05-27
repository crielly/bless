resource "aws_iam_role" "BLESS-invoke" {
  name = "BLESS-invoke-${data.aws_region.current.name}"
  description = "BLESS-invoke-${data.aws_region.current.name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::861290736443:user/craig.bryan"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "BLESS-invoke" {
  name        = "BLESS-invoke-${data.aws_region.current.name}"
  description = "BLESS-invoke-${data.aws_region.current.name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
          "lambda:InvokeFunction"
      ],
      "Resource": [
          "${aws_lambda_function.BLESS.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "BLESS-invoke" {
  role       = "${aws_iam_role.BLESS-invoke.name}"
  policy_arn = "${aws_iam_policy.BLESS-invoke.arn}"
}