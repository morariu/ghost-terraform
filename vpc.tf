resource "aws_vpc" "main" {
  cidr_block = "10.3.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "ghost-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ghost"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.3.1.0/24"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ghost-public"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.3.2.0/24"
  availability_zone = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "ghost-public"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.3.3.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "ghost-db"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.3.4.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "ghost-db"
  }
}

resource "aws_route_table" "table1" {
  vpc_id = aws_vpc.main.id

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ghost-igw.id
    }

  tags = {
    Name = "ghost-public"
  }
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  route = []

  tags = {
    Name = "ghost-private"
  }
}

resource "aws_route_table_association" "subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.table1.id
}

resource "aws_route_table_association" "subnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.table1.id
}

resource "aws_route_table_association" "subnet3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.database.id
}

resource "aws_route_table_association" "subnet4" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.database.id
}