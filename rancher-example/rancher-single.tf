provider "rancher2" {
  alias = "bootstrap"
  api_url = "https://${openstack_compute_floatingip_v2.rancher-fip.address}"
  bootstrap = true
  insecure = true
}

resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap
  password = "admin123"
  depends_on = [openstack_compute_floatingip_associate_v2.rancher-fip-assoc, null_resource.wait-for-docker]
}

provider "rancher2" {
  alias = "admin"
  api_url = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
  insecure = true
}