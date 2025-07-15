# Terraform-learning

## Terraform Cheat Sheet

[Terraform Cheat Sheet](https://github.com/srirymec/terraform-learning/blob/main/Terraform%20Cheat%20sheet.md)

## What Is Terraform?

Terraform is one of the most popular Infrastructure-as-code (IaC) tool, used by DevOps teams to automate infrastructure tasks. It is used to automate the provisioning of your cloud resources. Terraform is an open-source, cloud-agnostic provisioning tool developed by HashiCorp and written in GO language.

## Terraform Lifecycle

Terraform lifecycle consists of – **init**, **plan**, **apply**, and **destroy**.

![Terraform life cycle](https://github.com/srirymec/terraform-learning/blob/main/terraform-lifecycle.png)

- **terraform init** initializes the (local) Terraform environment. Usually executed only once per session.
- **terraform plan** compares the Terraform state with the as-is state in the cloud, build and display an execution plan. This does not change the deployment (read-only).
- **terraform apply** executes the plan. This potentially changes the deployment.
- **terraform destroy** deletes all resources that are governed by this specific terraform environment.

## Terraform Core Concepts

- **Variables:** Terraform has input and output variables, it is a key-value pair.<br/>

  **Supported variable types**

  > - string 
  > - number 
  > - bool 
  > - any 
  > - list 
  > - map 
  > - object 
  > - tuple 
  
- **Provider:** Terraform users provision their infrastructure on the major cloud providers such as AWS, Azure, OCI, and others. A provider is a plugin that interacts with the various APIs required to create, update, and delete various resources.
  ```
  Terraform { 
    required_providers { 
         local = { 
             source = "hashicorp/local" 
             version = "1.4.0" ("!=2.0.0" | "< 1.4.0" | "> 1.1.0" | "> 1.2.0, < 2.0.0, != 1.4.0"| "~> 1.2") 
         } 
     } 
  }
  ```

  ```
  terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
   }
  }
  ```
  
- **Module:** Any set of Terraform configuration files in a folder is a module.

  **Module ec2**
  > **main.tf**
  > ```
  > resource "aws_instance" "my_ec2" {
  >  name = var.name
  >  ------
  >  ------
  > }
  > ```
  > 
  > **variables.tf**
  > ```
  > variable "name" {}
  > variable "instance_type" {}
  > variable "subnet_id" {}
  > variable "ec2-sg" {}
  > ```
  >
  > **outputs.tf**
  > ```
  > output "private_dns" {
  >   value = aws_instance.my_ec2.private_dns
  > }
  > ```
  >

   **Client class**
  > **ec2.tf**
  > ```
  > module ec2 {
  >   source = "./../modules/ec2"
  >   name = var.name
  >   -------
  >   -------
  > }
  > ```
  > 
  > **variables.tf**
  > ```
  > variable "name" {}
  > variable "instance_type" {}
  > variable "subnet_id" {}
  > variable "ec2-sg" {}
  > ```
  >
  > **providers.tf**
  > ```
  > terraform {
  >   required_providers {
  >     aws = {
  >     source  = "hashicorp/aws"
  >     version = "~> 4.0"
  >    }
  >   }
  >
  >   backend "s3" {
  >     bucket         = "srini-test-123"
  >     key            = "terraform.tfstate"
  >     region         = "us-east-1"
  >   }
  > }
  > ```
  >
  > **variables.tfvars**
  > ```
  > name = "srini-test-instance"
  > instance_type = "t2.micro"
  > ------
  > ------
  > ```
  > 
- **State:** Terraform records information about what infrastructure is created in a Terraform state file. The state file is created **only after the apply is run atleast once**.
- **Resources:** Cloud Providers provides various services in their offerings, they are referenced as Resources in Terraform. 
- **Data Source:** Data source performs a read-only operation. It allows data to be fetched or computed from resources/entities that are not defined or managed by Terraform or the current Terraform configuration.
- **Plan:** It is one of the stages in the Terraform lifecycle where it determines what needs to be created, updated, or destroyed to move from the real/current state of the infrastructure to the desired state.
- **Apply:** It is one of the stages in the Terraform lifecycle where it applies the changes real/current state of the infrastructure in order to achieve the desired state.

## Terraform Configuration Files

- **Configuration file (*.tf files):** Here we declare the provider and resources to be deployed along with the type of resource and all resources specific settings
- **Variable declaration file (variables.tf or variables.tf.json):** Here we declare the input variables required to provision resources
- **Variable definition files (terraform.tfvars):** Here we assign values to the input variables
- **State file (terraform.tfstate):** a state file is created once after Terraform is run. It stores state about our managed infrastructure.

**variables.tf**
  ```
  variable "prefix" { 
     default = ["Mr", "Mrs", "Sir"] 
      type = list 
  } 
 
  variable "length" { 
     default = 2 
     type = number 
     description = "" 
  } 
  ```

  **main.tf**
  ```
  resource "random_pet" "mypet"{ 
     prefix = var.prefix[0] 
     length = var.length 
  }
  ```

  **If you want to use the output generated by one resource as input to other:**
 
  ${random_pet.mypet.id} ---> Since random_pet returns the id of the pet created. 

  **outputs.tf**
  ```
  output pet-name { 
     value = random_pet.mypet.id 
     description = "record the value of random_pet generated" 
  }
  ```

  After terraform apply, the output variables with value is printed on the console. 
  We can also see the output variables list with values using the command,<br/>
  **terraform output**

## Terraform lifecycle management

- **create_before_destroy:** If set to true, new resource to be created first, then older one to be deleted.
  ```
  resource "local_file" "pet"{ 
    filename = "/var/tmp/pets.txt" 
    content = "we love pets" 
 
    lifecycle { 
        create_before_destroy = true 
    } 
  }
  ```
  
- **prevent_destroy:** Prevents resource deletion when config is changed and terraform apply is run. The resource can still be deleted if **terraform destroy** is used.
  ```
  resource "local_file" "pet"{ 
    filename = "/var/tmp/pets.txt" 
    content = "we love pets" 
 
    lifecycle { 
        prevent_destroy = true 
    } 
  } 
  ```
  
- **ignore_changes:** Accepts a list of valid attributes in the resource to ignore the changes made outside terraform (manually or cli)
  ```
  resource "aws_instance" "webserver" { 
     ami = "ami---" 
     instance_type = "t2.micro" 
     tags = { 
           Name = "ProjectA-webserver" 
     } 
 
    lifecycle { 
        ignore_changes = [ tags/all ] 
    } 
  }
  ```

## Terraform Data Source

Manage resources created outside terraform. <br/>
Use keyword **data**

```
data "aws_ami" "example" {
  most_recent = true

  owners = ["self"]
  tags = {
    Name   = "app-server"
    Tested = "true"
  }
}

```
