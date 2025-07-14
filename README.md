# terraform-learning

## Terraform Cheat Sheet

[Terraform Cheat Sheet](https://github.com/srirymec/terraform-learning/blob/main/Terraform%20Cheat%20sheet.md)

## What Is Terraform?

Terraform is one of the most popular Infrastructure-as-code (IaC) tool, used by DevOps teams to automate infrastructure tasks. It is used to automate the provisioning of your cloud resources. Terraform is an open-source, cloud-agnostic provisioning tool developed by HashiCorp and written in GO language.

## Terraform Lifecycle

- **Terraform init** initializes the (local) Terraform environment. Usually executed only once per session.
- **Terraform plan** compares the Terraform state with the as-is state in the cloud, build and display an execution plan. This does not change the deployment (read-only).
- **Terraform apply** executes the plan. This potentially changes the deployment.
- **Terraform destroy** deletes all resources that are governed by this specific terraform environment.

## Terraform Core Concepts

- **Variables:** Terraform has input and output variables, it is a key-value pair. Input variables are used as parameters to input values at run time to customize our deployments. Output variables are return values of a terraform module that can be used by other configurations.
Read our blog on Terraform Variables
- **Provider:** Terraform users provision their infrastructure on the major cloud providers such as AWS, Azure, OCI, and others. A provider is a plugin that interacts with the various APIs required to create, update, and delete various resources.
- **Module:** Any set of Terraform configuration files in a folder is a module. Every Terraform configuration has at least one module, known as its root module.
- **State:** Terraform records information about what infrastructure is created in a Terraform state file. With the state file, Terraform is able to find the resources it created previously, supposed to manage and update them accordingly.
- **Resources:** Cloud Providers provides various services in their offerings, they are referenced as Resources in Terraform. Terraform resources can be anything from compute instances, virtual networks to higher-level components such as DNS records. Each resource has its own attributes to define that resource.
- **Data Source:** Data source performs a read-only operation. It allows data to be fetched or computed from resources/entities that are not defined or managed by Terraform or the current Terraform configuration.
- **Plan:** It is one of the stages in the Terraform lifecycle where it determines what needs to be created, updated, or destroyed to move from the real/current state of the infrastructure to the desired state.
- **Apply:** It is one of the stages in the Terraform lifecycle where it applies the changes real/current state of the infrastructure in order to achieve the desired state.


### Heading 3
