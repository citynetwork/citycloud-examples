
resource "openstack_images_image_v2" "ros-image" {
  name              = "RancherOS"
  image_source_url  = "https://releases.rancher.com/os/latest/rancheros-openstack.img"
  container_format  = "bare"
  disk_format       = "qcow2"
}

resource "openstack_compute_instance_v2" "rancher" {
  name = "${var.prefix}-rancher"
  image_id = openstack_images_image_v2.ros-image.id
  flavor_name = var.flavor
  security_groups = [openstack_networking_secgroup_v2.sg.name]
  user_data = data.template_file.cloud-config-rancher.rendered
  config_drive = "true" # Required by RancherOS when using cloud-config.yml at booting
  power_state = "active"

  network {
    uuid = openstack_networking_network_v2.network.id
  }
}

resource "openstack_compute_instance_v2" "nodes" {
  count = 3
  name = "${var.prefix}-node-${count.index+1}"
  image_id = openstack_images_image_v2.ros-image.id
  flavor_name = var.flavor
  security_groups = [openstack_networking_secgroup_v2.sg.name]
  user_data = data.template_file.cloud-config.rendered
  config_drive = "true" # Required by RancherOS when using cloud-config.yml at booting
  power_state = "active"

  network {
    uuid = openstack_networking_network_v2.network.id
  }
}
