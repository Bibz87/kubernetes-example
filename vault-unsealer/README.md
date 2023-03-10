# Vault Unsealer

This application automatically initialises and unseals an HashiCorp Vault
instance. Without this, you would need to manually initialise/unseal Vault each
time its pod is started.

## Installation

The chart's repository can be found
[here](https://github.com/pyToshka/vault-autounseal).

1. Add helm repository: `helm repo add vault-autounseal
   https://pytoshka.github.io/vault-autounseal`
2. Install chart: `helm install vault-unsealer vault-autounseal/vault-autounseal
   --namespace vault-unsealer --create-namespace -f values.yaml`

## Uninstallation

1. Uninstall chart release: `helm delete vault-unsealer --namespace vault-unsealer`
2. Delete helm repository: `helm repo remove vault-autounseal`
