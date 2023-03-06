# External DNS

* CoreDNS [plugins list](https://coredns.io/plugins/)

`k8s_gateway` is a CoreDNS plugin that "scans" the specified resources (in our
case, Ingresses) and creates DNS records for each of them. Because we specified
`fallthrough`, unmatched requests will be passed on to the next plugins.

Configuration was originally taken from
[here](https://trenta3.gitlab.io/note:k3s-dns-setup/) and was adapted for our
needs.

## Installation

`helm install external-dns --namespace external-dns --create-namespace .`

## Uninstallation

`helm delete external-dns`
