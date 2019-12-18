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

output "topic" {
  value       = length(google_pubsub_topic.topic) > 0 ? google_pubsub_topic.topic.0.name : ""
  description = "The name of the Pub/Sub topic"
}

output "topic_labels" {
  value       = length(google_pubsub_topic.topic) > 0 ? google_pubsub_topic.topic.0.labels : {}
  description = "Labels assigned to the Pub/Sub topic"
}

output "id" {
  value       = length(google_pubsub_topic.topic) > 0 ? google_pubsub_topic.topic.0.id : ""
  description = "The ID of the Pub/Sub topic"
}

output "uri" {
  value       = length(google_pubsub_topic.topic) > 0 ? "pubsub.googleapis.com/${google_pubsub_topic.topic.0.id}" : ""
  description = "The URI of the Pub/Sub topic"
}

output "subscription_names" {
  value = concat(
    google_pubsub_subscription.push_subscriptions.*.name,
    google_pubsub_subscription.pull_subscriptions.*.name,
  )

  description = "The name list of Pub/Sub subscriptions"
}

output "subscription_paths" {
  value = concat(
    google_pubsub_subscription.push_subscriptions.*.path,
    google_pubsub_subscription.pull_subscriptions.*.path,
  )

  description = "The path list of Pub/Sub subscriptions"
}

