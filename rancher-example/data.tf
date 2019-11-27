data "openstack_networking_network_v2" "ext-net" {
  name = "ext-net"
}

data "template_file" "cloud-config" {
  template = file("./config/cloud-config.yml")
  vars = {
    custom_ssh = openstack_compute_keypair_v2.keypair.public_key
  }
}

data "template_file" "cloud-config-rancher" {
  template = file("./config/cloud-config-rancher.yml")
  vars = {
    custom_ssh = openstack_compute_keypair_v2.keypair.public_key
  }
}