/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  state_notification_enabled = var.state_notification_config.topic != "" ? "enabled" : "disabled"
  state_notification_configs = {
    disabled = null
    enabled = {
      pubsub_topic_name = "projects/${var.project_id}/topics/${var.state_notification_config.topic}"
    }
  }
  state_notification_config = local.state_notification_configs[local.state_notification_enabled]

  event_notification_enabled = var.event_notification_config.topic != "" ? "enabled" : "disabled"
  event_notification_configs = {
    disabled = []
    enabled = [{
      pubsub_topic_name = "projects/${var.project_id}/topics/${var.event_notification_config.topic}"
    }]
  }
  event_notification_config = local.event_notification_configs[local.event_notification_enabled]
}

resource "google_cloudiot_registry" "default" {
  name    = var.name
  project = var.project_id
  region  = var.region

  http_config = {
    http_enabled_state = var.http_enabled_state
  }
  mqtt_config = {
    mqtt_enabled_state = var.mqtt_enabled_state
  }

  dynamic "event_notification_configs" {
    for_each = local.event_notification_config
    iterator = c
    content {
      pubsub_topic_name = c.value.pubsub_topic_name
    }
  }

  state_notification_config = local.state_notification_config

  dynamic "credentials" {
    for_each = [for c in var.public_key_certificates : {
      public_key_certificate = {
        format      = c.format
        certificate = c.certificate
      }
    }]
    content {
      public_key_certificate = credentials.value.public_key_certificate
    }
  }
  depends_on = [
    module.event_notification_topic,
    module.state_notification_topic,
  ]
}

module "event_notification_topic" {
  source     = "../../"
  project_id = var.project_id

  topic              = var.event_notification_config.topic
  topic_labels       = var.event_notification_config.topic_labels
  push_subscriptions = var.event_notification_config.push_subscriptions
  pull_subscriptions = var.event_notification_config.pull_subscriptions
  create_topic       = var.event_notification_config.create_topic
}

module "state_notification_topic" {
  source     = "../../"
  project_id = var.project_id

  topic              = var.state_notification_config.topic
  topic_labels       = var.state_notification_config.topic_labels
  push_subscriptions = var.state_notification_config.push_subscriptions
  pull_subscriptions = var.state_notification_config.pull_subscriptions
  create_topic       = var.state_notification_config.create_topic
}
