resource "vault_mount" "pki" {
  type = "pki"
  path = "pki"

  default_lease_ttl_seconds = var.pki_default_lease_ttl
  max_lease_ttl_seconds     = var.pki_max_lease_ttl
}

resource "vault_pki_secret_backend_root_cert" "root" {
  backend     = vault_mount.pki.path
  type        = var.pki_root_ca.type
  common_name = var.pki_root_ca.common_name
  ttl         = var.pki_root_ca.ttl
}

resource "vault_pki_secret_backend_intermediate_set_signed" "intermediate" {
  backend     = vault_mount.pki.path
  certificate = vault_pki_secret_backend_root_cert.root.certificate
}

resource "vault_pki_secret_backend_config_urls" "urls" {
  backend                 = vault_mount.pki.path
  crl_distribution_points = var.pki_urls.crl_distribution_points
  issuing_certificates    = var.pki_urls.issuing_certificates
}

resource "vault_pki_secret_backend_role" "roles" {
  backend = vault_mount.pki.path

  for_each = var.pki_roles

  name             = each.key
  allow_localhost  = each.value.allow_localhost
  allow_subdomains = each.value.allow_subdomains
  allowed_domains  = each.value.allowed_domains
}

resource "local_file" "root_certificate" {
  content  = vault_pki_secret_backend_root_cert.root.certificate
  filename = "root.crt"
}
