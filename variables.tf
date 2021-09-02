# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "eu-central-1"
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t2.micro"
  sensitive = false
}

# AWS EC2 Instance AMI
variable "instance_ami" {
  description = "Ubuntu Instance AMI"
  type = string
  default = "ami-05f7491af5eef733a"
}

#DB Instance

variable "db_type" {
  type    = string
  default = "mysql"
}
variable "rds_master_username" {
  type    = string
  default = "none"
}
variable "rds_master_password" {
  type    = string
  default = "none"
}
variable "url" {
  type    = string
  default = "http://svg-map.org"
}
variable "url_admin" {
  type    = string
  default = "http://svg-map.org/admin"
}

# Route 53

variable "site_name" {
  type    = string
  default = ""
}
variable "domain_name" {
  type    = string
  default = "svg-map.org"
}

variable "ip" {
  type    = string
  default = "1.1.1.1"
}