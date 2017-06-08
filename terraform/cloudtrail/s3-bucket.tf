resource "aws_s3_bucket" "cloudtrail" {
  bucket = "${var.namespace}-cloudtrail"

  tags {
    Name        = "${var.namespace}-cloudtrail"
    Environment = "global"
    Terraform   = "True"
  }
}

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = "${aws_s3_bucket.cloudtrail.id}"
  policy = "${data.aws_iam_policy_document.cloudtrail.json}"
}

data "aws_iam_policy_document" "cloudtrail" {
  statement {
    sid = "AWSCloudTrailAclCheck"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "${aws_s3_bucket.cloudtrail.arn}",
    ]
  }

  statement {
    sid = "AWSCloudTrailWrite"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.cloudtrail.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }
}