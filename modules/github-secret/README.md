## Providers

| Name | Version |
|------|---------|
| external | n/a |
| github | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| github\_organization | GitHub organization | `string` | `"extenda"` | no |
| repositories | The GitHub repositories to update | `list(string)` | n/a | yes |
| secret\_name | The GitHub secret name | `string` | n/a | yes |
| secret\_value | The plaintext secret value to be encrypted with GitHub | `string` | `""` | no |

## Outputs

No output.

