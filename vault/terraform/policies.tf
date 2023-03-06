resource "vault_policy" "cert-manager" {
  name   = "cert-manager"
  policy = data.vault_policy_document.cert-manager.hcl
}

data "vault_policy_document" "cert-manager" {
  rule {
    path         = "pki/sign/cert-manager"
    capabilities = ["create", "update"]
    description  = "Allow cert-manager to sign CSRs"
  }
}
