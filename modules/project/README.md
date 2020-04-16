## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| activate\_apis | The list of apis to activate within the project | `list(string)` | n/a | yes |
| billing\_account | The ID of the billing account to associate this project with | `any` | n/a | yes |
| bucket\_name | The name of the bucket that will contain terraform state - must be globally unique | `any` | n/a | yes |
| ci\_cd\_sa | Map of IAM Roles to assign to the CI/CD Pipeline Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))<br></pre> | <pre>[<br>  {<br>    "iam_roles": [<br>      "roles/iam.serviceAccountUser",<br>      "roles/run.admin",<br>      "roles/storage.admin"<br>    ],<br>    "name": "ci-cd-pipeline"<br>  }<br>]<br></pre> | no |
| cloudrun\_sa | Map of IAM Roles to assign to the CloudRun Runtime Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))<br></pre> | <pre>[<br>  {<br>    "iam_roles": [<br>      "roles/editor",<br>      "roles/secretmanager.secretAccessor"<br>    ],<br>    "name": "cloudrun-runtime"<br>  }<br>]<br></pre> | no |
| clan\_gsuite\_group | The name of the clan group that needs to be added to the Service GSuite Group | `string` | n/a | yes |
| create\_ci\_cd\_group | If the Service GSuite Group should be created for the CI/CD Service Account | `bool` | `false` | no |
| create\_ci\_cd\_service\_account | If the CI/CD Service Account should be created | `bool` | `true` | no |
 create\_cloudrun\_group| If the Service GSuite Group should be created for the CloudRun Runtime Service Account | `bool` | `false` | no |
| create\_cloudrun\_service\_account | If the CloudRun Runtime Service Account should be created | `bool` | `true` | no |
| create\_secret\_manager\_group | If the Service GSuite Group should be created for the Secret Manager Access Service Account | `bool` | `false` | no |
| create\_secret\_manager\_service\_account | If the Secret Manager Access Service Account should be created | `bool` | `false` | no |
| create\_service\_group | If the Service GSuite Group should be created for the Services (services variable) | `bool` | `true` | no |
| create\_service\_sa | If the Service Account for new Services should be created | `bool` | `true` | no |
| credentials | JSON encoded service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fallback to GOOGLE\_APPLICATION\_CREDENTIALS env variable. | `any` | n/a | yes |
| default\_service\_account | Project default service account setting: can be one of delete, deprivilege, disable, or keep. | `string` | `"deprivilege"` | no |
| domain | Domain name of the Organization | `string` | n/a | yes |
| env\_name | Environment name (staging/prod). Creation of some resources depends on env_name | `string` | "" | yes |
| folder\_id | The ID of a folder to host this project | `any` | n/a | yes |
| name | The name for the project | `any` | n/a | yes |
| org\_id | The organization ID | `any` | n/a | yes |
| random\_project\_id | Adds a suffix of 4 random characters to the project\_id | `bool` | `true` | no |
| secret\_manager\_sa | Map of IAM Roles to assign to the Secret Manager Access Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))<br></pre> | <pre>[<br>  {<br>    "iam_roles": [<br>      "roles/secretmanager.secretAccessor"<br>    ],<br>    "name": "secret-accessor"<br>  }<br>]<br></pre> | no |
| services | Map of IAM Roles to assign to the Services Service Account | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>  }))<br></pre> | n/a | yes |
| service\_group\_name | Adds a suffix of 4 random characters to the project\_id | `string` | `""` | yes |
| shared\_vpc | The ID of the host project which hosts the shared VPC | `string` | `""` | no |
| shared\_vpc\_subnets | List of subnets fully qualified subnet IDs (ie. projects/$project_id/regions/$region/subnetworks/$subnet_id) | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| ci\_cd\_service\_account\_email | The CI/CD pipeline service account email |
| ci\_cd\_service\_account\_private\_key\_encoded | The CI/CD pipeline service account base64 encoded JSON key |
| cloudrun\_service\_account\_email | The Cloud Run service account email |
| project\_id | The project ID |
| project\_name | The project name |
| secret\_manager\_service\_account\_private\_key\_encoded | The Cloud Run service account base64 encoded JSON key |
| service\_account\_email | The default service acccount email |
| service\_emails | Services service account emails |
| terraform\_state\_bucket | Bucket for saving terraform state of project resources |
