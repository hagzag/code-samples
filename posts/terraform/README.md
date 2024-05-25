# terraform & terragrunt

## Taskfile usage

This repository contains a Taskfile for managing Terraform and Terragrunt operations on AWS. The Taskfile automates the process of initializing, planning, applying, and destroying AWS resources such as EC2 instances, key-pairs, and security groups.

## Prerequisites

1. **AWS Account**: You need an AWS account with permissions to create and manage EC2 instances, key-pairs, and security groups.
2. **Terraform**: Ensure you have Terraform installed. Refer to the [Terraform installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) for instructions.
3. **Terragrunt**: Ensure you have Terragrunt installed. Refer to the [Terragrunt installation guide](https://terragrunt.gruntwork.io/docs/getting-started/install/) for instructions.

## Taskfile Structure

### Variables

- `TF_DIR`: Directory containing the Terraform configuration files (`aws-demo-tf`).

### Tasks

#### `tf-aws-example`

Runs the AWS example using Terraform:
1. Initializes and creates a plan.
2. Applies the plan.

#### `tf-aws-example-destroy`

Destroys the AWS example resources using Terraform.

#### `tg-aws-example`

Runs the AWS example using Terragrunt:

1. Generates a `terragrunt.hcl` file in the Terraform directory.
2. Initializes and creates a plan using Terragrunt.
3. Applies the plan using Terragrunt.

#### `tg-aws-example-destroy`

Destroys the AWS example resources using Terragrunt and removes the `terragrunt.hcl` file.

### Internal Utility Tasks

- `init-plan`: Initializes and creates a Terraform plan in the current directory.
- `tg-init-plan`: Initializes and creates a plan using Terragrunt in the current directory.
- `apply`: Applies the Terraform plan in the current directory.
- `tg-apply`: Applies the Terragrunt plan in the current directory.
- `destroy`: Destroys the Terraform-managed infrastructure in the current directory.
- `tg-destroy`: Destroys the Terragrunt-managed infrastructure in the current directory.

## Usage

To run the tasks, use the following commands:

1. **Run the AWS example using Terraform**:

    ```sh
    task tf-aws-example
    ```

2. **Destroy the AWS example using Terraform**:

    ```sh
    task tf-aws-example-destroy
    ```

3. **Run the AWS example using Terragrunt**:

    ```sh
    task tg-aws-example
    ```

4. **Destroy the AWS example using Terragrunt**:

    ```sh
    task tg-aws-example-destroy
    ```

These tasks will automate the process of setting up and tearing down your AWS infrastructure, making it easy to manage your resources.

For further customization, you can modify the `vars` and `cmds` sections in the Taskfile as needed.

## About the AWS example

In this innocent example all you need it a valid AWS profile active and you should be good to go
The module will creat an aws instance security group and ssh-key pair in order to connect to the machine

- see `main.tf`:

```sh
cat<<EOF>>main.tf
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
EOF
```
