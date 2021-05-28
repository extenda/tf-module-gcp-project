## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| common\_iam\_roles | List of IAM Roles to assign to every Services Service Account in Tribe project | `list(string)` | `[]` | no |
| dns\_project\_iam\_roles | List of IAM Roles to add to DNS project | `list(string)` | n/a | yes |
| dns\_project\_id | ID of the project hosting Google Cloud DNS | `string` | n/a | yes |
| env\_name | Environment name (staging/prod). Creation of some resources depends on env_name | `string` | n/a | yes |
| gcr\_project\_iam\_roles | List of IAM Roles to add GCR project | `list(string)` | n/a | yes |
| gcr\_project\_id | ID of the project hosting Google Container Registry | `string` | n/a | yes |
| parent\_project\_iam\_roles | List of IAM Roles to add to the parent project | `list(string)` | n/a | yes |
| parent\_project\_id | ID of the project to which add additional IAM roles for current project's CI/CD service account. Don't add roles if value is empty | `string` | n/a | yes |
| service\_account | Service account email to add IAM roles in parent project for | `string` | n/a | yes |
| service\_account\_exists | If service_account for service exists or not | `bool` | n/a | yes |
| project\_id | Local (clan) Project ID where service account is created | `string` | n/a | yes |
| services | List of services with IAM roles | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))<br></pre> | n/a | yes |
| project_type | project type this is applied to | `string` | n/a | yes |
| sa\_depends\_on | Service Account which this module depends on | `any` | n/a | yes |

## Outputs

No output.
