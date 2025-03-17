# terraform-google-pubsub

This module makes it easy to create Google Cloud Pub/Sub subscriptions associated with a given topic.

## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v1.9.0](https://registry.terraform.io/modules/terraform-google-modules/-pubsub/google/v1.9.0).

## Usage

This is a simple usage of the module. Please see also a simple setup provided in the example directory.

```hcl
module "sub" {
  source  = "terraform-google-modules/pubsub/google//modules/sub"
  version = "~> 7.0"

  project_id = var.project_id
  topic      = module.pub.topic

  pull_subscriptions = [
    {
      name                         = "sub-pull"
      ack_deadline_seconds         = 10
      enable_exactly_once_delivery = true
    },
    {
      name              = "sub-pull2"
      minimum_backoff   = "10s"
      maximum_backoff   = "600s"
      expiration_policy = "1209600s" // two weeks
    }
  ]

  push_subscriptions = [
    {
      name                 = "sub-push"
      push_endpoint        = "https://${var.project_id}.appspot.com/"
      x-goog-version       = "v1beta1"
      ack_deadline_seconds = 20
      expiration_policy    = "1209600s" // two weeks
    },
    {
      name           = "sub-push-default-expiration"
      push_endpoint  = "https://${var.project_id}.appspot.com/"
      x-goog-version = "v1beta1"
    },
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bigquery\_subscriptions | The list of the Bigquery push subscriptions. | <pre>list(object({<br>    name                       = string,<br>    table                      = string,<br>    use_topic_schema           = optional(bool),<br>    use_table_schema           = optional(bool),<br>    write_metadata             = optional(bool),<br>    drop_unknown_fields        = optional(bool),<br>    ack_deadline_seconds       = optional(number),<br>    retain_acked_messages      = optional(bool),<br>    message_retention_duration = optional(string),<br>    enable_message_ordering    = optional(bool),<br>    expiration_policy          = optional(string),<br>    filter                     = optional(string),<br>    dead_letter_topic          = optional(string),<br>    maximum_backoff            = optional(string),<br>    minimum_backoff            = optional(string)<br>  }))</pre> | `[]` | no |
| cloud\_storage\_subscriptions | The list of the Cloud Storage push subscriptions. | <pre>list(object({<br>    name                       = string,<br>    bucket                     = string,<br>    filename_prefix            = optional(string),<br>    filename_suffix            = optional(string),<br>    filename_datetime_format   = optional(string),<br>    max_duration               = optional(string),<br>    max_bytes                  = optional(string),<br>    max_messages               = optional(string),<br>    output_format              = optional(string),<br>    write_metadata             = optional(bool),<br>    use_topic_schema           = optional(bool),<br>    ack_deadline_seconds       = optional(number),<br>    retain_acked_messages      = optional(bool),<br>    message_retention_duration = optional(string),<br>    enable_message_ordering    = optional(bool),<br>    expiration_policy          = optional(string),<br>    filter                     = optional(string),<br>    dead_letter_topic          = optional(string),<br>    maximum_backoff            = optional(string),<br>    minimum_backoff            = optional(string)<br>  }))</pre> | `[]` | no |
| grant\_bigquery\_project\_roles | Specify true if you want to add bigquery.metadataViewer and bigquery.dataEditor roles to the default Pub/Sub SA. | `bool` | `true` | no |
| grant\_token\_creator | Specify true if you want to add token creator role to the default Pub/Sub SA. | `bool` | `true` | no |
| project\_id | The project ID to manage the Pub/Sub resources. | `string` | n/a | yes |
| pull\_subscriptions | The list of the pull subscriptions. | <pre>list(object({<br>    name                         = string,<br>    ack_deadline_seconds         = optional(number),<br>    expiration_policy            = optional(string),<br>    dead_letter_topic            = optional(string),<br>    max_delivery_attempts        = optional(number),<br>    retain_acked_messages        = optional(bool),<br>    message_retention_duration   = optional(string),<br>    maximum_backoff              = optional(string),<br>    minimum_backoff              = optional(string),<br>    filter                       = optional(string),<br>    enable_message_ordering      = optional(bool),<br>    service_account              = optional(string),<br>    enable_exactly_once_delivery = optional(bool),<br>  }))</pre> | `[]` | no |
| push\_subscriptions | The list of the push subscriptions. | <pre>list(object({<br>    name                       = string,<br>    ack_deadline_seconds       = optional(number),<br>    push_endpoint              = optional(string),<br>    x-goog-version             = optional(string),<br>    oidc_service_account_email = optional(string),<br>    audience                   = optional(string),<br>    expiration_policy          = optional(string),<br>    dead_letter_topic          = optional(string),<br>    retain_acked_messages      = optional(bool),<br>    message_retention_duration = optional(string),<br>    max_delivery_attempts      = optional(number),<br>    maximum_backoff            = optional(string),<br>    minimum_backoff            = optional(string),<br>    filter                     = optional(string),<br>    enable_message_ordering    = optional(bool),<br>  }))</pre> | `[]` | no |
| subscription\_labels | A map of labels to assign to every Pub/Sub subscription. | `map(string)` | `{}` | no |
| topic | The Pub/Sub topic name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| pull\_subscription\_env\_vars | Map of pull subscription IDs, keyed by project\_subscription name for environment variables. |
| subscription\_names | The name list of Pub/Sub subscriptions |
| subscription\_paths | The path list of Pub/Sub subscriptions |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

### Installation Dependencies

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin >= v2.13

### Configure a Service Account

In order to execute this module you must have a Service Account with the following:

#### Roles

- `roles/pubsub.admin`

### Enable APIs

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Cloud Pub/Sub API

#### Service Account Credentials

You can pass the service account credentials into this module by setting the following environment variables:

* `GOOGLE_CREDENTIALS`
* `GOOGLE_CLOUD_KEYFILE_JSON`
* `GCLOUD_KEYFILE_JSON`

See more [details](https://www.terraform.io/docs/providers/google/provider_reference.html#configuration-reference).

[v0.2.0]: https://registry.terraform.io/modules/terraform-google-modules/pubsub/google/0.2.0
[terraform-0.12-upgrade]: https://www.terraform.io/upgrade-guides/0-12.html
