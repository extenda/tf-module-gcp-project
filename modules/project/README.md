## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| activate\_apis | The list of apis to activate within the project | `list(string)` | n/a | yes |
| billing\_account | The ID of the billing account to associate this project with | `any` | n/a | yes |
| ci\_cd\_sa\_iam\_roles | Map of IAM Roles to assign to the CI/CD Pipeline Service Account | `map` | <code><pre>{<br>  "r0": "roles/iam.serviceAccountUser",<br>  "r1": "roles/run.admin",<br>  "r2": "roles/storage.admin"<br>}<br></pre></code> | no |
| cloudrun\_sa\_iam\_roles | Map of IAM Roles to assign to the CloudRun Runtime Service Account | `map` | <code><pre>{<br>  "r0": "roles/editor"<br>}<br></pre></code> | no |
| create\_ci\_cd\_service\_account | If the CI/CD Service Account should be created | `bool` | `true` | no |
| create\_cloudrun\_service\_account | If the CloudRun Runtime Service Account should be created | `bool` | `true` | no |
| credentials | JSON encoded service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fail to provision the Project. | `any` | n/a | yes |
| default\_service\_account | Project default service account setting: can be one of delete, deprivilege, disable, or keep. | `string` | `"deprivilege"` | no |
| folder\_id | The ID of a folder to host this project | `any` | n/a | yes |
| name | The name for the project | `any` | n/a | yes |
| org\_id | The organization ID | `any` | n/a | yes |
| random\_project\_id | Adds a suffix of 4 random characters to the project\_id | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| project\_id | n/a |
| project\_name | n/a |
| service\_account\_email | n/a |

