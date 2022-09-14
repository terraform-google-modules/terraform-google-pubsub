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



#impersonate service account
provider "google" {
  impersonate_service_account = "terraform@${var.project_id}.iam.gserviceaccount.com"
}
data "google_project" "project" {
  project_id = var.project_id
}

locals {
  default_subscription_label   = { "managed_by" : "terraform" }
  default_ack_deadline_seconds = 10
}

resource "google_pubsub_schema" "schema" {
  count      = var.schema != null ? 1 : 0
  project    = var.project_id
  name       = var.schema.name
  type       = var.schema.type
  definition = var.schema.definition
}


resource "google_pubsub_topic" "topic" {
  count                      = var.create_topic ? 1 : 0
  project                    = var.project_id
  name                       = var.topic
  labels                     = merge(local.default_subscription_label, var.topic_labels)
  kms_key_name               = var.topic_kms_key_name
  message_retention_duration = var.topic_message_retention_duration

  dynamic "message_storage_policy" {
    for_each = var.message_storage_policy
    content {
      allowed_persistence_regions = message_storage_policy.key == "allowed_persistence_regions" ? message_storage_policy.value : null
    }
  }

  dynamic "schema_settings" {
    for_each = var.schema != null ? [var.schema] : []
    content {
      schema   = google_pubsub_schema.schema[0].id
      encoding = lookup(schema_settings.value, "encoding", null)
    }
  }
  depends_on = [google_pubsub_schema.schema]
}

resource "google_pubsub_subscription" "push_subscriptions" {
  for_each = var.create_subscriptions ? { for i in var.push_subscriptions : i.subscription_details.name => i } : {}

  name    = each.value.subscription_details.name
  topic   = var.create_topic ? google_pubsub_topic.topic.0.name : var.topic
  project = var.project_id
  labels = merge(local.default_subscription_label,each.value.subscription_labels)

  ack_deadline_seconds = lookup(
    each.value.subscription_details,
    "ack_deadline_seconds",
    local.default_ack_deadline_seconds,
  )
  message_retention_duration = lookup(
    each.value.subscription_details,
    "message_retention_duration",
    null,
  )
  retain_acked_messages = lookup(
    each.value.subscription_details,
    "retain_acked_messages",
    null,
  )
  filter = lookup(
    each.value.subscription_details,
    "filter",
    null,
  )
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = contains(keys(each.value.subscription_details), "expiration_policy") ? [each.value.subscription_details.expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = (lookup(each.value.subscription_details, "dead_letter_topic", "") != "") ? [each.value.subscription_details.dead_letter_topic] : []
    content {
      dead_letter_topic     = lookup(each.value.subscription_details, "dead_letter_topic", "")
      max_delivery_attempts = lookup(each.value.subscription_details, "max_delivery_attempts", "5")
    }
  }

  dynamic "retry_policy" {
    for_each = (lookup(each.value.subscription_details, "maximum_backoff", "") != "") ? [each.value.subscription_details.maximum_backoff] : []
    content {
      maximum_backoff = lookup(each.value.subscription_details, "subscription_details.maximum_backoff", "")
      minimum_backoff = lookup(each.value.subscription_details, "subscription_details.minimum_backoff", "")
    }
  }

  push_config {
    push_endpoint = each.value.subscription_details["push_endpoint"]

    // FIXME: This should be programmable, but nested map isn't supported at this time.
    //   https://github.com/hashicorp/terraform/issues/2114
    attributes = {
      x-goog-version = lookup(each.value.subscription_details, "x-goog-version", "v1")
    }

    dynamic "oidc_token" {
      for_each = (lookup(each.value.subscription_details, "oidc_service_account_email", "") != "") ? [true] : []
      content {
        service_account_email = lookup(each.value.subscription_details, "oidc_service_account_email", "")
        audience              = lookup(each.value.subscription_details, "audience", "")
      }
    }
  }
  depends_on = [
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_subscription" "pull_subscriptions" {
  for_each = var.create_subscriptions ? { for i in var.pull_subscriptions : i.subscription_details.name => i } : {}

  name    = each.value.subscription_details.name
  topic   = var.create_topic ? google_pubsub_topic.topic.0.name : var.topic
  project = var.project_id
  labels = merge(local.default_subscription_label, each.value.subscription_labels)
  enable_exactly_once_delivery = lookup(
    each.value.subscription_details,
    "enable_exactly_once_delivery",
    null,
  )
  ack_deadline_seconds = lookup(
    each.value.subscription_details,
    "ack_deadline_seconds",
    local.default_ack_deadline_seconds,
  )
  message_retention_duration = lookup(
    each.value.subscription_details,
    "message_retention_duration",
    null,
  )
  retain_acked_messages = lookup(
    each.value.subscription_details,
    "retain_acked_messages",
    null,
  )
  filter = lookup(
    each.value.subscription_details,
    "filter",
    null,
  )
  enable_message_ordering = lookup(
    each.value.subscription_details,
    "enable_message_ordering",
    null,
  )
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = contains(keys(each.value.subscription_details), "expiration_policy") ? [each.value.subscription_details.expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = (lookup(each.value.subscription_details, "subscription_details.dead_letter_topic", "") != "") ? [each.value.subscription_details.dead_letter_topic] : []
    content {
      dead_letter_topic     = lookup(each.value.subscription_details, "dead_letter_topic", "")
      max_delivery_attempts = lookup(each.value.subscription_details, "max_delivery_attempts", "5")
    }
  }

  dynamic "retry_policy" {
    for_each = (lookup(each.value.subscription_details, "maximum_backoff", "") != "") ? [each.value.subscription_details.maximum_backoff] : []
    content {
      maximum_backoff = lookup(each.value.subscription_details, "maximum_backoff", "")
      minimum_backoff = lookup(each.value.subscription_details, "minimum_backoff", "")
    }
  }

  depends_on = [
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_subscription_iam_member" "pull_subscription_sa_binding_subscriber" {
  for_each = var.create_subscriptions ? { for i in var.pull_subscriptions : i.subscription_details.name => i if lookup(i, "service_account", null) != null } : {}

  project      = var.project_id
  subscription = each.value.subscription_details.name
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:${each.value.subscription_details.service_account}"
  depends_on = [
    google_pubsub_subscription.pull_subscriptions,
  ]
}

resource "google_pubsub_subscription_iam_member" "pull_subscription_sa_binding_viewer" {
  for_each = var.create_subscriptions ? { for i in var.pull_subscriptions : i.subscription_details.name => i if lookup(i, "service_account", null) != null } : {}

  project      = var.project_id
  subscription = each.value.subscription_details.name
  role         = "roles/pubsub.viewer"
  member       = "serviceAccount:${each.value.subscription_details.service_account}"
  depends_on = [
    google_pubsub_subscription.pull_subscriptions,
  ]
}

