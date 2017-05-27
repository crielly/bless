resource "aws_kms_key" "BLESS" {
  description             = "BLESS KMS for ${data.aws_region.current.name}"
  deletion_window_in_days = 10
  tags {
    Name      = "BLESS-${data.aws_region.current.name}"
    Terraform = "True"
  }
}

resource "aws_kms_alias" "BLESS" {
  name          = "alias/BLESS-${data.aws_region.current.name}"
  target_key_id = "${aws_kms_key.BLESS.key_id}"
}