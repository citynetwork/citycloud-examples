
resource "openstack_networking_secgroup_v2" "sg" {
  name = "${var.prefix}-sg"
  description = "Rancher project security group"
}

resource "openstack_networking_secgroup_rule_v2" "all-in" {
  direction = "ingress"
  ethertype = "IPv4"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sg.id
}
