# Terraform Google Cloud Logging Exclusion Filter Module

This Terraform module creates a generic log exclusion filter for a Google Cloud project. It allows you to define a custom filter to prevent specific log entries from being ingested by Cloud Logging, which is a key strategy for managing logging costs.

This module is designed to be reusable for any type of log exclusion. The caller provides all the necessary details, including the filter's name, description, and the filter expression itself.

## Example Usage

Here is an example of how to use this module to exclude non-critical Cloud Run request logs based on a custom label.

```hcl
module "cloud_run_log_exclusion" {  
  source = "./modules/logging-exclusion-filter"

  project_id = data.google_project.this.project_id

  filter_name        = "exclude-cloud-run-requests-by-label"  
  filter_description = "Excludes Cloud Run request logs with status < 429 from services with the 'exclude-logs=cloud-run' label."  
  filter_expression  = "resource.type=\"cloud_run_revision\" AND logName:\"run.googleapis.com%2Frequests\" AND httpRequest.status < 429 AND labels.exclude-logs=\"cloud-run\""  
}
```

## Inputs

| Name | Description | Type | Required |
| :---- | :---- | :---- | :---- |
| project_id | The Project ID where the logging exclusion filter will be created. | string | yes |
| filter_name | The unique name for the exclusion filter. | string | yes |
| filter_description | A description of what the log exclusion filter does. | string | yes |
| filter_expression | The log filter expression used to identify logs to exclude. | string | yes |
