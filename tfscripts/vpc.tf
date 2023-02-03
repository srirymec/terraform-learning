terraform {
  backend "s3" {
    bucket         = "srinitfstate493976-1"
    key            = "vpc.terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "srinitfstate"
  }
}

module "vpc" {
  source = "./../modules/networking"

  vpc_cidr    = ""
  subnet_cidr = ["10.0.2.0/24", "10.0.3.0/24"]
  #  subnet_cidr = {
  #    subnet1 = "10.0.2.0/23",
  #    subnet2 = "10.0.3.0/24"
  #  }
}
