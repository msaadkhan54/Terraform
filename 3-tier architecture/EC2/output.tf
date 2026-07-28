output "instance_id" {
  value = aws_instance.public-ec2.id
}

output "ami-ec2" {
  value=aws_ami_from_instance.pub-ec2-ami.id
}

output "instance_type" {
  value = var.instance_type
}

output "key_name" {
  value=aws_key_pair.pub-key.key_name
}