resource "openstack_compute_instance_v2" "rancher" {
  name = "${var.prefix}-server"
  image_name = "Ubuntu 20.04 Focal Fossa 20200423"
  flavor_name = var.flavor
  security_groups = ["default"]
  user_data = data.template_file.cloud-config-rancher.rendered
  config_drive = "true"
  power_state = "active"

  network {
    uuid = openstack_networking_network_v2.network.id
  }
}

resource "openstack_compute_instance_v2" "master" {
  count = var.n_of_masters
  name = "${var.prefix}-master-${count.index+1}"
  image_name = "Ubuntu 20.04 Focal Fossa 20200423"
  flavor_name = var.flavor
  security_groups = ["default"]
  user_data = data.template_file.cloud-config.rendered
  config_drive = "true"
  power_state = "active"

  network {
    uuid = openstack_networking_network_v2.network.id
  }
}

resource "openstack_compute_instance_v2" "worker" {
  count = var.n_of_workers
  name = "${var.prefix}-worker-${count.index+1}"
  image_name = "Ubuntu 20.04 Focal Fossa 20200423"
  flavor_name = var.flavor
  security_groups = ["default"]
  user_data = data.template_file.cloud-config.rendered
  config_drive = "true"
  power_state = "active"

  network {
    uuid = openstack_networking_network_v2.network.id
  }
}
