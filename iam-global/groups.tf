resource "aws_iam_group" "operations" {
  name = "Operations"
}

resource "aws_iam_group_policy_attachment" "operations-adminaccess" {
  group      = "${aws_iam_group.operations.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

output "operations-arn" {
  value = "${aws_iam_group.operations.arn}"
}