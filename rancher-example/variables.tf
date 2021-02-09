
##################################
###  CUSTOM vars
##################################

variable "prefix" {
  default = "example-rancher"
}

variable "n_of_masters" {
  default = 1
}

variable "n_of_workers" {
  default = 2
}

variable "flavor" {
  default = "4C-8GB-50GB"
}

variable "cidr" {
  default = "10.1.0.0/24"
}

variable "ssh_key" {
  default = "~/.ssh/id_rsa"
}

variable "k8s_dashboard_version" {
  default = "2.1.0"
}