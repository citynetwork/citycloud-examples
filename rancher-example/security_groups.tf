resource "openstack_networking_secgroup_v2" "sg" {
  name        = "rancher-sg"
  description = "Rancher project security group"
}

resource "openstack_networking_secgroup_rule_v2" "sg-rule-allow-all" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sg.id
}   


