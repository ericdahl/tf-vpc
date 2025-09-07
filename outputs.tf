output "vpc_id" {
  value = aws_vpc.default.id
}

output "subnet_public1" {
  value = aws_subnet.public1.id
}

output "subnet_public2" {
  value = aws_subnet.public2.id
}

output "subnet_public3" {
  value = aws_subnet.public3.id
}

output "subnet_private1" {
  value = aws_subnet.private1.id
}

output "subnet_private2" {
  value = aws_subnet.private2.id
}

output "subnet_private3" {
  value = aws_subnet.private3.id
}

output "sg_allow_egress" {
  value = aws_security_group.allow_egress.id
}

output "sg_allow_22" {
  value = aws_security_group.allow_22.id
}

output "sg_allow_80" {
  value = aws_security_group.allow_80.id
}

output "sg_allow_8080" {
  value = aws_security_group.allow_8080.id
}

output "sg_allow_vpc" {
  value = aws_security_group.allow_vpc.id
}

output "vpc_ipv6_cidr_block" {
  value = aws_vpc.default.ipv6_cidr_block
}

output "subnet_public1_ipv6_cidr_block" {
  value = aws_subnet.public1.ipv6_cidr_block
}

output "subnet_public2_ipv6_cidr_block" {
  value = aws_subnet.public2.ipv6_cidr_block
}

output "subnet_public3_ipv6_cidr_block" {
  value = aws_subnet.public3.ipv6_cidr_block
}

output "subnet_private1_ipv6_cidr_block" {
  value = aws_subnet.private1.ipv6_cidr_block
}

output "subnet_private2_ipv6_cidr_block" {
  value = aws_subnet.private2.ipv6_cidr_block
}

output "subnet_private3_ipv6_cidr_block" {
  value = aws_subnet.private3.ipv6_cidr_block
}

