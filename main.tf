# The VPC is created across all availability zones in the region
data "aws_availability_zones" "available" {}

# Create a VPC with public and private subnets.  
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"

  name = "${var.lab_environment_name}-vpc"
  cidr = "10.0.0.0/16"
  azs = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  # When mounting AWS EFS using a DNS name the following must be set to true
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    "Name" = "${var.lab_environment_name}-VPC"
  }

  public_subnet_tags = {
    # This tag is used to filter public subnets in other projects
    "Tier" = "Public"
  }

  private_subnet_tags = {
    # This tag is used to filter private subnets in other projects.
    "Tier" = "Private"
  }
}
