provider "aws"{
    region = "us-east-1"
}

module "VPC" {
    source = "./VPC"
}

module "EC2" {
  source = "./EC2"
  vpc_id = module.VPC.vpc_id
  public-subnet = module.VPC.public-subnet
}

module "load_balancer" {
  source = "./LoadBalancer"
  public-subnet = module.VPC.public-subnet
  private-subnet=module.VPC.private-subnet
  vpc_id = module.VPC.vpc_id
}

module "autoScaling" {
    source = "./AutoScaling"
    ami-ec2 = module.EC2.ami-ec2
    instance_type = module.EC2.instance_type
    lb-sg = module.load_balancer.lb-sg
    key_name = module.EC2.key_name
    private-subnet = module.VPC.private-subnet
    vpc_id = module.VPC.vpc_id
    target_group_arn = module.load_balancer.target_group_arn
}

# module "remote-backend" {
#   source = "./Remote Backend"
# }

module "public-rds" {
  source = "./RDS"
  public_subnet = module.VPC.public-subnet
  vpc_id = module.VPC.vpc_id
}

module "s3-bucket" {
  source="./S3-bucket"
}
