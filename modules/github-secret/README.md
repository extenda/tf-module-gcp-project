## Providers

| Name | Version |
|------|---------|
| github | ~> 2.0 |
| google-beta | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| github\_token\_gcp\_project | GCP project that contains Secret Manager for Github token | `string` | n/a | yes |
| github_token_gcp_secret | SGP secret name for GitHub token | `string` | n/a | yes |
| github\_token | GitHub token value (instead of query GCP secret) | `string` | `""` | no |
| github\_organization | GitHub organization | `string` | `"extenda"` | no |
| repositories | The GitHub repositories to update | `list(string)` | n/a | yes |
| secret\_name | The GitHub secret name | `string` | n/a | yes |
| secret\_value | The plaintext secret value to be encrypted with GitHub | `string` | `""` | no |
| create\_secret | If actually create a secret | `bool` | true | no |

## Outputs

No output.
