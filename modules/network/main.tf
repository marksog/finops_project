resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env_name}-vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  availability_zone = element(data.aws_availability_zones.available.names, 0)
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.env_name}-public-subnet"
  }
}

resource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index )
  count = 2

  tags = {
    Name = "${var.env_name}-private-subnet-${count.index + 1}"
  } 
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env_name}-igw"
  }
}

resource "aws_eip" "nat_eip" {
  count = 1
  associate_with_private_ip = null

  tags = {
    Name = "${var.env_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count = 1
  allocation_id = aws_eip.nat_eip[0].id
  subnet_id = aws_subnet.public_subnet.id
  depends_on = [aws_internet_gateway.igw]

    tags = {
        Name = "${var.env_name}-nat-gateway"
    }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.vpc_cidr
    nat_gateway_id = aws_nat_gateway.nat_gateway[0].id
  }
  tags = {
    Name = "${var.env_name}-private-route-table"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count = length(var.private_subnet_cidrs)
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}