terraform {
  required_providers {
    openstack = {
      source = "terraform-providers/openstack"
    }
    template = {
      source = "hashicorp/template"
    }
    local = {
      source  = "hashicorp/local"
    }
    null = {
      source = "hashicorp/null"
    }
    rancher2 = {
      source = "rancher/rancher2"
    }
    rke = {
      source = "rancher/rke"
    }
  }
  required_version = ">= 0.13"
}
