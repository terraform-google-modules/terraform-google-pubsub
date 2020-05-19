/**
 * Copyright 2018 Google LLC
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
  default_ack_deadline_seconds = 10
}

resource "google_pubsub_topic" "topic" {
  count        = var.create_topic ? 1 : 0
  project      = var.project_id
  name         = var.topic
  labels       = var.topic_labels
  kms_key_name = var.topic_kms_key_name

  dynamic "message_storage_policy" {
    for_each = var.message_storage_policy
    content {
      allowed_persistence_regions = message_storage_policy.key == "allowed_persistence_regions" ? message_storage_policy.value : null
    }
  }
}

resource "google_pubsub_subscription" "push_subscriptions" {
  count   = var.create_topic ? length(var.push_subscriptions) : 0
  name    = var.push_subscriptions[count.index].name
  topic   = google_pubsub_topic.topic.0.name
  project = var.project_id
  ack_deadline_seconds = lookup(
    var.push_subscriptions[count.index],
    "ack_deadline_seconds",
    local.default_ack_deadline_seconds,
  )
  message_retention_duration = lookup(
    var.push_subscriptions[count.index],
    "message_retention_duration",
    null,
  )

  push_config {
    push_endpoint = var.push_subscriptions[count.index]["push_endpoint"]

    // FIXME: This should be programmable, but nested map isn't supported at this time.
    //   https://github.com/hashicorp/terraform/issues/2114
    attributes = {
      x-goog-version = lookup(var.push_subscriptions[count.index], "x-goog-version", "v1")
    }
  }

  depends_on = [google_pubsub_topic.topic]
}

resource "google_pubsub_subscription" "pull_subscriptions" {
  count   = var.create_topic ? length(var.pull_subscriptions) : 0
  name    = var.pull_subscriptions[count.index].name
  topic   = google_pubsub_topic.topic.0.name
  project = var.project_id
  ack_deadline_seconds = lookup(
    var.pull_subscriptions[count.index],
    "ack_deadline_seconds",
    local.default_ack_deadline_seconds,
  )
  message_retention_duration = lookup(
    var.pull_subscriptions[count.index],
    "message_retention_duration",
    null,
  )

  depends_on = [google_pubsub_topic.topic]
}
