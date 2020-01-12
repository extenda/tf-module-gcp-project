## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| activate\_apis | The list of apis to activate within the project | `list(string)` | n/a | yes |
| billing\_account | The ID of the billing account to associate this project with | `any` | n/a | yes |
| ci\_cd\_sa\_iam\_roles | Map of IAM Roles to assign to the CI/CD Pipeline Service Account | `map` | <code><pre>{<br>  "r0": "roles/iam.serviceAccountUser",<br>  "r1": "roles/run.admin",<br>  "r2": "roles/storage.admin"<br>}<br></pre></code> | no |
| create\_ci\_cd\_service\_account | If the CI/CD Service Account should be created | `bool` | `true` | no |
| credentials | JSON encoded service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fail to provision the Project. | `any` | n/a | yes |
| folder\_id | The ID of a folder to host this project | `any` | n/a | yes |
| name | The name for the project | `any` | n/a | yes |
| org\_id | The organization ID | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| project\_id | n/a |
| project\_name | n/a |
| service\_account\_email | n/a |

