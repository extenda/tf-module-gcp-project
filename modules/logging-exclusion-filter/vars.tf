variable "project_id" {
  description = "Project ID where we will create the logging exclusion filter."
  type        = string
}

variable "filter_name" {
  description = "The exclusion filter name."
  type        = string
}

variable "filter_description" {
  description = "The description of the log exclusion filter."
  type        = string
}

variable "filter_expression" {
  description = "The log filter expression to use."
  type        = string
}

