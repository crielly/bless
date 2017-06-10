resource "aws_iam_group" "operations" {
  name = "operations"
  path = "/iamsync/"
}

resource "aws_iam_group_policy_attachment" "operations-adminaccess" {
  group      = "${aws_iam_group.operations.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

output "operations-arn" {
  value = "${aws_iam_group.operations.arn}"
}

resource "aws_iam_group" "devs" {
  name = "devs"
  path = "/iamsync/"
}

resource "aws_iam_group_policy_attachment" "devs-powerusers" {
  group      = "${aws_iam_group.devs.name}"
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

output "devs-arn" {
  value = "${aws_iam_group.devs.arn}"
}
