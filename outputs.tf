output "vpc_ic" {
  value = "${aws_vpc.default.id}"
}

output "subnet.public1" {
  value = "${aws_subnet.public1.id}"
}

output "subnet.public2" {
  value = "${aws_subnet.public1.id}"
}

output "subnet.public3" {
  value = "${aws_subnet.public1.id}"
}
