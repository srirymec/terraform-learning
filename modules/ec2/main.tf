resource "aws_instance" "srini-test-tf" {
  ami                    = lookup(var.ami, var.region)
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.ec2-sg
  key_name               = var.ssh_key
  tags = {
    Name = var.name
  }
}
