# Installation

## :computer: K3s & node registration

More detailed instructions can be found
[here](https://anthonynsimon.com/blog/kubernetes-cluster-raspberry-pi/#installing-k3s-on-the-raspberry-pi)
or [here](https://blog.differentpla.net/blog/2020/02/06/k3s-raspi-install-k3s).

1. Install k3s: `curl -sfL https://get.k3s.io | sh -`
2. Retrieve kubeconfig file: `sudo cat /etc/rancher/k3s/k3s.yaml`
3. Retrieve cluster token: `sudo cat /var/lib/rancher/k3s/server/node-token`
4. On each node, register with cluster: `curl -sfL https://get.k3s.io |
   K3S_URL=https://$YOUR_SERVER_NODE_IP:6443 K3S_TOKEN=$YOUR_CLUSTER_TOKEN sh -`

## :book: External DNS

1. Update Helm [values](./vault/helm/values.yaml) to match with your setup/needs
2. Install chart: `helm install external-dns --namespace external-dns
   --create-namespace external-dns`

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
3. Install chart: `helm install vault --namespace vault --create-namespace
   vault/helm`
4. Check `vault-unsealer` logs to know when Vault has been initialised and
   unsealed: `kubectl logs -f --namespace vault-unsealer
   deployment/vault-unsealer`
5. Once Vault is unsealed, retrieve Vault's root token: `kubectl get secret
   --namespace vault-unsealer vault-root-token --template={{.data.root_token}} |
   base64 -d`
6. Store token in Terraform's sensitive variables file: `echo "vault_token =
   \"$ROOT_TOKEN\"" > vault/terraform/sensitive.auto.tfvars`
   - ⚠ Replace `$ROOT_TOKEN` with Vault's root token
   - ℹ Root token can also be given interactively when running Terraform
     commands instead of being stored in a file
   - 🛑 *Never* commit sensitive information such as tokens in your git
     repository!
7. Update Vault's [variables file](./vault/terraform/vault.auto.tfvars) to match
   with your setup/needs
   - ⚠ Make sure your Vault address (`vault_addr` variable) is using `http`
     until ingress TLS setup is complete
8. Initialize Terraform configuration: `terraform -chdir=vault/terraform init`
9. Configure Vault by applying Terraform configuration: `terraform
   -chdir=vault/terraform apply`
10. Review changes and type `yes` to apply them
11. Add `vault/terraform/root.crt` to your trusted certificate store

## :scroll: cert-manager

1. Install Custom Resource Definitions (CRDs): `kubectl apply -f
   https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.crds.yaml`
2. Install chart: `helm install cert-manager --namespace cert-manager
   --create-namespace cert-manager`
3. Fix Vault's URL by replacing `http` with `https` in its [Terraform variables
   file](./vault/terraform/vault.auto.tfvars)
4. Re-apply Vault's Terraform configuration: `terraform -chdir=vault/terraform
   apply`
