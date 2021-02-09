output "Rancher_Server_IP" {
  value = "https://${openstack_compute_floatingip_v2.rancher-fip.address}"
}

output "Note" {
  value = "Wait a few minutes for Rancher to come up!"
}