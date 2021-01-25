## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| pipeline\_project\_id | GCP project that contains secrets for gcp-platform-alerts | `string` | `pipeline-secrets-1136` | no |
| project\_id | Project ID where secrets will be copied to | `string` | n/a | yes |
| project_type | Project type this is applied to | `string` | n/a | yes |
| webhook\_url\_secret | GCP secret name for webhook url | `string` | `slack-webhook-gcp-platform` | yes |

## Outputs

No output.
