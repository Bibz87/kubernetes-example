# cert-manager-domain-local Helm Chart

## Installation

The installation procedure is described
[here](https://cert-manager.io/docs/installation/helm/).

1. Install CRDs: `kubectl apply -f
   https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.crds.yaml`
2. Install chart: `helm install cert-manager --namespace cert-manager
   --create-namespace .`

## Uninstallation

1. Uninstall chart: `helm delete cert-manager --namespace cert-manager`
2. Uninstall CRDs: `kubectl delete -f
   https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.crds.yaml`

## Force certificate renewal

To force cert-manager to issue a new certificate, follow these steps:

1. Delete certificate's `Secret` entry
2. Delete certificate's `Certificate` entry
3. A new `CertificateRequest` should appear
4. cert-manager will contact Vault to issue a new certificate
5. A new `Certificate` should be created in the namespace
