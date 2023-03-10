provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}
