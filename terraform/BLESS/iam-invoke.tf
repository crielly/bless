resource "aws_iam_role" "BLESS-invoke" {
  name        = "BLESS-invoke-${var.REGION}"
  description = "BLESS-invoke-${var.REGION}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "BLESS-invoke" {
  name        = "BLESS-invoke-${var.REGION}"
  description = "BLESS-invoke-${var.REGION}"

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
    },
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
          "iam:GetUser"
      ],
      "Resource": [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/$${aws:username}"
      ]
    },
    {
      "Sid": "AllowKMSEncryptIfMFAPresent",
      "Action": "kms:Encrypt",
      "Effect": "Allow",
      "Resource": [
        "${aws_kms_key.BLESS.arn}"
      ],
      "Condition": {
        "StringEquals": {
          "kms:EncryptionContext:to": [
            "bless"
          ],
          "kms:EncryptionContext:user_type": "user",
          "kms:EncryptionContext:from": "$${aws:username}"
        },
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}
EOF
}

output "bless-invoke-arn" {
  value = "${aws_iam_policy.BLESS-invoke.arn}"
}

resource "aws_iam_policy" "BLESS-assume-invoke-role" {
  name        = "BLESS-STS-${var.REGION}"
  description = "BLESS-STS-${var.REGION}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowAssumeInvokeRole",
      "Effect": "Allow",
      "Action": [
          "sts:AssumeRole"
      ],
      "Resource": [
          "${aws_iam_role.BLESS-invoke.arn}"
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
