resource "openstack_compute_keypair_v2" "keypair" {
  name = "${var.prefix}-keypair"
  public_key = file("${var.ssh_key}.pub")
}
