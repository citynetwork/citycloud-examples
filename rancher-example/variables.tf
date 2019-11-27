
##################################
###  CUSTOM vars
##################################

variable "prefix" {
  default = "example-rancher"
}

variable "flavor" {
  default = "4C-8GB-50GB" # Minimal requirement to enable monitoring
}

variable "cidr" {
  default = "10.0.0.0/24"
}

variable "ssh_pub_key" {
  default = "~/.ssh/id_rsa.pub"
}