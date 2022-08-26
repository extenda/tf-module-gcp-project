## Description
Module is intended to create IAM role bindings between groups of users and roles with `has({}.jitAccessConstraint)` condition. This will allow to grand temporary permissions to production environment for users if incidents occur.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_jit\_access | If the eligible roles should be created | `bool` | n/a | yes |
| jit\_access | Map of IAM Roles to assign to the group | <pre>list(object({<br>    group     = string<br>    iam_roles = list(string)<br>  }))</pre> | n/a | yes |
| project\_id | Project ID where we will create the iam roles | `string` | n/a | yes |

## Outputs

No output.
