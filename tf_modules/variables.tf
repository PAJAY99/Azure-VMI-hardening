variable "region" {
  description = "Region to spin up Azure instance"
  default = "East US"
}

variable "instance_type" {
  description = "Azure instance type"
  default = "t2.micro"
}