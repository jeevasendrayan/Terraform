variable "region" {
    default = "us-east-1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "public_subnet_cidrs" {
    default = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "private_subnet_cidrs" {
    default = ["10.0.6.0/24", "10.0.7.0/24"]
}

variable "availability_zones" {
    default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}
variable "project_name" {
  default = "jeeva"
}