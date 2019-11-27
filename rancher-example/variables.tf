
##################################
###  CUSTOM vars
##################################

variable "prefix" {
  default = "example-rancher"
}

variable "flavor" {
  default = "4C-8GB-50GB" # Use this flavor to enable monitoring
}

variable "cidr" {
  # Kna1 = "10.1.0.0/24"
  # Dx1  = "10.8.0.0/24"
  # Fra1 = "10.6.0.0/24"
  # Sto2 = "10.2.0.0/24"
  default = "10.6.0.0/24"
}