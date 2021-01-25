variable project_id {
  description = "Project ID where secrets will be copied to"
  type        = string
}

variable pipeline_project_id {
  description = "GCP project that contains secrets for webhook url"
  type        = string
}

variable webhook_url_secret {
  description = "Secret name containing the webhook url"
  type        = string
}

variable project_type {
  description = "What project type this is"
  type        = string
}