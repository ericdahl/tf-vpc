variable "admin_ip_cidr" {
  default = "0.0.0.0/0"
}

variable "enable_endpoint_s3" {
  default = "true"
}

variable "enable_endpoint_dynamo" {
  default = "true"
}

variable "tags" {
  type = "map"
  description = "map of tags to apply to all created resources"
  default = {}
}

variable "private_subnet_tags" {
  type = "map"
  default = {}
}

variable "public_subnet_tags" {
  type = "map"
  default = {}
}