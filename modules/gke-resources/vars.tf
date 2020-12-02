variable project_id {
  description = "ID of the project handling service accounts"
  type        = string
}

variable cluster_project_id {
  description = "ID of the project with kubernetes cluster"
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
  description = "cicd pipeline service account"
  type        = any
}

variable project_type {
  description = "What project type this is"
  type        = string
}

variable sa_depends_on {
  description = "Service Accounts which this module depends on"
  type        = any
}