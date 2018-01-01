resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public1" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public2" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public3" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private1" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "10.0.101.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "private2" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "10.0.102.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "private3" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "10.0.103.0/24"
  availability_zone = "us-east-1c"
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.default.id}"
  }
}

# TODO: remove duplication here
resource "aws_route_table_association" "sub1" {
  route_table_id = "${aws_route_table.default.id}"
  subnet_id      = "${aws_subnet.public1.id}"
}

resource "aws_route_table_association" "sub2" {
  route_table_id = "${aws_route_table.default.id}"
  subnet_id      = "${aws_subnet.public2.id}"
}

resource "aws_route_table_association" "sub3" {
  route_table_id = "${aws_route_table.default.id}"
  subnet_id      = "${aws_subnet.public3.id}"
}

resource "aws_route_table_association" "private_sub1" {
  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${aws_subnet.private1.id}"
}

resource "aws_route_table_association" "private_sub2" {
  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${aws_subnet.private2.id}"
}

resource "aws_route_table_association" "private_sub3" {
  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${aws_subnet.private3.id}"
}

resource "aws_eip" "nat_gateway" {
  vpc        = true
  depends_on = ["aws_internet_gateway.default"]
}

resource "aws_nat_gateway" "default" {
  allocation_id = "${aws_eip.nat_gateway.id}"
  subnet_id     = "${aws_subnet.public1.id}"
}
