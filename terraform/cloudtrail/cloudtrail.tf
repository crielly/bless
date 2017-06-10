resource "aws_cloudtrail" "global-trail" {
  name                          = "global-trail"
  s3_bucket_name                = "${aws_s3_bucket.cloudtrail.id}"
  include_global_service_events = true
  is_multi_region_trail         = true
  tags {
    Name        = "${var.namespace}-cloudtrail"
    Terraform   = "True"
  }
}
