## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| additional\_user\_access | List of IAM Roles to assign to groups and users | <pre>list(object({<br>    name      = string<br>    iam_roles = list(string)<br>    members = list(string)<br>  }))<br></pre> | n/a | yes |
| clan\_gsuite\_group | The name of the clan gsuite group | `string` | n/a | yes |
| create\_custom\_roles | If the Custom Roles should be created | `bool` | n/a | yes |
| domain | Domain name of the Organization | `string` | n/a | yes |
| env\_name | Environment name (staging/prod). Creation of some resources depends on env\_name | `string` | n/a | yes |
| project\_id | Project ID to add IAM roles to | `string` | n/a | yes |

## Outputs

No output.
