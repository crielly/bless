resource "aws_kms_key" "BLESS" {
  description             = "BLESS KMS for ${var.REGION}"
  deletion_window_in_days = 10
  tags {
    Name      = "BLESS-${var.REGION}"
    Terraform = "True"
  }
}

resource "aws_kms_alias" "BLESS" {
  name          = "alias/BLESS-${var.REGION}"
  target_key_id = "${aws_kms_key.BLESS.key_id}"
}