resource "openstack_compute_keypair_v2" "keypair" {
  name = "rancher-keypair"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "openstack_images_image_v2" "ros-image" {
  name              = "RancherOS"
  image_source_url  = "https://releases.rancher.com/os/latest/rancheros-openstack.img"
  container_format  = "bare"
  disk_format       = "qcow2"

  properties = {
    key = "value"
  }
}

resource "openstack_compute_instance_v2" "server" {
  name              = "rancher-server"
  image_id          = openstack_images_image_v2.ros-image.id
  flavor_name       = "4C-8GB-50GB"
  security_groups   = [openstack_networking_secgroup_v2.sg.name]
  key_pair          = openstack_compute_keypair_v2.keypair.name
  config_drive      = "true" # Required by RancherOS when using cloud-config.yml at booting
  power_state       = "active"

  network {
    name = openstack_networking_network_v2.network.name
  }
}

resource "openstack_compute_instance_v2" "nodes" {
  count             = 3
  name              = "rancher-node-${count.index+1}"
  image_id          = openstack_images_image_v2.ros-image.id
  flavor_name       = "4C-8GB-50GB"
  security_groups   = [openstack_networking_secgroup_v2.sg.name,]
  key_pair          = openstack_compute_keypair_v2.keypair.name
  config_drive      = "true" # Required by RancherOS when using cloud-config.yml at booting
  power_state       = "active"

  network {
    name = openstack_networking_network_v2.network.name
  }
}
