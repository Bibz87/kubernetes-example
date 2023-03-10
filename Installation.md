# Installation

## :computer: K3s & node registration

More detailed instructions can be found
[here](https://anthonynsimon.com/blog/kubernetes-cluster-raspberry-pi/#installing-k3s-on-the-raspberry-pi)
or [here](https://blog.differentpla.net/blog/2020/02/06/k3s-raspi-install-k3s).

1. Install k3s: `curl -sfL https://get.k3s.io | sh -`
2. Retrieve kubeconfig file: `sudo cat /etc/rancher/k3s/k3s.yaml`
3. Update the kubeconfig's cluster IP address to match with your cluster's
4. Retrieve cluster token: `sudo cat /var/lib/rancher/k3s/server/node-token`
5. On each worker node, register with cluster: `curl -sfL https://get.k3s.io |
   K3S_URL=https://$YOUR_SERVER_NODE_IP:6443 K3S_TOKEN=$YOUR_CLUSTER_TOKEN sh -`
   * :warning: Replace `$YOUR_SERVER_NODE_IP` with your cluster's IP address
   * :warning: Replace `$YOUR_CLUSTER_TOKEN` with your cluster's token

## :book: External DNS

:warning: The `External DNS` chart has trouble on systems running `systemd-resolved`:
the `Service` gets installed before the `Pod` is able to pull the container's
image and highjacks all DNS requests, making it impossible for the `Pod` to be
created properly. A workaround is to change `/etc/resolv.conf` on all cluster
nodes to point to `/run/systemd/resolve/resolv.conf`: `sudo ln -sf
/run/systemd/resolve/resolv.conf /etc/resolv.conf`

1. Update Helm [values](./external-dns/values.yaml) to match with your setup/needs
2. Install chart: `helm install external-dns --namespace external-dns
   --create-namespace external-dns`

:warning: Update your network interface to use your cluster as DNS, otherwise installing
the remaining components will be more complicated.

## :unlock: Vault unsealer

1. Add helm repository: `helm repo add vault-autounseal
   https://pytoshka.github.io/vault-autounseal`
2. Install chart: `helm install vault-unsealer vault-autounseal/vault-autounseal
   --namespace vault-unsealer --create-namespace -f vault-unsealer/values.yaml`

:warning: Vault unsealer won't do anything until Vault is installed on the cluster and
this is the expected behaviour.

## :scroll: cert-manager

1. Add helm repository: `helm repo add jetstack https://charts.jetstack.io`
2. Install chart dependencies: `helm dependency build cert-manager`
3. Install Custom Resource Definitions (CRDs): `kubectl apply -f
   https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.crds.yaml`
4. Install chart: `helm install cert-manager --namespace cert-manager
   --create-namespace cert-manager`

:warning: cert-manager's `vault-issuer` won't be ready until Vault is installed on the
cluster and this is the expected behaviour.

## :classical_building: HashiCorp Vault

1. Update Helm [values](./vault/helm/values.yaml) to match with your setup/needs
2. Add helm repository: `helm repo add hashicorp
   https://helm.releases.hashicorp.com`
3. Install chart dependencies: `helm dependency build vault/helm`
4. Install chart: `helm install vault --namespace vault --create-namespace
   vault/helm`
5. Check `vault-unsealer` logs to know when Vault has been initialised and
   unsealed: `kubectl logs -f --namespace vault-unsealer
   deployment/vault-unsealer`
6. Once Vault is unsealed, retrieve Vault's root token: `kubectl get secret
   --namespace vault-unsealer vault-root-token --template={{.data.root_token}} |
   base64 -d`
7. Store token in Terraform's sensitive variables file: `echo "vault_token =
   \"$ROOT_TOKEN\"" > vault/terraform/sensitive.auto.tfvars`
   * :warning: Replace `$ROOT_TOKEN` with Vault's root token
   * Root token can also be given interactively when running Terraform
     commands instead of being stored in a file
   * :stop_sign: *Never* commit sensitive information such as tokens in your git
     repository!
8. Update Vault's Terraform [variables file](./vault/terraform/vault.auto.tfvars) to match
   with your setup/needs
   * :warning: Make sure Vault's address (`vault_addr` variable) is using `http` until
     Vault setup is complete
9. Initialize Terraform configuration: `terraform -chdir=vault/terraform init`
   * To use a different kubeconfig file from the default (`~/kube/.config`),
     simply add the `-backend-config` argument. e.g. `terraform
     -chdir=vault/terraform init
     -backend-config="config_path=/path/to/other/kubeconfig"`
10. Configure Vault by applying Terraform configuration: `terraform
   -chdir=vault/terraform apply`
11. Review changes and type `yes` to apply them
12. Add `vault/terraform/root.crt` to your trusted certificate store
13. Fix Vault's address in Terraform's [variables
    file](./vault/terraform/vault.auto.tfvars) by replacing `http` with `https`
14. Re-apply Vault's Terraform configuration: `terraform -chdir=vault/terraform
    apply`

## :chart_with_upwards_trend: Kubernetes dashboard

1. Add helm repository: `helm repo add kubernetes-dashboard
   https://kubernetes.github.io/dashboard/`
2. Install chart dependencies: `helm dependency build dashboard`
3. Install chart: `helm install kubernetes-dashboard --namespace
kubernetes-dashboard --create-namespace dashboard`
4. Generate token for dashboard sign-in: `kubectl -n kubernetes-dashboard create
   token admin-user`
5. Use generated token to sign in Kubernetes dashboard
