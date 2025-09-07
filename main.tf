resource "aws_vpc" "default" {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true

  tags = merge(
    var.tags,
    {
      "Name" = "tf-vpc"
    },
  )

  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "public1" {
  vpc_id = aws_vpc.default.id

  cidr_block                      = "10.0.1.0/24"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.default.ipv6_cidr_block, 8, 1)
  availability_zone               = "us-east-1a"
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = merge(
    var.tags,
    var.public_subnet_tags,
    {
      "Name" = "public1"
    },
  )
}

resource "aws_subnet" "public2" {
  vpc_id                          = aws_vpc.default.id
  cidr_block                      = "10.0.2.0/24"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.default.ipv6_cidr_block, 8, 2)
  availability_zone               = "us-east-1b"
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = merge(
    var.tags,
    var.public_subnet_tags,
    {
      "Name" = "public2"
    },
  )
}

resource "aws_subnet" "public3" {
  vpc_id                          = aws_vpc.default.id
  cidr_block                      = "10.0.3.0/24"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.default.ipv6_cidr_block, 8, 3)
  availability_zone               = "us-east-1c"
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = merge(
    var.tags,
    var.public_subnet_tags,
    {
      "Name" = "public3"
    },
  )
}

resource "aws_subnet" "private1" {
  vpc_id                          = aws_vpc.default.id
  cidr_block                      = "10.0.101.0/24"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.default.ipv6_cidr_block, 8, 101)
  availability_zone               = "us-east-1a"
  assign_ipv6_address_on_creation = true

  tags = merge(
    var.tags,
    var.private_subnet_tags,
    {
      "Name" = "private1"
    },
  )
}

resource "aws_subnet" "private2" {
  vpc_id                          = aws_vpc.default.id
  cidr_block                      = "10.0.102.0/24"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.default.ipv6_cidr_block, 8, 102)
  availability_zone               = "us-east-1b"
  assign_ipv6_address_on_creation = true

  tags = merge(
    var.tags,
    var.private_subnet_tags,
    {
      "Name" = "private2"
    },
  )
}

resource "aws_subnet" "private3" {
  vpc_id                          = aws_vpc.default.id
  cidr_block                      = "10.0.103.0/24"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.default.ipv6_cidr_block, 8, 103)
  availability_zone               = "us-east-1c"
  assign_ipv6_address_on_creation = true

  tags = merge(
    var.tags,
    var.private_subnet_tags,
    {
      "Name" = "private3"
    },
  )
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.default.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.default.id
  }
}

# TODO: remove duplication here
resource "aws_route_table_association" "sub1" {
  route_table_id = aws_route_table.default.id
  subnet_id      = aws_subnet.public1.id
}

resource "aws_route_table_association" "sub2" {
  route_table_id = aws_route_table.default.id
  subnet_id      = aws_subnet.public2.id
}

resource "aws_route_table_association" "sub3" {
  route_table_id = aws_route_table.default.id
  subnet_id      = aws_subnet.public3.id
}

resource "aws_route_table_association" "private_sub1" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private1.id
}

resource "aws_route_table_association" "private_sub2" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private2.id
}

resource "aws_route_table_association" "private_sub3" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private3.id
}

resource "aws_eip" "nat_gateway" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.default]
}

resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public1.id
}

resource "aws_vpc_endpoint" "s3" {
  count = var.enable_endpoint_s3 == "true" ? 1 : 0

  route_table_ids = [
    aws_route_table.default.id,
    aws_route_table.private.id,
  ]

  vpc_id       = aws_vpc.default.id
  service_name = "com.amazonaws.us-east-1.s3"
}

resource "aws_vpc_endpoint" "dynamo" {
  count = var.enable_endpoint_dynamo == "true" ? 1 : 0

  route_table_ids = [
    aws_route_table.default.id,
    aws_route_table.private.id,
  ]

  vpc_id       = aws_vpc.default.id
  service_name = "com.amazonaws.us-east-1.dynamodb"
}

