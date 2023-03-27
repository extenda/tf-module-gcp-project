variable project_id {
  description = "ID of the project handling service accounts"
  type        = string
}

variable services {
  type = list(object({
    name      = string
    iam_roles = list(string)
  }))
  description = "List of services to setup namespace for"
}

variable gke_host {
  description = "Kubernetes endpoint"
  type        = string
}

variable gke_ca_certificate {
  description = "Kubernetes certificate"
  type        = string
}

variable cicd_service {
  description = "ci-cd-pipeline service account email"
  type        = string
}

variable project_type {
  description = "What project type this is"
  type        = string
  default     = "clan_project"
}

variable ksa_name {
  description = "The name of Kubernetes Service Account to bind workload for"
  type        = string
  default     = "workload-identity-sa"
}
