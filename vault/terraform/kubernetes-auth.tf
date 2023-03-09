resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
  tune {
    default_lease_ttl = var.kubernetes_default_lease_ttl
    max_lease_ttl     = var.kubernetes_max_lease_ttl
  }
}

data "kubernetes_secret" "vault_auth_sa" {
  provider = kubernetes
  metadata {
    name      = "vault-auth-token"
    namespace = "vault"
  }
}

resource "vault_kubernetes_auth_backend_config" "config" {
  backend            = vault_auth_backend.kubernetes.path
  kubernetes_host    = var.kubernetes_host
  kubernetes_ca_cert = data.kubernetes_secret.vault_auth_sa.data["ca.crt"]
  token_reviewer_jwt = data.kubernetes_secret.vault_auth_sa.data.token
}

resource "vault_kubernetes_auth_backend_role" "roles" {
  backend = vault_auth_backend.kubernetes.path

  for_each = var.kubernetes_roles

  role_name                        = each.key
  bound_service_account_names      = each.value.bound_service_account_names
  bound_service_account_namespaces = each.value.bound_service_account_namespaces
  token_ttl                        = each.value.token_ttl
  token_policies                   = each.value.token_policies
}
