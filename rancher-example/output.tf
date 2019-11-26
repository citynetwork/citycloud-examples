output "Rancher_Server_IP" {
  value = "${openstack_compute_floatingip_associate_v2.server-fip-assoc.floating_ip}"
}