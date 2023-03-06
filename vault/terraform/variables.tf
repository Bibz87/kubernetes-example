variable "vault_addr" {
  description = "Vault server's address"
  type        = string
}

variable "vault_token" {
  description = "Vault server's access token"
  type        = string
  sensitive   = true
}

variable "kubernetes_host" {
  description = "Kubernetes cluster address"
  type        = string
}

variable "kubernetes_default_lease_ttl" {
  description = "Kubernetes default token lease duration"
  type        = string
  default     = null
}

variable "kubernetes_max_lease_ttl" {
  description = "Kubernetes max token lease duration"
  type        = string
  default     = null
}

variable "kubernetes_roles" {
  description = "Kubernetes authentication module roles"
  type = map(object({
    bound_service_account_names      = list(string)
    bound_service_account_namespaces = list(string)
    token_ttl                        = optional(number)
    token_policies                   = list(string)
    })
  )

  default = {}
}

variable "pki_default_lease_ttl" {
  description = "PKI secrets engine default lease duration"
  type        = number
  default     = null
}

variable "pki_max_lease_ttl" {
  description = "PKI secrets engine default token lease duration"
  type        = number
  default     = null
}

variable "pki_root_ca" {
  description = "PKI secrets engine Root CA properties"
  type = object({
    type        = string
    common_name = string
    ttl         = number
  })

  default = null
}

variable "pki_roles" {
  description = "PKI secrets engine roles"
  type = map(object({
    allow_localhost  = bool
    allow_subdomains = bool
    allowed_domains  = list(string)
    })
  )

  default = {}
}

variable "pki_urls" {
  description = "PKI secrets engine URLs"
  type = object({
    crl_distribution_points = list(string)
    issuing_certificates    = list(string)
  })

  default = null
}
