# terraform-google-pubsub for Cloud IoT

## Overview

In the early stage, this module will simply be implemented by using [existing pubsub module](https://github.com/terraform-google-modules/terraform-google-pubsub) and [one resource](https://www.terraform.io/docs/providers/google/r/cloudiot_registry.html).

This module may not improve drastically efficiency. However, after implementing new resources like [terraform-provider-google#1495](https://github.com/terraform-providers/terraform-provider-google/issues/1495), this module will get more efficient by adopting the new resources.

## Usage

Let's seeing a simple usage of the module. See also a simple setup provided in the example directory.

```hcl
module "iot" {
  source     = "terraform-google-modules/pubsub/iot"
  name       = "sample-iot"
  region     = "us-central1"
  project_id = "tf-project"

  mqtt_enabled_state = "MQTT_ENABLED"
  http_enabled_state = "HTTP_DISABLED"
  event_notification_config = {
    topic = "iot-event-topic"
    pull_subscriptions = [
      {
        name = "iot-event-pull"
        ack_deadline_seconds = 20
      },
    ]
  }
  state_notification_config = {
    topic = "iot-state-topic"
    pull_subscriptions = [
      {
        name = "iot-state-pull"
        ack_deadline_seconds = 20
      },
    ]
  }
}
```

[^]: (autogen_docs_start)## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| event_notification_config | The event notification configuration for the Cloud IoT registry.   This contains `topic`, `pull_subscriptions` and `push_subscriptions`. | map | `<map>` | no |
| http_enabled_state | The field allows HTTP_ENABLED or HTTP_DISABLED | string | `HTTP_DISABLED` | no |
| mqtt_enabled_state | The field allows MQTT_ENABLED or MQTT_DISABLED | string | `MQTT_ENABLED` | no |
| name | The Cloud IoT registry name | string | - | yes |
| project_id | The project ID to manage the Cloud IoT resources | string | - | yes |
| public_key_certificates | The list for public key certificates | list | `<list>` | no |
| region | The region to host the registry | string | - | yes |
| state_notification_config | The event notification configuration for the Cloud IoT registry.   This contains `topic`, `pull_subscriptions` and `push_subscriptions`. | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| credentials | The credentials for Cloud IoT registry |
| event_notification_subscription_names | The name list of Pub/Sub subscriptions associated with the registry |
| event_notification_subscription_paths | The path list of Pub/Sub subscriptions associated with the registry |
| event_notification_topic | The name of the Pub/Sub topic associated with the registry |
| event_notification_topic_id | The id of the Pub/Sub topic associated with the registry |
| name | The name of the Cloud IoT registry |
| state_notification_subscription_names | The name list of Pub/Sub subscriptions associated with the registry |
| state_notification_subscription_paths | The path list of Pub/Sub subscriptions associated with the registry |
| state_notification_topic | The name of the Pub/Sub topic associated with the registry |
| state_notification_topic_id | The id of the Pub/Sub topic associated with the registry |


[^]: (autogen_docs_end)

## Requirements

## Enable API

In order to operate with the service account you must activate the following API on the project where the service account was created.

- Cloud IoT API

## Configure a Service Account

In addition to the pubsub module's requirements, the following role should be attached to the service account.

- Cloud IoT Editor