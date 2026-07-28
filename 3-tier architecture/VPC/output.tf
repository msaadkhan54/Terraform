output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public-subnet" {
  value=[aws_subnet.public-subnet-1a.id,aws_subnet.public-subnet-1b.id]
}

output "private-subnet" {
  value = [aws_subnet.private-subnet-1c.id,aws_subnet.private-subnet-1b.id]
}
