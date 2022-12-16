## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| clan\_gsuite\_group | Clan's gsuite group name | `string` | n/a | yes |
| clan\_roles | Roles to be added to the clan's group in the staging project | `list(string)` | n/a | yes |
| domain | Domain name of the organization | `string` | n/a | yes |
| env\_name | Environment name (staging/prod). Creation of some resources depends on env\_name | `string` | n/a | yes |
| project\_id | Project id where roles will be added | `string` | n/a | yes |

## Outputs

No output.
