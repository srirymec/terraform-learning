variable "AMI" {
  type = map(string)
  default = {
    us-east-1 = "ami-0aa7d40eeae50c9a9"
  }
}

variable "AWS_REGION" {
  default = "us-east-1"
}
