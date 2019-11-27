
resource "openstack_networking_network_v2" "network" {
  name           = "${var.prefix}-network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = "${var.prefix}-subnet"
  network_id = openstack_networking_network_v2.network.id
  cidr       = var.cidr
}

resource "openstack_networking_router_v2" "router" {
  name                = "${var.prefix}-router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.ext-net.id
}

resource "openstack_networking_router_interface_v2" "router-if" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

resource "openstack_compute_floatingip_v2" "rancher-fip" {
  pool  = data.openstack_networking_network_v2.ext-net.id
}

resource "openstack_compute_floatingip_associate_v2" "rancher-fip-assoc" {
  floating_ip = openstack_compute_floatingip_v2.rancher-fip.address
  instance_id = openstack_compute_instance_v2.rancher.id
}

resource "openstack_compute_floatingip_v2" "nodes-fip" {
  count = 3
  pool  = data.openstack_networking_network_v2.ext-net.id
}

resource "openstack_compute_floatingip_associate_v2" "nodes-fip-assoc" {
  count = 3
  floating_ip = element(openstack_compute_floatingip_v2.nodes-fip.*.address,count.index+1)
  instance_id = element(openstack_compute_instance_v2.nodes.*.id,count.index+1)
}

