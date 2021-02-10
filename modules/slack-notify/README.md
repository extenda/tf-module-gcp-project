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
| slack\_notify\_secret | GCP secret name for slack token | `string` | `slack-notification-bot-token` | yes |

## Outputs

No output.
