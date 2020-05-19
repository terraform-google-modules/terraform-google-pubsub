# KMS Example

This example illustrates how to use the `pubsub` module with a custom `kms` key.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| kms\_key\_name | Name of KMS key to use for pubsub topic | string | n/a | yes |
| kms\_keyring\_name | Name of KMS key ring to use for pubsub topic | string | n/a | yes |
| project\_id | The project ID to manage the Pub/Sub resources | string | n/a | yes |
| topic\_labels | A map of labels to assign to the Pub/Sub topic | map(string) | `<map>` | no |
| topic\_name | The name for the Pub/Sub topic | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| project\_id | The project ID |
| topic\_labels | The labels of the Pub/Sub topic created |
| topic\_name | The name of the Pub/Sub topic created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

The following sections describe the requirements which must be met in
order to invoke this example. The requirements of the
[root module][root-module-requirements] must be met.

## Usage

To provision this example, populate `terraform.tfvars` with the [required variables](#inputs) and run the following commands within
this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
