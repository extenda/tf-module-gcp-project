## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| dns\_project\_iam\_roles | List of IAM Roles to add to DNS project | `list(string)` | n/a | yes |
| dns\_project\_id | ID of the project hosting Google Cloud DNS | `string` | n/a | yes |
| gcr\_project\_iam\_roles | List of IAM Roles to add GCR project | `list(string)` | n/a | yes |
| gcr\_project\_id | ID of the project hosting Google Container Registry | `string` | n/a | yes |
| gke\_gcr\_iam\_roles | List of IAM Roles to add to the GCR project | `list(string)` | n/a | yes |
| gke\_parent\_iam\_roles | List of IAM Roles to add to the parent project | `list(string)` | n/a | yes |
| gke\_service\_account | GKE service account email that IAM roles will be added to | `string` | n/a | yes |
| parent\_project\_iam\_roles | List of IAM Roles to add to the parent project | `list(string)` | n/a | yes |
| parent\_project\_id | ID of the project to which add additional IAM roles for current project's CI/CD service account. Don't add roles if value is empty | `string` | n/a | yes |
| service\_account | Service account email to add IAM roles in parent project for | `string` | n/a | yes |
| service\_account\_exists | If service_account for service exists or not | `bool` | n/a | yes |

## Outputs

No output.

