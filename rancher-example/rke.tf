resource "rke_cluster" "cluster" {
  cluster_name = "${var.prefix}-cluster"

  dynamic nodes {
    for_each = openstack_compute_floatingip_associate_v2.nodes-fip-assoc
    content {
      address = nodes.value.floating_ip
      user = "rancher"
      role = ["controlplane", "etcd", "worker"]
    }
  }

  ssh_key_path = "~/.ssh/id_rsa"

  # Disable port check validation between nodes
  disable_port_check = false

  addons_include = [
    "https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml",
    "https://gist.githubusercontent.com/superseb/499f2caa2637c404af41cfb7e5f4a938/raw/930841ac00653fdff8beca61dab9a20bb8983782/k8s-dashboard-user.yml",
  ]

  depends_on = [null_resource.wait-for-docker]

}

resource "local_file" "kube_cluster_yaml" {
  filename = "./kube_config_cluster.yml"
  sensitive_content = rke_cluster.cluster.kube_config_yaml
}

resource "null_resource" "wait-for-docker" {
  provisioner "local-exec" {
    command = "sleep 120"
  }
  depends_on = [openstack_compute_floatingip_associate_v2.nodes-fip-assoc]
}
