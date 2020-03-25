## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| services | Map of IAM Roles to assign to the Services Service Account | `list(object({ name = string iam_roles = list(string)}))` | Example: <pre>[<br>  "services":<br>    - name: "my-service-1"<br>      iam_roles:<br>      - "roles/storage.admin"<br>]<br></pre> | yes |
| create_service_account | If this Service Account should be created. | `bool` | n/a | yes |
| project_id | Project ID where we will create the service account | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| email | The service account email |
| private_key | The service account JSON key |
| private_key_encoded | The base64 encoded service account JSON key |
