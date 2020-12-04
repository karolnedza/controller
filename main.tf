  terraform {
  backend "s3" {
    key    = "controller.tfstate"
    region = "us-east-1"
    access_key = "var_access_key"
    secret_key = "var_secret_key"
  }

}


provider "aws" {
  region     = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}


module "aviatrix-iam-roles" {
  source = "./controller-modules/aviatrix-controller-iam-roles"
}

module "aviatrix-controller-build" {
  source  = "./controller-modules/aviatrix-controller-build"
  vpc     = ""
  subnet  = ""
  keypair = ""
  ec2role = module.aviatrix-iam-roles.aviatrix-role-ec2-name
  termination_protection = false
  cidr = "10.21.103.0/24"
}


output "controller_private_ip" {
  value = module.aviatrix-controller-build.private_ip
}

output "controller_public_ip" {
  value = module.aviatrix-controller-build.public_ip
}

output "controller_vpc_id" {
  value = module.aviatrix-controller-build.vpc_id
}

output "controller_subnet_id" {
  value = module.aviatrix-controller-build.subnet_id
}

output "controller_admin_password" {
  value = var.ctrl_password
  sensitive = true
}

data "aws_caller_identity" "aws_account" {}

output "aws_account" {
  value = data.aws_caller_identity.aws_account.account_id
}
