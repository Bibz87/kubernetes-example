# Installation

## :computer: K3s & node registration

More detailed instructions can be found [here](https://anthonynsimon.com/blog/kubernetes-cluster-raspberry-pi/#installing-k3s-on-the-raspberry-pi) or [here](https://blog.differentpla.net/blog/2020/02/06/k3s-raspi-install-k3s).

1. Install k3s: `curl -sfL https://get.k3s.io | sh -`
2. Retrieve kubeconfig file: `sudo cat /etc/rancher/k3s/k3s.yaml`
3. Retrieve cluster token: `sudo cat /var/lib/rancher/k3s/server/node-token`
4. On each node, register with cluster: `curl -sfL https://get.k3s.io | K3S_URL=https://$YOUR_SERVER_NODE_IP:6443 K3S_TOKEN=$YOUR_CLUSTER_TOKEN sh -`

## :book: External DNS

1. Update Helm [values](./vault/helm/values.yaml) to match with your setup/needs
2. Install chart: `helm install external-dns --namespace external-dns --create-namespace external-dns`

Update your network interface to use your cluster as DNS, otherwise installing
the remaining components will be more complicated.

## :unlock: Vault unsealer

1. Add helm repository: `helm repo add vault-autounseal
   https://pytoshka.github.io/vault-autounseal`
2. Install chart: `helm install vault-unsealer vault-autounseal/vault-autounseal
   --namespace vault-unsealer --create-namespace -f vault-unsealer/values.yaml`

## :classical_building: HashiCorp Vault

1. Update Helm [values](./vault/helm/values.yaml) to match with your setup/needs
2. Install chart dependencies: `helm dependency build vault/helm`
3. Install chart: `helm install vault --namespace vault --create-namespace vault/helm`
