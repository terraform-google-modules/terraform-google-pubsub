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

resource "google_project_iam_member" "bigquery_metadata_viewer_binding" {
  count   = var.grant_bigquery_project_roles && (length(var.bigquery_subscriptions) != 0) ? 1 : 0
  project = var.project_id
  role    = "roles/bigquery.metadataViewer"
  member  = "serviceAccount:${local.pubsub_svc_account_email}"
}

resource "google_project_iam_member" "bigquery_data_editor_binding" {
  count   = var.grant_bigquery_project_roles && (length(var.bigquery_subscriptions) != 0) ? 1 : 0
  project = var.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${local.pubsub_svc_account_email}"
}

resource "google_project_iam_member" "storage_admin_binding" {
  count   = var.grant_cloud_storage_project_roles && length(var.cloud_storage_subscriptions) != 0 ? 1 : 0
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${local.pubsub_svc_account_email}"
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
  for_each = var.create_topic ? { for i in var.push_subscriptions : i.name => i if i.dead_letter_topic != null } : {}

  project = var.project_id
  topic   = each.value.dead_letter_topic
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${local.pubsub_svc_account_email}"
  depends_on = [
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_topic_iam_member" "pull_topic_binding" {
  for_each = var.create_topic ? { for i in var.pull_subscriptions : i.name => i if i.dead_letter_topic != null } : {}

  project = var.project_id
  topic   = each.value.dead_letter_topic
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${local.pubsub_svc_account_email}"
  depends_on = [
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_topic_iam_member" "bigquery_topic_binding" {
  for_each = var.create_topic ? { for i in var.bigquery_subscriptions : i.name => i if i.dead_letter_topic != null } : {}

  project = var.project_id
  topic   = each.value.dead_letter_topic
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${local.pubsub_svc_account_email}"
  depends_on = [
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_subscription_iam_member" "pull_subscription_binding" {
  for_each = var.create_subscriptions ? { for i in var.pull_subscriptions : i.name => i if i.dead_letter_topic != null } : {}

  project      = var.project_id
  subscription = each.value.name
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:${local.pubsub_svc_account_email}"
  depends_on = [
    google_pubsub_subscription.pull_subscriptions,
  ]

  lifecycle {
    replace_triggered_by = [google_pubsub_subscription.pull_subscriptions[each.key]]
  }
}

resource "google_pubsub_subscription_iam_member" "push_subscription_binding" {
  for_each = var.create_subscriptions ? { for i in var.push_subscriptions : i.name => i if i.dead_letter_topic != null } : {}

  project      = var.project_id
  subscription = each.value.name
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:${local.pubsub_svc_account_email}"
  depends_on = [
    google_pubsub_subscription.push_subscriptions,
  ]

  lifecycle {
    replace_triggered_by = [google_pubsub_subscription.push_subscriptions[each.key]]
  }
}

resource "google_pubsub_subscription_iam_member" "bigquery_subscription_binding" {
  for_each = var.create_subscriptions ? { for i in var.bigquery_subscriptions : i.name => i if i.dead_letter_topic != null } : {}

  project      = var.project_id
  subscription = each.value.name
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:${local.pubsub_svc_account_email}"
  depends_on = [
    google_pubsub_subscription.bigquery_subscriptions,
  ]
}

resource "google_pubsub_topic" "topic" {
  count                      = var.create_topic ? 1 : 0
  project                    = var.project_id
  name                       = var.topic
  labels                     = var.topic_labels
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
  for_each = var.create_subscriptions ? { for i in var.push_subscriptions : i.name => i } : {}

  name                       = each.value.name
  topic                      = var.create_topic ? google_pubsub_topic.topic[0].name : var.topic
  project                    = var.project_id
  labels                     = var.subscription_labels
  ack_deadline_seconds       = each.value.ack_deadline_seconds != null ? each.value.ack_deadline_seconds : local.default_ack_deadline_seconds
  message_retention_duration = each.value.message_retention_duration
  retain_acked_messages      = each.value.retain_acked_messages
  filter                     = each.value.filter
  enable_message_ordering    = each.value.enable_message_ordering
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = each.value.expiration_policy != null ? [each.value.expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = each.value.dead_letter_topic != null ? [each.value.dead_letter_topic] : []
    content {
      dead_letter_topic     = each.value.dead_letter_topic != null ? each.value.dead_letter_topic : ""
      max_delivery_attempts = each.value.max_delivery_attempts != null ? each.value.max_delivery_attempts : ""
    }
  }

  dynamic "retry_policy" {
    for_each = each.value.maximum_backoff != null ? [each.value.maximum_backoff] : []
    content {
      maximum_backoff = each.value.maximum_backoff != null ? each.value.maximum_backoff : ""
      minimum_backoff = each.value.minimum_backoff != null ? each.value.minimum_backoff : "5"
    }
  }

  push_config {
    push_endpoint = each.value["push_endpoint"]

    // FIXME: This should be programmable, but nested map isn't supported at this time.
    //   https://github.com/hashicorp/terraform/issues/2114
    attributes = {
      x-goog-version = each.value.minimum_backoff != null ? "x-goog-version" : "v1"
    }

    dynamic "oidc_token" {
      for_each = each.value.oidc_service_account_email != null ? [true] : []
      content {
        service_account_email = each.value.oidc_service_account_email != null ? each.value.oidc_service_account_email : ""
        audience              = each.value.audience != null ? each.value.audience : ""
      }
    }
    dynamic "no_wrapper" {
      for_each = each.value.no_wrapper == true ? [true] : []
      content {
        write_metadata = each.value.write_metadata != null ? each.value.write_metadata : false
      }
    }
  }
  depends_on = [
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_subscription" "pull_subscriptions" {
  for_each = var.create_subscriptions ? { for i in var.pull_subscriptions : i.name => i } : {}

  name                         = each.value.name
  topic                        = var.create_topic ? google_pubsub_topic.topic[0].name : var.topic
  project                      = var.project_id
  labels                       = var.subscription_labels
  enable_exactly_once_delivery = each.value.enable_exactly_once_delivery
  ack_deadline_seconds         = each.value.ack_deadline_seconds != null ? each.value.ack_deadline_seconds : local.default_ack_deadline_seconds
  message_retention_duration   = each.value.message_retention_duration
  retain_acked_messages        = each.value.retain_acked_messages
  filter                       = each.value.filter
  enable_message_ordering      = each.value.enable_message_ordering
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = each.value.expiration_policy != null ? [each.value.expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = each.value.dead_letter_topic != null ? [each.value.dead_letter_topic] : []
    content {
      dead_letter_topic     = each.value.dead_letter_topic != null ? each.value.dead_letter_topic : ""
      max_delivery_attempts = each.value.max_delivery_attempts != null ? each.value.max_delivery_attempts : "5"
    }
  }

  dynamic "retry_policy" {
    for_each = each.value.maximum_backoff != null ? [each.value.maximum_backoff] : []
    content {
      maximum_backoff = each.value.maximum_backoff != null ? each.value.maximum_backoff : ""
      minimum_backoff = each.value.minimum_backoff != null ? each.value.minimum_backoff : "5"
    }
  }

  depends_on = [
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_subscription" "bigquery_subscriptions" {
  for_each = var.create_subscriptions ? { for i in var.bigquery_subscriptions : i.name => i } : {}

  name                       = each.value.name
  topic                      = var.create_topic ? google_pubsub_topic.topic[0].name : var.topic
  project                    = var.project_id
  labels                     = var.subscription_labels
  ack_deadline_seconds       = each.value.ack_deadline_seconds != null ? each.value.ack_deadline_seconds : local.default_ack_deadline_seconds
  message_retention_duration = each.value.message_retention_duration
  retain_acked_messages      = each.value.retain_acked_messages
  filter                     = each.value.filter
  enable_message_ordering    = each.value.enable_message_ordering
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = each.value.expiration_policy != null ? [each.value.expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = each.value.dead_letter_topic != null ? [each.value.dead_letter_topic] : []
    content {
      dead_letter_topic     = each.value.dead_letter_topic != null ? each.value.dead_letter_topic : ""
      max_delivery_attempts = each.value.max_delivery_attempts != null ? each.value.max_delivery_attempts : "5"
    }
  }

  dynamic "retry_policy" {
    for_each = each.value.maximum_backoff != null ? [each.value.maximum_backoff] : []
    content {
      maximum_backoff = each.value.maximum_backoff != null ? each.value.maximum_backoff : ""
      minimum_backoff = each.value.minimum_backoff != null ? each.value.minimum_backoff : ""
    }
  }

  bigquery_config {
    table               = each.value["table"]
    use_topic_schema    = each.value.use_topic_schema != null ? each.value.use_topic_schema : false
    use_table_schema    = each.value.use_table_schema != null ? each.value.use_table_schema : false
    write_metadata      = each.value.write_metadata != null ? each.value.write_metadata : false
    drop_unknown_fields = each.value.drop_unknown_fields != null ? each.value.drop_unknown_fields : false
  }

  depends_on = [
    google_pubsub_topic.topic,
    google_project_iam_member.bigquery_metadata_viewer_binding,
    google_project_iam_member.bigquery_data_editor_binding
  ]
}

resource "google_pubsub_subscription" "cloud_storage_subscriptions" {
  for_each = var.create_subscriptions ? { for i in var.cloud_storage_subscriptions : i.name => i } : {}

  name                       = each.value.name
  topic                      = var.create_topic ? google_pubsub_topic.topic[0].name : var.topic
  project                    = var.project_id
  labels                     = var.subscription_labels
  ack_deadline_seconds       = each.value.ack_deadline_seconds != null ? each.value.ack_deadline_seconds : local.default_ack_deadline_seconds
  message_retention_duration = each.value.message_retention_duration
  retain_acked_messages      = each.value.retain_acked_messages
  filter                     = each.value.filter
  enable_message_ordering    = each.value.enable_message_ordering
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = each.value.expiration_policy != null ? [each.value.expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = each.value.dead_letter_topic != null ? [each.value.dead_letter_topic] : []
    content {
      dead_letter_topic     = each.value.dead_letter_topic != null ? each.value.dead_letter_topic : ""
      max_delivery_attempts = each.value.max_delivery_attempts != null ? each.value.max_delivery_attempts : "5"
    }
  }

  dynamic "retry_policy" {
    for_each = each.value.maximum_backoff != null ? [each.value.maximum_backoff] : []
    content {
      maximum_backoff = each.value.maximum_backoff != null ? each.value.maximum_backoff : ""
      minimum_backoff = each.value.minimum_backoff != null ? each.value.minimum_backoff : ""
    }
  }

  cloud_storage_config {
    bucket                   = each.value["bucket"]
    filename_prefix          = each.value.filename_prefix
    filename_suffix          = each.value.filename_suffix
    filename_datetime_format = each.value.filename_datetime_format
    max_duration             = each.value.max_duration
    max_bytes                = each.value.max_bytes
    max_messages             = each.value.max_messages
    dynamic "avro_config" {
      for_each = (each.value.output_format == "avro") ? [true] : []
      content {
        write_metadata   = each.value.write_metadata
        use_topic_schema = each.value.use_topic_schema
      }
    }
  }

  depends_on = [
    google_pubsub_topic.topic,
    google_project_iam_member.storage_admin_binding
  ]
}

resource "google_pubsub_subscription_iam_member" "pull_subscription_sa_binding_subscriber" {
  for_each = var.create_subscriptions ? { for i in var.pull_subscriptions : i.name => i if i.service_account != null } : {}

  project      = var.project_id
  subscription = each.value.name
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:${each.value.service_account}"
  depends_on = [
    google_pubsub_subscription.pull_subscriptions,
  ]

  lifecycle {
    replace_triggered_by = [google_pubsub_subscription.pull_subscriptions[each.key]]
  }
}

resource "google_pubsub_subscription_iam_member" "pull_subscription_sa_binding_viewer" {
  for_each = var.create_subscriptions ? { for i in var.pull_subscriptions : i.name => i if i.service_account != null } : {}

  project      = var.project_id
  subscription = each.value.name
  role         = "roles/pubsub.viewer"
  member       = "serviceAccount:${each.value.service_account}"
  depends_on = [
    google_pubsub_subscription.pull_subscriptions,
  ]

  lifecycle {
    replace_triggered_by = [google_pubsub_subscription.pull_subscriptions[each.key]]
  }
}
