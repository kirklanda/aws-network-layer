# Overview
This project contains Terraform scripts to create a base AWS VPC and subnets. 

# TODO when using
- In the .gitignore file uncomment the line that prevents the init_gitlab_terraform_state.sh file from being included in version control. 

## Managing Layer Lifetimes
Where there is a division of team responsibilities then this project would be managed and run by a networking or infrastructure team and the resource made available to other teams to deploy higher level components and applications.

A full architecture deployed in an AWS environment will typically contain a number of layers, e.g. networking, data, other infrastructure and application.  The application layer is provided using containers that can be stood and torn down using `terraform apply` within a separate project.  This means cost is minimised and only charged for things that are consuming resources.

Since it's desirable for use of an environment to span longish timeframes, e.g. days, weeks or months, there must be a way to keep data between around between tearing down and standing up docker containers.  The project will split terraform scripts into a number of layers that can be applied independently but in order.  These are:
- Network Layer.  This will create a VPC and public and private subnets across availability zones.
- Data Layer.  This will create an AWS Elastic File System within the VPC that can be used for persisting container volumes.
- Application Layer.  This will deploy any docker containers using AWS Elastic Container Service.

Initially, this project will make use of `terraform_remote_state` for sharing data between configurations.  See Terraform's [Remote State](https://www.terraform.io/docs/language/state/remote.html) info.

# Usage
## Prerequisites
1. AWS CLI setup and configured.
2. Terraform installed.

Once a terminal environment (e.g. a local terminal or AWS Cloudshell) has been setup then clone this repository.

## Configuration and Execution
The network layer only has a couple of variables to set in order to run.  The `variables.tf` file lists the variables and their defaults. Create a file called `terraform.tfvars` to set values for variables.

From the root folder of this project run:
>`terraform init`<br>
>`terraform apply`
