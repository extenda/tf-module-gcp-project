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
  description = "List of services with IAM Roles to assign to the Services Service Account"
}

variable ksa_name {
  description = "The name of Kubernetes Service Account to bind workload for"
  type        = string
  default     = "default"
}

variable sa_depends_on {
  description = "Service Account which this module depends on"
  type        = any
}
