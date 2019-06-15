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
  event_notification_config = {
    pubsub_topic_name = "projects/${var.project_id}/topics/${module.event_notification_topic.topic}"
  }
  state_notification_config = {
    pubsub_topic_name = "projects/${var.project_id}/topics/${module.state_notification_topic.topic}"
  }

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

  // NOTE: if the topic is empty, then this resource should be skipped.
  topic              = lookup(var.event_notification_config, "topic", "")
  push_subscriptions = lookup(var.event_notification_config, "push_subscriptions", [])
  pull_subscriptions = lookup(var.event_notification_config, "pull_subscriptions", [])
}

module "state_notification_topic" {
  source     = "../../"
  project_id = var.project_id

  // NOTE: if the topic is empty, then this resource should be skipped.
  topic              = lookup(var.state_notification_config, "topic", "")
  push_subscriptions = lookup(var.state_notification_config, "push_subscriptions", [])
  pull_subscriptions = lookup(var.state_notification_config, "pull_subscriptions", [])
}
