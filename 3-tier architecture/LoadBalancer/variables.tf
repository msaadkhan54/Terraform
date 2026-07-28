variable "protocol" {
  default = "tcp"
}

variable "anywhere-ip" {
  default = "0.0.0.0/0"
}

variable "public-subnet" {
  description = "these are public subnets"
}

variable "vpc_id" {
  description = "this is the vpc id"
}

variable "private-subnet" {
  description = "these are private subnets"
}