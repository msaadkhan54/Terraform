variable "ami-ec2" {
  description = "This is the nginx ec2 ami id"
}

variable "instance_type" {
  description = "instance type"
}

variable "lb-sg" {
  description = "this is the lb security group id"
}

variable "key_name" {
  description = "public key name"
}

variable "private-subnet" {
  description = "these are private subnet id"
}

variable "vpc_id" {
  description = "this is the vpc id"
}

variable "target_group_arn" {
  description = "target group arn"
}