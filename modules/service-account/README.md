## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| account_id | The service account ID | `any` | n/a | yes |
| create_service_account | If this Service Account should be created. | `bool` | n/a | yes |
| display_name | The service account display name | `any` | n/a | yes |
| iam_roles | Role permission bindings | `map` | n/a | yes |
| project_id | Project ID where we will create the service account | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| email | The service account email |
| private_key | The service account JSON key |
| private_key_encoded | The base64 encoded service account JSON key |

