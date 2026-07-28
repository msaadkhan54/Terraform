resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "saad-vpc"  
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "saad-igw"
    
  }
}

resource "aws_default_route_table" "public-rt" {
    default_route_table_id = aws_vpc.vpc.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "saad-public-rt"
    }
    depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name="saad-private-rt"
  }
}

resource "aws_subnet" "public-subnet-1a" {
  vpc_id=aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags={
    Name="saad-public-sub-1a"
  }
}

resource "aws_subnet" "public-subnet-1b" {
  vpc_id=aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags={
    Name="saad-public-sub-1b"
  }
}

resource "aws_subnet" "private-subnet-1c" {
  vpc_id=aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  tags={
    Name="saad-private-sub-1c"
  }
}

resource "aws_subnet" "private-subnet-1b" {
  vpc_id=aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags={
    Name="saad-private-sub-1b"
  }
}

resource "aws_route_table_association" "pub-sub-1a" {
  route_table_id = aws_default_route_table.public-rt.id
  subnet_id =  aws_subnet.public-subnet-1a.id
}

resource "aws_route_table_association" "pub-sub-1b" {
  route_table_id = aws_default_route_table.public-rt.id
  subnet_id =  aws_subnet.public-subnet-1b.id
}

resource "aws_route_table_association" "pvt-sub-1c" {
  route_table_id = aws_route_table.private-rt.id
  subnet_id =  aws_subnet.private-subnet-1c.id
}

resource "aws_route_table_association" "pvt-sub-1b" {
  route_table_id = aws_route_table.private-rt.id
  subnet_id =  aws_subnet.private-subnet-1b.id
}

