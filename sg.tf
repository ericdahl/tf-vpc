resource "aws_security_group" "allow_egress" {
  name = "allow_egress"
}

resource "aws_security_group_rule" "allow_egress" {
  security_group_id = "${aws_security_group.allow_egress.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "allow_22" {
  name = "allow_22"
}

resource "aws_security_group_rule" "allow_22" {
  security_group_id = "${aws_security_group.allow_22.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "allow_80" {
  name = "allow_80"
}

resource "aws_security_group_rule" "allow_80" {
  security_group_id = "${aws_security_group.allow_80.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
