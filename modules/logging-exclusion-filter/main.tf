resource "google_logging_project_exclusion" "exclude_filter" {
  project     = var.project_id
  name        = var.filter_name
  description = var.filter_description
  filter      = var.filter_expression
}
