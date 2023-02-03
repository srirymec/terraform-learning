resource "aws_vpc" "srini-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "srini-vpc"
  }
}

resource "aws_subnet" "public-subnet-srini-vpc" {
  vpc_id                  = aws_vpc.srini-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public-subnet-srini-vpc"
  }
}

resource "aws_subnet" "private-subnet-srini-vpc" {
  vpc_id            = aws_vpc.srini-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-subnet-srini-vpc"
  }
}

resource "aws_security_group" "ec2-sg" {
  vpc_id = aws_vpc.srini-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    // This means, all ip address are allowed to ssh ! 
    // Do not do it in the production. 
    // Put your office or home address in it!
    cidr_blocks = ["0.0.0.0/0"]
  }
  //If you do not add this rule, you can not reach the NGIX  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ec2-sg"
  }
}


resource "aws_internet_gateway" "igw-srini-vpc" {
  vpc_id = aws_vpc.srini-vpc.id
  tags = {
    Name = "igw-srini-vpc"
  }
}

#resource "aws_eip" "eip-srini-vpc"{ 
#}

#resource "aws_nat_gateway" "nat-srini-vpc" {
#  allocation_id = aws_eip.eip-srini-vpc.id
#  subnet_id = aws_subnet.public-subnet-srini-vpc.id
#  tags {
#   Name = "nat-srini-vpc"
#}
#}

resource "aws_route_table" "public-rt-srini-vpc" {
  vpc_id = aws_vpc.srini-vpc.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.igw-srini-vpc.id
  }

  tags = {
    Name = "public-rt-srini-vpc"
  }
}

resource "aws_route_table_association" "public-rt-public-subnet" {
  subnet_id      = aws_subnet.public-subnet-srini-vpc.id
  route_table_id = aws_route_table.public-rt-srini-vpc.id
}
