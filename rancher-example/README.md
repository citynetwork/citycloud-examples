
# Rancher RKE example

## Requirements

- Terraform: v0.12+
- Terraform RKE Community Provider: v0.14.1+
- Kubectl v1.16.3+

## Setup
- 1 VM for the Rancher Server
- 3 VMs for the Master (etcd + controlplane) and Worker nodes

## Provision the cluster
Source your openstack.rc file and run `terraform apply`

## Verify the cluster
Check connectivity:

```
$ kubectl --kubeconfig kube_config_cluster.yml get nodes    
NAME             STATUS   ROLES                      AGE   VERSION
86.107.243.178   Ready    controlplane,etcd,worker   34m   v1.14.6
86.107.243.193   Ready    controlplane,etcd,worker   34m   v1.14.6
86.107.243.20    Ready    controlplane,etcd,worker   34m   v1.14.6
```
and cluster status:

```
$ kubectl --kubeconfig=kube_config_cluster.yml get pods --all-namespaces
NAMESPACE       NAME                                      READY   STATUS      RESTARTS   AGE
ingress-nginx   default-http-backend-5954bd5d8c-4jlmw     1/1     Running     0          33m
ingress-nginx   nginx-ingress-controller-bng8n            1/1     Running     0          33m
ingress-nginx   nginx-ingress-controller-m74fj            1/1     Running     0          33m
ingress-nginx   nginx-ingress-controller-s2q6l            1/1     Running     0          33m
kube-system     canal-9mjrc                               2/2     Running     0          34m
kube-system     canal-c2flq                               2/2     Running     0          34m
kube-system     canal-m49l9                               2/2     Running     0          34m
kube-system     coredns-autoscaler-5d5d49b8ff-44jdl       1/1     Running     0          33m
kube-system     coredns-bdffbc666-pxsk7                   1/1     Running     0          33m
kube-system     metrics-server-7f6bd4c888-wwrwc           1/1     Running     0          33m
kube-system     rke-coredns-addon-deploy-job-htbhs        0/1     Completed   0          33m
kube-system     rke-ingress-controller-deploy-job-p2442   0/1     Completed   0          33m
kube-system     rke-metrics-addon-deploy-job-cxcxr        0/1     Completed   0          33m
kube-system     rke-network-plugin-deploy-job-dbk5z       0/1     Completed   0          34m
```

## Access the Kubernetes Dashboard
Generate your token using the following command:

```
$ kubectl --kubeconfig kube_config_cluster.yml -n kube-system describe secret $(kubectl --kubeconfig kube_config_cluster.yml -n kube-system get secret | grep admin-user | awk '{print $1}') | grep ^token: | awk '{ print $2 }'
eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5l...
```

Set up the kubectl proxy using:
```
$ kubectl --kubeconfig kube_config_cluster.yml proxy
Starting to serve on 127.0.0.1:8001

```
and login at:

`http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/` 

using the token generated in the previous step.

## Access the Rancher UI

Open the link prompted at the end of the terraform configuration: 

``` python
Apply complete! Resources: 24 added, 0 changed, 0 destroyed.

Outputs:

Rancher_Server_IP = https:// . . . .
```

As this is just an example and no real certificates have been used.We recommend to use an old version of your browser or less strict browsers as Firefox or Safari (Mac)


## Congratulations! 
You have just created your first Kubernetes Cluster.

####Happy clustering!