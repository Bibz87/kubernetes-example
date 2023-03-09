kubernetes_roles = {
  "cert-manager" = {
    bound_service_account_names = [
      "vault-issuer"
    ]
    bound_service_account_namespaces = [
      "cert-manager"
    ]
    token_policies = [
      "cert-manager"
    ]
  }
}

pki_max_lease_ttl = 315360000 # 10 years

vault_addr = "https://vault.domain.local"

kubernetes_host = "https://kubernetes.default.svc"

pki_urls = {
  crl_distribution_points = [
    "http://vault.domain.local/v1/pki/crl"
  ]

  issuing_certificates = [
    "http://vault.domain.local/v1/pki/ca"
  ]
}

pki_root_ca = {
  type        = "internal"
  common_name = "My Domain root CA"
  ttl         = 315360000 # 10 years
}

pki_roles = {
  "cert-manager" = {
    allow_localhost  = false
    allow_subdomains = true
    allowed_domains = [
      "domain.local"
    ]
  }
}
