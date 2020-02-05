## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| activate_apis | The list of apis to activate within the project | `list(string)` | n/a | yes |
| billing_account | The ID of the billing account to associate this project with | `any` | n/a | yes |
| ci_cd_sa_iam_roles | Map of IAM Roles to assign to the CI/CD Pipeline Service Account | `map` | <pre>{<br>  "r0": "roles/iam.serviceAccountUser",<br>  "r1": "roles/run.admin",<br>  "r2": "roles/storage.admin"<br>}</pre> | no |
| cloudrun_sa_iam_roles | Map of IAM Roles to assign to the CloudRun Runtime Service Account | `map` | <pre>{<br>  "r0": "roles/editor",<br>  "r1": "roles/secretmanager.secretAccessor"<br>}</pre> | no |
| create_ci_cd_service_account | If the CI/CD Service Account should be created | `bool` | `true` | no |
| create_cloudrun_service_account | If the CloudRun Runtime Service Account should be created | `bool` | `true` | no |
| create_secret_manager_service_account | If the Secret Manager Access Service Account should be created | `bool` | `false` | no |
| credentials | JSON encoded service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fallback to GOOGLE_APPLICATION_CREDENTIALS env variable. | `any` | n/a | yes |
| default_service_account | Project default service account setting: can be one of delete, deprivilege, disable, or keep. | `string` | `"deprivilege"` | no |
| folder_id | The ID of a folder to host this project | `any` | n/a | yes |
| name | The name for the project | `any` | n/a | yes |
| org_id | The organization ID | `any` | n/a | yes |
| random_project_id | Adds a suffix of 4 random characters to the project_id | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| ci_cd_service_account_email | The CI/CD pipeline service account email |
| ci_cd_service_account_private_key_encoded | The CI/CD pipeline service account base64 encoded JSON key |
| cloudrun_service_account_email | The Cloud Run service account email |
| project_id | The project ID |
| project_name | The project name |
| secret_manager_service_account_private_key_encoded | The Cloud Run service account base64 encoded JSON key |
| service_account_email | The default service acccount email |

