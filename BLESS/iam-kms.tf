resource "aws_iam_role" "BLESS-kms" {
  name = "BLESS-kms-us-west-2"
  description = "BLESS-kms-us-west-2"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "${data.terraform_remote_state.iam-global.operations-arn}"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "BLESS-kms-encrypt" {
  name        = "BLESS-kms-encrypt-us-west-2"
  description = "BLESS-kms-encrypt-us-west-2"
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
          "bless-${data.aws_region.current.name}"
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