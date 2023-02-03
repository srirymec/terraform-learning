configuration = [
  {
    "application_name" : "GritfyApp-dev",
    "ami" : "ami-0aa7d40eeae50c9a9",
    "no_of_instances" : "2",
    "instance_type" : "t2.micro",
    "subnet_id" : "subnet-0fd4f586fd4a67350",
    "vpc_security_group_ids" : ["sg-087be41765491d4c6", "sg-0b255e875a75f14f8"],
    "ssh_key" : "srini"
  },
  {
    "application_name" : "GrityWeb-dev",
    "ami" : "ami-0aa7d40eeae50c9a9",
    "instance_type" : "t2.small",
    "no_of_instances" : "1"
    "subnet_id" : "subnet-030c15559be9998eb"
    "vpc_security_group_ids" : ["sg-087be41765491d4c6"],
    "ssh_key" : "srini"
  }
]
