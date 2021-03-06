resource "aws_security_group" "allow_egress" {
  vpc_id = aws_vpc.default.id
  name   = "allow_egress"
}

resource "aws_security_group_rule" "allow_egress" {
  security_group_id = aws_security_group.allow_egress.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "allow_22" {
  vpc_id = aws_vpc.default.id
  name   = "allow_22"
}

resource "aws_security_group_rule" "allow_22" {
  security_group_id = aws_security_group.allow_22.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.admin_ip_cidr]
}

resource "aws_security_group" "allow_80" {
  vpc_id = aws_vpc.default.id
  name   = "allow_80"
}

resource "aws_security_group_rule" "allow_80" {
  security_group_id = aws_security_group.allow_80.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "allow_8080" {
  vpc_id = aws_vpc.default.id
  name   = "allow_8080"
}

resource "aws_security_group_rule" "allow_8080" {
  security_group_id = aws_security_group.allow_8080.id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "allow_vpc" {
  vpc_id = aws_vpc.default.id
  name   = "allow_vpc"
}

resource "aws_security_group_rule" "allow_vpc" {
  security_group_id = aws_security_group.allow_vpc.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [aws_vpc.default.cidr_block]
}

