variable "lab_environment_name" {
  description = "A unique name for the lab environment that will distinguish it from other labs"
  type = string
}

variable "aws_default_region" {
  description = "The AWS region to use for the lab"
  type = string
}

variable "aws_access_key_id" {
  type = string
  sensitive = true
}

variable "aws_secret_access_key" {
  type = string
  sensitive = true
}