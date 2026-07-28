
resource "aws_security_group" "asg-ec2-sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [var.lb-sg]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags ={
    Name="sad-asg-sg"
  }
}

resource "aws_launch_template" "lt" {
  name = "saad-lt"
  image_id = var.ami-ec2
  instance_type = var.instance_type
  key_name = var.key_name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.asg-ec2-sg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "saad-lt-tf"
    }
  }
}

resource "aws_autoscaling_group" "asg" {
vpc_zone_identifier = [var.private-subnet[0]]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1
  health_check_type = "EC2"

  target_group_arns   = [var.target_group_arn]
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
}