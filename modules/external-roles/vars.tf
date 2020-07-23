variable roles_map {
  description = "Map of roles in external projects"
  type        = map(map(list(string)))
}

variable project_id {
  description = "Project ID of service account if service name passed only"
  type        = string
  default     = ""
}

variable sa_depends_on {
  description = "Service Account which this module depends on"
  type        = any
  default     = ""
}
