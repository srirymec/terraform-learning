output "vpc_id" {
  value = aws_vpc.srini-vpc.id
}

output "public-subnet-srini-vpc-id" {
  value = aws_subnet.public-subnet-srini-vpc.id
}

output "ec2-sg-id" {
  value = aws_security_group.ec2-sg.id
}