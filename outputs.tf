output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "subnet_public1" {
  value = "${aws_subnet.public1.id}"
}

output "subnet_public2" {
  value = "${aws_subnet.public2.id}"
}

output "subnet_public3" {
  value = "${aws_subnet.public3.id}"
}

output "sg_allow_egress" {
  value = "${aws_security_group.allow_egress.id}"
}

output "sg_allow_22" {
  value = "${aws_security_group.allow_22.id}"
}

output "sg_allow_80" {
  value = "${aws_security_group.allow_80.id}"
}
