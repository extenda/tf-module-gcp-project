variable project_id {
  description = "Project ID where secrets will be copied to"
  type        = string
}

variable pipeline_project_id {
  description = "GCP project that contains secrets for webhook url"
  type        = string
}

variable slack_notify_secret {
  description = "Secret name containing the slack notification bot token"
  type        = string
}

variable project_type {
  description = "What project type this is"
  type        = string
}