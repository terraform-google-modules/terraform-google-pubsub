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

data "google_project" "project" {
  project_id = var.project_id
}

locals {
  default_ack_deadline_seconds = 10
  pubsub_svc_account_email     = "service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_pubsub_schema" "schema" {
  count      = var.schema != null ? 1 : 0
  project    = var.project_id
  name       = var.schema.name
  type       = var.schema.type
  definition = var.schema.definition
}


resource "google_project_iam_member" "token_creator_binding" {
  count   = var.grant_token_creator ? 1 : 0
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${local.pubsub_svc_account_email}"
  depends_on = [
    google_pubsub_subscription.push_subscriptions,
  ]
}

resource "google_pubsub_topic_iam_member" "push_topic_binding" {
  for_each = var.create_topic ? { for i in var.push_subscriptions : i.name => i } : {}

  project = var.project_id
  topic   = lookup(each.value, "dead_letter_topic", "projects/${var.project_id}/topics/${var.topic}")
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${local.pubsub_svc_account_email}"
  depends_on = [
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_topic_iam_member" "pull_topic_binding" {
  for_each = var.create_topic ? { for i in var.pull_subscriptions : i.name => i } : {}

  project = var.project_id
  topic   = lookup(each.value, "dead_letter_topic", "projects/${var.project_id}/topics/${var.topic}")
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${local.pubsub_svc_account_email}"
  depends_on = [
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_subscription_iam_member" "pull_subscription_binding" {
  for_each = var.create_subscriptions ? { for i in var.pull_subscriptions : i.name => i } : {}

  project      = var.project_id
  subscription = each.value.name
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:${local.pubsub_svc_account_email}"
  depends_on = [
    google_pubsub_subscription.pull_subscriptions,
  ]
}

resource "google_pubsub_subscription_iam_member" "push_subscription_binding" {
  for_each = var.create_subscriptions ? { for i in var.push_subscriptions : i.name => i } : {}

  project      = var.project_id
  subscription = each.value.name
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:${local.pubsub_svc_account_email}"
  depends_on = [
    google_pubsub_subscription.push_subscriptions,
  ]
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
  for_each = var.create_subscriptions ? { for i in var.push_subscriptions : i.name => i } : {}

  name    = each.value.name
  topic   = var.create_topic ? google_pubsub_topic.topic.0.name : var.topic
  project = var.project_id
  labels  = var.subscription_labels
  ack_deadline_seconds = lookup(
    each.value,
    "ack_deadline_seconds",
    local.default_ack_deadline_seconds,
  )
  message_retention_duration = lookup(
    each.value,
    "message_retention_duration",
    null,
  )
  retain_acked_messages = lookup(
    each.value,
    "retain_acked_messages",
    null,
  )
  filter = lookup(
    each.value,
    "filter",
    null,
  )
  enable_message_ordering = lookup(
    each.value,
    "enable_message_ordering",
    null,
  )
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = contains(keys(each.value), "expiration_policy") ? [each.value.expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = (lookup(each.value, "dead_letter_topic", "") != "") ? [each.value.dead_letter_topic] : []
    content {
      dead_letter_topic     = lookup(each.value, "dead_letter_topic", "")
      max_delivery_attempts = lookup(each.value, "max_delivery_attempts", "5")
    }
  }

  dynamic "retry_policy" {
    for_each = (lookup(each.value, "maximum_backoff", "") != "") ? [each.value.maximum_backoff] : []
    content {
      maximum_backoff = lookup(each.value, "maximum_backoff", "")
      minimum_backoff = lookup(each.value, "minimum_backoff", "")
    }
  }

  push_config {
    push_endpoint = each.value["push_endpoint"]

    // FIXME: This should be programmable, but nested map isn't supported at this time.
    //   https://github.com/hashicorp/terraform/issues/2114
    attributes = {
      x-goog-version = lookup(each.value, "x-goog-version", "v1")
    }

    dynamic "oidc_token" {
      for_each = (lookup(each.value, "oidc_service_account_email", "") != "") ? [true] : []
      content {
        service_account_email = lookup(each.value, "oidc_service_account_email", "")
        audience              = lookup(each.value, "audience", "")
      }
    }
  }
  depends_on = [
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_subscription" "pull_subscriptions" {
  for_each = var.create_subscriptions ? { for i in var.pull_subscriptions : i.name => i } : {}

  name    = each.value.name
  topic   = var.create_topic ? google_pubsub_topic.topic.0.name : var.topic
  project = var.project_id
  labels  = var.subscription_labels
  ack_deadline_seconds = lookup(
    each.value,
    "ack_deadline_seconds",
    local.default_ack_deadline_seconds,
  )
  message_retention_duration = lookup(
    each.value,
    "message_retention_duration",
    null,
  )
  retain_acked_messages = lookup(
    each.value,
    "retain_acked_messages",
    null,
  )
  filter = lookup(
    each.value,
    "filter",
    null,
  )
  enable_message_ordering = lookup(
    each.value,
    "enable_message_ordering",
    null,
  )
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = contains(keys(each.value), "expiration_policy") ? [each.value.expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = (lookup(each.value, "dead_letter_topic", "") != "") ? [each.value.dead_letter_topic] : []
    content {
      dead_letter_topic     = lookup(each.value, "dead_letter_topic", "")
      max_delivery_attempts = lookup(each.value, "max_delivery_attempts", "5")
    }
  }

  dynamic "retry_policy" {
    for_each = (lookup(each.value, "maximum_backoff", "") != "") ? [each.value.maximum_backoff] : []
    content {
      maximum_backoff = lookup(each.value, "maximum_backoff", "")
      minimum_backoff = lookup(each.value, "minimum_backoff", "")
    }
  }

  depends_on = [
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_subscription_iam_member" "pull_subscription_sa_binding_subscriber" {
  for_each = var.create_subscriptions ? { for i in var.pull_subscriptions : i.name => i if lookup(i, "service_account", null) != null } : {}

  project      = var.project_id
  subscription = each.value.name
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:${each.value.service_account}"
  depends_on = [
    google_pubsub_subscription.pull_subscriptions,
  ]
}

resource "google_pubsub_subscription_iam_member" "pull_subscription_sa_binding_viewer" {
  for_each = var.create_subscriptions ? { for i in var.pull_subscriptions : i.name => i if lookup(i, "service_account", null) != null } : {}

  project      = var.project_id
  subscription = each.value.name
  role         = "roles/pubsub.viewer"
  member       = "serviceAccount:${each.value.service_account}"
  depends_on = [
    google_pubsub_subscription.pull_subscriptions,
  ]
}

