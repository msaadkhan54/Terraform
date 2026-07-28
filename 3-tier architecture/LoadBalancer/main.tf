resource "aws_security_group" "lb-sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port = 80
    to_port = 80
    protocol=var.protocol
    cidr_blocks = [ var.anywhere-ip ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.anywhere-ip ]
  }

  tags = {
    Name="saad-lb-sg"  
  }
}

resource "aws_lb" "http-lb" {
  name               = "saad-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sg.id]
  subnets            = [var.public-subnet[0],var.public-subnet[1],var.private-subnet[0]]

  enable_deletion_protection = false

  tags = {
    Name = "saad-lb"
  }
}

resource "aws_lb_target_group" "lb-tg" {
  name     = "saad-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.http-lb.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg.arn
  }
}