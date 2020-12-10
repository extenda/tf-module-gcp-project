variable project_id {
  description = "Project ID where secrets will be copied to"
  type        = string
}

variable pact_project_id {
  description = "GCP project that contains secrets for pact-broker"
  type        = string
}

variable pactbroker_user {
  description = "Pact-broker user value (instead of query GCP secret)"
  type        = string
  default     = ""
}

variable pactbroker_user_secret {
  description = "GCP secret name for pact-broker user"
  type        = string
}

variable pactbroker_pass {
  description = "Pact-broker password value (instead of query GCP secret)"
  type        = string
  default     = ""
}

variable pactbroker_pass_secret {
  description = "GCP secret name for pact-broker password"
  type        = string
}

variable create_pact_secrets {
  description = "If the pact-broker secrets should be created"
  type        = bool
}

variable env_name {
  type        = string
  description = "Environment name (staging/prod). Creation of some resources depends on it"
}
