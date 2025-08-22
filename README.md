# terraform-google-pubsub

This module makes it easy to create Google Cloud Pub/Sub topic and subscriptions associated with the topic.

## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v1.9.0](https://registry.terraform.io/modules/terraform-google-modules/-pubsub/google/v1.9.0).

## Usage

This is a simple usage of the module. Please see also a simple setup provided in the example directory.

```hcl
module "pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 8.3"

  topic      = "tf-topic"
  project_id = "my-pubsub-project"
  push_subscriptions = [
    {
      name                       = "push"                                               // required
      ack_deadline_seconds       = 20                                                   // optional
      push_endpoint              = "https://example.com"                                // required
      x-goog-version             = "v1beta1"                                            // optional
      oidc_service_account_email = "sa@example.com"                                     // optional
      audience                   = "example"                                            // optional
      expiration_policy          = "1209600s"                                           // optional
      dead_letter_topic          = "projects/my-pubsub-project/topics/example-dl-topic" // optional
      max_delivery_attempts      = 5                                                    // optional
      maximum_backoff            = "600s"                                               // optional
      minimum_backoff            = "300s"                                               // optional
      filter                     = "attributes.domain = \"com\""                        // optional
      enable_message_ordering    = true                                                 // optional
    }
  ]
  pull_subscriptions = [
    {
      name                         = "pull"                                               // required
      ack_deadline_seconds         = 20                                                   // optional
      dead_letter_topic            = "projects/my-pubsub-project/topics/example-dl-topic" // optional
      max_delivery_attempts        = 5                                                    // optional
      maximum_backoff              = "600s"                                               // optional
      minimum_backoff              = "300s"                                               // optional
      filter                       = "attributes.domain = \"com\""                        // optional
      enable_message_ordering      = true                                                 // optional
      service_account              = "service2@project2.iam.gserviceaccount.com"          // optional
      enable_exactly_once_delivery = true                                                 // optional
    }
  ]
  bigquery_subscriptions = [
    {
      name                = "bigquery"              // required
      table               = "project.dataset.table" // required
      use_topic_schema    = true                    // optional
      use_table_schema    = false                   // optional
      write_metadata      = false                   // optional
      drop_unknown_fields = false                   // optional
    }
  ]
  cloud_storage_subscriptions = [
    {
      name                     = "cloud-storage"        // required
      bucket                   = "example-bucket"       // required
      filename_prefix          = "log_events_"          // optional
      filename_suffix          = ".avro"                // optional
      filename_datetime_format = "YYYY-MM-DD/hh_mm_ssZ" // optional
      max_duration             = "60s"                  // optional
      max_bytes                = "10000000"             // optional
      max_messages             = "10000"                // optional
      output_format            = "avro"                 // optional
      write_metadata           = false                  // optional
      use_topic_schema         = false                  // optional
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bigquery\_subscriptions | The list of the Bigquery push subscriptions. | <pre>list(object({<br>    name                       = string,<br>    table                      = string,<br>    use_topic_schema           = optional(bool),<br>    use_table_schema           = optional(bool),<br>    write_metadata             = optional(bool),<br>    drop_unknown_fields        = optional(bool),<br>    ack_deadline_seconds       = optional(number),<br>    retain_acked_messages      = optional(bool),<br>    message_retention_duration = optional(string),<br>    enable_message_ordering    = optional(bool),<br>    expiration_policy          = optional(string),<br>    filter                     = optional(string),<br>    dead_letter_topic          = optional(string),<br>    max_delivery_attempts      = optional(number),<br>    maximum_backoff            = optional(string),<br>    minimum_backoff            = optional(string)<br>  }))</pre> | `[]` | no |
| cloud\_storage\_subscriptions | The list of the Cloud Storage push subscriptions. | <pre>list(object({<br>    name                       = string,<br>    bucket                     = string,<br>    filename_prefix            = optional(string),<br>    filename_suffix            = optional(string),<br>    filename_datetime_format   = optional(string),<br>    max_duration               = optional(string),<br>    max_bytes                  = optional(string),<br>    max_messages               = optional(string),<br>    output_format              = optional(string),<br>    write_metadata             = optional(bool),<br>    use_topic_schema           = optional(bool),<br>    ack_deadline_seconds       = optional(number),<br>    retain_acked_messages      = optional(bool),<br>    message_retention_duration = optional(string),<br>    enable_message_ordering    = optional(bool),<br>    expiration_policy          = optional(string),<br>    filter                     = optional(string),<br>    dead_letter_topic          = optional(string),<br>    max_delivery_attempts      = optional(number),<br>    maximum_backoff            = optional(string),<br>    minimum_backoff            = optional(string)<br>  }))</pre> | `[]` | no |
| create\_subscriptions | Specify true if you want to create subscriptions. | `bool` | `true` | no |
| create\_topic | Specify true if you want to create a topic. | `bool` | `true` | no |
| grant\_bigquery\_project\_roles | Specify true if you want to add bigquery.metadataViewer and bigquery.dataEditor roles to the default Pub/Sub SA. | `bool` | `true` | no |
| grant\_cloud\_storage\_project\_roles | Specify true if you want to add storage.admin role to the default Pub/Sub SA. | `bool` | `true` | no |
| grant\_token\_creator | Specify true if you want to add token creator role to the default Pub/Sub SA. | `bool` | `true` | no |
| message\_storage\_policy | A map of storage policies. Default - inherit from organization's Resource Location Restriction policy. | `map(any)` | `{}` | no |
| project\_id | The project ID to manage the Pub/Sub resources. | `string` | n/a | yes |
| pull\_subscriptions | The list of the pull subscriptions. | <pre>list(object({<br>    name                         = string,<br>    ack_deadline_seconds         = optional(number),<br>    expiration_policy            = optional(string),<br>    dead_letter_topic            = optional(string),<br>    max_delivery_attempts        = optional(number),<br>    retain_acked_messages        = optional(bool),<br>    message_retention_duration   = optional(string),<br>    maximum_backoff              = optional(string),<br>    minimum_backoff              = optional(string),<br>    filter                       = optional(string),<br>    enable_message_ordering      = optional(bool),<br>    service_account              = optional(string),<br>    enable_exactly_once_delivery = optional(bool),<br>  }))</pre> | `[]` | no |
| push\_subscriptions | The list of the push subscriptions. | <pre>list(object({<br>    name                       = string,<br>    ack_deadline_seconds       = optional(number),<br>    push_endpoint              = optional(string),<br>    x-goog-version             = optional(string),<br>    oidc_service_account_email = optional(string),<br>    audience                   = optional(string),<br>    expiration_policy          = optional(string),<br>    dead_letter_topic          = optional(string),<br>    retain_acked_messages      = optional(bool),<br>    message_retention_duration = optional(string),<br>    max_delivery_attempts      = optional(number),<br>    maximum_backoff            = optional(string),<br>    minimum_backoff            = optional(string),<br>    filter                     = optional(string),<br>    enable_message_ordering    = optional(bool),<br>    no_wrapper                 = optional(bool),<br>    write_metadata             = optional(bool),<br>  }))</pre> | `[]` | no |
| schema | Schema for the topic. | <pre>object({<br>    name       = string<br>    type       = string<br>    definition = string<br>    encoding   = string<br>  })</pre> | `null` | no |
| subscription\_labels | A map of labels to assign to every Pub/Sub subscription. | `map(string)` | `{}` | no |
| topic | The Pub/Sub topic name. | `string` | n/a | yes |
| topic\_kms\_key\_name | The resource name of the Cloud KMS CryptoKey to be used to protect access to messages published on this topic. | `string` | `null` | no |
| topic\_labels | A map of labels to assign to the Pub/Sub topic. | `map(string)` | `{}` | no |
| topic\_message\_retention\_duration | The minimum duration in seconds to retain a message after it is published to the topic. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| env\_vars | Map of pull subscription IDs, keyed by project\_subscription name for environment variables. |
| id | The ID of the Pub/Sub topic |
| subscription\_names | The name list of Pub/Sub subscriptions |
| subscription\_paths | The path list of Pub/Sub subscriptions |
| topic | The name of the Pub/Sub topic |
| topic\_labels | Labels assigned to the Pub/Sub topic |
| uri | The URI of the Pub/Sub topic |

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
