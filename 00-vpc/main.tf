module "vpc" {

  # source      = "../../terraform-aws-vpc"
  source      = "git::https://github.com/jayakumarm06/terraform-aws-vpc.git?ref=main"
  project     = var.project
  environment = var.environment
}
