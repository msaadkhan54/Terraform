resource "aws_security_group" "http-ssh-sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port = 22
    to_port = 22
    protocol = var.protocol
    cidr_blocks = [ var.anywhere-ip]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = var.protocol
    cidr_blocks = [ var.anywhere-ip ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.anywhere-ip ]
  }

  tags={
    Name="saad-sg-1"
  }
}

resource "aws_key_pair" "pub-key" {
  key_name = "saad-key"
  public_key = file("C:/Users/Hp/Downloads/saad-pub.txt")
}

resource "aws_instance" "public-ec2" {
    ami = var.ami-linux
    associate_public_ip_address = true
    instance_type = var.instance_type
    security_groups = [ aws_security_group.http-ssh-sg.id ]
    subnet_id = var.public-subnet[0]
    key_name = aws_key_pair.pub-key.key_name
    user_data = <<-EOF
      #!/bin/bash
      dnf update -y
      dnf install -y nginx

      mkdir -p /usr/share/nginx/html

      cat << 'HTML' > /usr/share/nginx/html/index.html
    <!DOCTYPE html>
    <html>
    <head>
        <title>Welcome</title>
    </head>
    <body>
        <h1>Nginx Installed through script</h1>
    </body>
    HTML

      systemctl enable nginx
      systemctl start nginx
    EOF

    tags = {
        Name="saad-public-ec2"
    }
}

resource "aws_ami_from_instance" "pub-ec2-ami" {
  name               = "nginx-ami"
  source_instance_id = aws_instance.public-ec2.id
  tags = {
    Name="saad-nginx-ami" 
  }
}