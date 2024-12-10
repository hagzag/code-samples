################################################################################
# variables(s)
################################################################################

variable "region" {
  type = string
  default = ""
}

################################################################################
# provider(s)
################################################################################

provider "aws" {
  region = local.region
}

################################################################################
# Data Sources
################################################################################

locals {
  name   = "ex-${basename(path.cwd)}"
  region = var.region

  user_data = <<-EOT
    #!/bin/bash
    echo "Hello Terraform!"
  EOT

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-ec2-instance"
  }
  
}

data "aws_availability_zones" "available" {}

################################################################################
# Supporting Resources
################################################################################

# Create a key (only needed if you want to connect to the instance using SSH)
# and probebly do this only in a workshop ...

module "key_pair_external" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "${local.name}-external"
  public_key = trimspace(tls_private_key.this.public_key_openssh)

  tags = local.tags
}

##########################################################
# Ssh Key

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

################################################################################
# Security Group

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.name
  description = "Security group for example usage with EC2 instance"
  # vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp","http-80-tcp","all-icmp"]
  egress_rules        = ["all-all"]

  tags = local.tags
}

################################################################################
# EC2 Module - simple instance request
################################################################################

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                 = "${local.name}-spot-instance"
  # create_spot_instance = true

  associate_public_ip_address = true

  # Spot request specific attributes
  # spot_price                          = "0.1"
  # spot_wait_for_fulfillment           = true
  # spot_type                           = "persistent"
  # spot_instance_interruption_behavior = "terminate"
  # End spot request specific attributes

  user_data_base64 = base64encode(local.user_data)
  vpc_security_group_ids      = [module.security_group.security_group_id]
  key_name = module.key_pair_external.key_pair_name

  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 8
      tags = {
        Name = "my-root-block"
      }
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 8
      throughput  = 200
      encrypted   = true
    }
  ]

  tags = local.tags
}
