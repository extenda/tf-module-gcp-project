variable github_organization {
  description = "GitHub organization"
  type        = string
  default     = "extenda"
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
