## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| additional\_user\_access | List of IAM Roles to assign to groups and users | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>    members = list(string)<br>  }))<br></pre> | n/a | yes |
| clan\_gsuite\_group | The name of the clan gsuite group | `string` | n/a | yes |
| domain | Domain name of the Organization | `string` | n/a | yes |
| project\_id | Project ID to add IAM roles to | `string` | n/a | yes |


## Outputs

No output.
