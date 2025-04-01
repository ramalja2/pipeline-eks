variable "name" {
  default = "prod"
}

variable "env" {
  default = "production"
}

variable "zone" {
  default = ["us-west-2a" , "us-west-2b"]
}

variable "subnet_cidr" {
  default = ["192.168.1.0/24" , "192.168.2.0/24"]
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "default" {
  default = "0.0.0.0/0"
}