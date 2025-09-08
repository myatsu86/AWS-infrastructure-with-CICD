resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "multi-tier-vpc"
  }
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "multi-tier-igw"
    }
}

resource "aws_nat_gateway" "my-nat-gateway" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public[0].id
    tags = {
      Name = "multi-tier-nat"
    }
    depends_on = [ aws_internet_gateway.my_igw ]
}

resource "aws_eip" "nat" {
    domain  = "vpc"
}

resource "aws_subnet" "public" {
    count = length(var.public_subnets)
    vpc_id     = aws_vpc.my-vpc.id
    cidr_block = var.public_subnets[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "multi-tier-public-subnet-${count.index + 1}"
    }
}

resource "aws_subnet" "private" {
    count = length(var.private_subnets)
    vpc_id     = aws_vpc.my-vpc.id
    cidr_block = var.private_subnets[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "multi-tier-private-subnet-${count.index + 1}"
    }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igw.id
}

resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public[*].id)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "private-rt"
    }
}

resource "aws_route" "private_nat_access" {
    route_table_id = aws_route_table.private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my-nat-gateway.id
}

resource "aws_route_table_association" "private" {
    count = length(aws_subnet.private[*].id)
    subnet_id = aws_subnet.private[count.index].id 
    route_table_id = aws_route_table.private.id
}
