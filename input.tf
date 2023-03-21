variable "cidr-block-subnet1" {
  type        = list(string)
  default     = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24"]
  description = "variable for subnet1"
}
/*variable "cidr-block-subnet2" {
 type        = string
 default     = "192.168.1.0/24"
 description = "variable for subnet2"
}
variable "cidr-block-subnet3" {
  type        = string
  default     = "192.168.2.0/24"
  description = "variable for subnet3"
}*/
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "region description"
}

variable "app-name" {
  type        = list(string)
  default     = ["subnet1", "subnet2", "subnet3"]
  description = "app name description"
}
variable "subnet-azs" {
  type    = list(string)
  default = ["a", "b", "c"]
}