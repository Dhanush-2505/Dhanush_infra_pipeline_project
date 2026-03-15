module "vpc" {
  source        = "../../modules/vpc"
  vpc_cidr      = "10.0.0.0/16"
  subnet_cidr   = "10.0.1.0/24"
  subnet_az     = "${var.aws_region}a"          # ap-southeast-1a is the availability zone in Singapore region
  env           = "dev"
}

module "ec2" {
  source            = "../../modules/ec2"
  ami_id            = "ami-0ed0867532b47cc2c"
  instance_type     = "t3.micro"
  subnet_id         = module.vpc.subnet_id
  ec2_count         = 2
  env               = "dev"
}