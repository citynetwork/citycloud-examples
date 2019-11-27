
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

/*
resource "openstack_networking_secgroup_rule_v2" "in-22" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sg.id
}

resource "openstack_networking_secgroup_rule_v2" "in-80" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 80
  port_range_max = 80
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sg.id
}

resource "openstack_networking_secgroup_rule_v2" "in-443" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 443
  port_range_max = 443
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sg.id
}
*/
