resource "openstack_compute_keypair_v2" "keypair" {
  name = "${var.prefix}-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}
