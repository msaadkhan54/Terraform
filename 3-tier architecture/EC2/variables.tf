variable "protocol" {
  default = "tcp"
}

variable "anywhere-ip" {
  default = "0.0.0.0/0"
}

variable "vpc_id" {
  description = "this is the vpc id"
}

variable "ami-linux"{
    default = "ami-02b64aa047cb5edf5"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "public-subnet" {
  description = "these are public subnet"
}