variable "ami" {
  type = map(string)
  default = {
    us-east-1 = "ami-0aa7d40eeae50c9a9"
  }
}

variable "region " {
  default = "us-east-1"
}

variable "ssh_key" {}

variable "name" {}

variable "instance_type" {}

variable "subnet_id" {}

variable "ec2-sg" {}