## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_pact\_secrets | If the pact-broker secrets should be created | `bool` | n/a | yes |
| pact\_project\_id | GCP project that contains secrets for pact-broker | `string` | n/a | yes |
| pactbroker\_pass | Pact-broker password value (instead of query GCP secret) | `string` | `""` | no |
| pactbroker\_pass\_secret | GCP secret name for pact-broker password | `string` | n/a | yes |
| pactbroker\_user | Pact-broker user value (instead of query GCP secret) | `string` | `""` | no |
| pactbroker\_user\_secret | GCP secret name for pact-broker user | `string` | n/a | yes |
| project\_id | Project ID where secrets will be copied to | `string` | n/a | yes |

## Outputs

No output.
