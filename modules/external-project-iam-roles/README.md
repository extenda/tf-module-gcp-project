## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| binary\_api\_enabled | Check if Binary Auth API is enabled | `bool` | `false` | no |
| binary\_auth\_sa | Binary Auth default service account | `string` | n/a | yes |
| common\_iam\_roles | List of IAM Roles to assign to every Services Service Account in Tribe project | `list(string)` | `[]` | no |
| compute\_project\_iam\_roles | List of IAM Roles to add to default compute service account | `list(string)` | n/a | yes |
| compute\_sa | Compute Engine default service account | `string` | n/a | yes |
| dns\_project\_iam\_roles | List of IAM Roles to add to DNS project | `list(string)` | n/a | yes |
| dns\_project\_id | ID of the project hosting Google Cloud DNS | `string` | n/a | yes |
| env\_name | Environment name (staging/prod). Creation of some resources depends on env\_name | `string` | n/a | yes |
| gcr\_project\_iam\_roles | List of IAM Roles to add GCR project | `list(string)` | n/a | yes |
| gcr\_project\_id | ID of the project hosting Google Container Registry | `string` | n/a | yes |
| parent\_project\_iam\_roles | List of IAM Roles to add to the parent project | `list(string)` | n/a | yes |
| parent\_project\_id | ID of the project to which add additional IAM roles for current project's CI/CD service account. Don't add roles if value is empty | `string` | n/a | yes |
| platform\_project\_id | ID of the project to which add IAM roles for Binary Auth. | `string` | n/a | yes |
| project\_id | Local (clan) Project ID where service account is created | `any` | n/a | yes |
| project\_type | What project type this is | `string` | n/a | yes |
| sa\_depends\_on | Service Account which this module depends on | `any` | n/a | yes |
| service\_account | Service account email to add IAM roles in parent project for | `string` | n/a | yes |
| service\_account\_exists | If service\_account for service exists or not | `bool` | n/a | yes |
| services | List of services with IAM roles | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

No output.
