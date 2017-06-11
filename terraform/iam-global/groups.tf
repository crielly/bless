resource "aws_iam_group" "operations" {
  name = "operations"
  path = "/iamsync/"
}

resource "aws_iam_group_policy_attachment" "operations-adminaccess" {
  group      = "${aws_iam_group.operations.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "BLESS-invoke-operations" {
  group      = "${aws_iam_group.operations.name}"
  policy_arn = "${data.terraform_remote_state.BLESS.bless-invoke-arn}"
}

output "operations-arn" {
  value = "${aws_iam_group.operations.arn}"
}

resource "aws_iam_group" "devs" {
  name = "devs"
  path = "/iamsync/"
}

resource "aws_iam_group_policy_attachment" "BLESS-invoke-devs" {
  group      = "${aws_iam_group.devs.name}"
  policy_arn = "${data.terraform_remote_state.BLESS.bless-invoke-arn}"
}

output "devs-arn" {
  value = "${aws_iam_group.devs.arn}"
}

resource "aws_iam_group" "billing" {
  name = "billing"
}

resource "aws_iam_group_policy_attachment" "billing" {
  group      = "${aws_iam_group.billing.name}"
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

output "billing-arn" {
  value = "${aws_iam_group.billing.arn}"
}
