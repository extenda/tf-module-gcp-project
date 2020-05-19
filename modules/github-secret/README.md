## Providers

| Name | Version |
|------|---------|
| github | ~> 2.0 |
| google-beta | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| gcp\_secret\_project | GCP project that contains Secret Manager | `string` | `"pipeline-secrets-1136"` | no |
| github\_organization | GitHub organization | `string` | `"extenda"` | no |
| repositories | The GitHub repositories to update | `list(string)` | n/a | yes |
| secret\_name | The GitHub secret name | `string` | n/a | yes |
| secret\_value | The plaintext secret value to be encrypted with GitHub | `string` | `""` | no |
| create\_secret | If actually create a secret | `bool` | true | no |

## Outputs

No output.
