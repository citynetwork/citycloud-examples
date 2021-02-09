
# Rancher RKE example

## Software Requirements

- Terraform: v0.13+
- Kubectl v1.16.3+

## Target Setup
- 1 VM for the Rancher Server
- 3 VMs as both Master (etcd + controlplane) and Worker nodes

## Provision the cluster
Source your openstack.rc file. 

Run `terraform init` and `terraform apply` in the directory containing the `*.tf files

## Verify the cluster
Check connectivity:

```
$ kubectl --kubeconfig kube_config_cluster.yml get nodes
NAME             STATUS   ROLES               AGE     VERSION
91.123.203.112   Ready    worker              3m56s   v1.18.6
91.123.203.127   Ready    controlplane,etcd   3m56s   v1.18.6
91.123.203.84    Ready    worker              3m51s   v1.18.6

```
and cluster status:

```
$ kubectl --kubeconfig=kube_config_cluster.yml get pods --all-namespaces
NAMESPACE       NAME                                      READY   STATUS      RESTARTS   AGE
ingress-nginx          default-http-backend-598b7d7dbd-z6qnl        1/1     Running     0          34m
ingress-nginx          nginx-ingress-controller-2x7qr               1/1     Running     0          34m
ingress-nginx          nginx-ingress-controller-7rmd5               1/1     Running     0          34m
kube-system            canal-8p7ls                                  2/2     Running     0          34m
kube-system            canal-h246j                                  2/2     Running     0          34m
kube-system            canal-pq2js                                  2/2     Running     0          34m
kube-system            coredns-849545576b-6w98j                     1/1     Running     0          34m
kube-system            coredns-849545576b-n68v7                     1/1     Running     0          33m
kube-system            coredns-autoscaler-5dcd676cbd-fvxxs          1/1     Running     0          34m
kube-system            metrics-server-697746ff48-v2pkm              1/1     Running     0          34m
kube-system            rke-coredns-addon-deploy-job-tnszg           0/1     Completed   0          34m
kube-system            rke-ingress-controller-deploy-job-h72sz      0/1     Completed   0          34m
kube-system            rke-metrics-addon-deploy-job-k8xhw           0/1     Completed   0          34m
kube-system            rke-network-plugin-deploy-job-z64ht          0/1     Completed   0          34m
kube-system            rke-user-addon-deploy-job-76ljk              0/1     Completed   0          34m
kube-system            rke-user-includes-addons-deploy-job-w6qv5    0/1     Completed   0          20m
kubernetes-dashboard   dashboard-metrics-scraper-78f5d9f487-t4c2b   1/1     Running     0          33m
kubernetes-dashboard   kubernetes-dashboard-59ddbcfdcb-zm7d8        1/1     Running     0          33m
```

## Access the Kubernetes Dashboard
Generate your token using the following command:

```
$ kubectl --kubeconfig kube_config_cluster.yml -n kube-system describe secret $(kubectl --kubeconfig kube_config_cluster.yml -n kube-system get secret | grep admin-user | awk '{print $1}') | grep ^token: | awk '{ print $2 }'
eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5l...
```

Launch kubectl proxy with:
```
$ kubectl --kubeconfig kube_config_cluster.yml proxy
Starting to serve on 127.0.0.1:8001

```
and login at:

`http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/` 

Paste the Token generated earlier and get access to the Kubernetes Dashboard.

## Access the Rancher UI

Open the link prompted at the end of the Terraform configuration: 

```
Apply complete! Resources: 24 added, 0 changed, 0 destroyed.

Outputs:

Rancher_Server_IP = https://_._._._
```

As this is just an example and no real certificates have been used, you need to use a browser that will allow you to override the certificate warnings as for example Firefox or Safari.

## Congratulations! 
You have just created your first Kubernetes Cluster and imported it into Rancher, one of the most complete open-source Kubernetes Manager.

This basic example presented an easy way to deploy your Kubernetes cluster using Openstack resources in CityCloud and then manage them via the Rancher Management server.

Cluster creation can also be automated and our [Rancher as a Service (RaaS)](https://kb.citynetwork.eu/kb/documentation/kubernetes-containers/rancher-as-a-service-raas) solution comes with a fully automated way to deploy and handle your cluster via our managed Rancher Management server available in Public and Compliant Cloud.

Happy clustering!