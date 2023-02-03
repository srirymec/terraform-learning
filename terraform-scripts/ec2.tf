resource "aws_instance" "srini-test-tf" {
  ami                    = lookup(var.AMI, var.AWS_REGION)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-subnet-srini-vpc.id
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  key_name               = "srini"
}
