resource "aws_db_subnet_group" "public-1a" {
  name = "public-rds-subnet-1a"
  region = "us-east-1"
  subnet_ids = var.public_subnet
  tags = {
   Name="saad-rds-subnet" 
  }
}

resource "aws_security_group" "rds-pub-sg" {
  name = "rds public-sg"
  vpc_id = var.vpc_id
  
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags={
    Name="saad-rd-pub-sg"
  }
}

resource "aws_db_instance" "public_rds_1a" {
  allocated_storage    = 10
  db_name              = "saad-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "sherdil#123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  deletion_protection  = false
  db_subnet_group_name = aws_db_subnet_group.public-1a.name
  vpc_security_group_ids = [aws_security_group.rds-pub-sg.id]
  availability_zone = "us-east-1a"
  tags = {
   Name="saad-db-inst" 
  }
}
