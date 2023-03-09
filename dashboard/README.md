# Kubernetes Dashboard

* [Official
  documentation](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)
* [GitHub repository](https://github.com/kubernetes/dashboard)
* [Helm
  Chart](https://artifacthub.io/packages/helm/k8s-dashboard/kubernetes-dashboard)

The Kubernetes dashboard lets you monitor and manage cluster resources with
web-based graphical interface.

## Installation

`helm install kubernetes-dashboard --namespace kubernetes-dashboard
--create-namespace .`

## Uninstallation

`helm delete kubernetes-dashboard`

## Sign-in Token

To generate a sign-in token, run this command: `kubectl -n kubernetes-dashboard
create token admin-user`
