variable github_token_gcp_project {
  description = "GCP project that contains Secret Manager for Github token"
  type        = string
}

variable github_token_gcp_secret {
  description = "SGP secret name for GitHub token"
  type        = string
}

variable github_organization {
  description = "GitHub organization"
  type        = string
}

variable repositories {
  description = "The GitHub repositories to update"
  type        = list(string)
}

variable secret_name {
  description = "The GitHub secret name"
  type        = string
}

variable secret_value {
  description = "The plaintext secret value to be encrypted with GitHub"
  type        = string
  default     = ""
}

variable create_secret {
  description = "If actually create a secret"
  type        = bool
  default     = true
}
