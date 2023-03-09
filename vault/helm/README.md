# Vault Helm Chart

HashiCorp Vault is a secret and sensitive data manager. With it, you can easily
deal with application certificates, database credentials, passwords, API keys
and more. For more information, see the project's [website](https://www.vaultproject.io/).

Kubernetes authentication configuration was originally taken from
[here](https://ddymko.medium.com/vault-using-kubernetes-auth-c67cfcdc8d6e)

## Installation

`helm install vault --namespace vault --create-namespace .`

## Uninstallation

`helm delete vault --namespace vault`
