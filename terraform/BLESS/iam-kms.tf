resource "aws_iam_role" "BLESS-kms" {
  name        = "BLESS-kms-${var.REGION}"
  description = "BLESS-kms-${var.REGION}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "${data.aws_caller_identity.current.account_id}"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "BLESS-kms-encrypt" {
  name        = "BLESS-kms-encrypt-${var.REGION}"
  description = "BLESS-kms-encrypt-${var.REGION}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Sid": "AllowKMSEncryptIfMFAPresent",
    "Action": "kms:Encrypt",
    "Effect": "Allow",
    "Resource": [
      "${aws_kms_key.BLESS.arn}"
    ],
    "Condition": {
      "StringEquals": {
        "kms:EncryptionContext:to": [
          "bless-${var.REGION}"
        ],
        "kms:EncryptionContext:user_type": "user",
        "kms:EncryptionContext:from": "$${aws:username}"
      },
      "Bool": {
        "aws:MultiFactorAuthPresent": "true"
      }
    }
  }
}
EOF
}

resource "aws_iam_role_policy_attachment" "BLESS-kms-encrypt" {
  role       = "${aws_iam_role.BLESS-kms.name}"
  policy_arn = "${aws_iam_policy.BLESS-kms-encrypt.arn}"
}
