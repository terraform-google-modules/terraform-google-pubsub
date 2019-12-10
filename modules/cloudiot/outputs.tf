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

output "name" {
  value       = google_cloudiot_registry.default.name
  description = "The name of the Cloud IoT registry"
}

output "registry" {
  value       = google_cloudiot_registry.default
  description = "The registry being created by this module"
}

output "region" {
  value       = google_cloudiot_registry.default.region
  description = "The region of the Cloud IoT registry"
}

output "credentials" {
  value       = google_cloudiot_registry.default.credentials.*
  description = "The credentials for Cloud IoT registry"
}

output "event_notification_topic" {
  value       = module.event_notification_topic.topic
  description = "The name of the Pub/Sub topic associated with the registry"
}

output "event_notification_topic_id" {
  value       = module.event_notification_topic.id
  description = "The id of the Pub/Sub topic associated with the registry"
}

output "event_notification_subscription_names" {
  value       = module.event_notification_topic.subscription_names
  description = "The name list of Pub/Sub subscriptions associated with the registry"
}

output "event_notification_subscription_paths" {
  value       = module.event_notification_topic.subscription_paths
  description = "The path list of Pub/Sub subscriptions associated with the registry"
}

output "state_notification_topic" {
  value       = module.state_notification_topic.topic
  description = "The name of the Pub/Sub topic associated with the registry"
}

output "state_notification_topic_id" {
  value       = module.state_notification_topic.id
  description = "The id of the Pub/Sub topic associated with the registry"
}

output "state_notification_subscription_names" {
  value       = module.state_notification_topic.subscription_names
  description = "The name list of Pub/Sub subscriptions associated with the registry"
}

output "state_notification_subscription_paths" {
  value       = module.state_notification_topic.subscription_paths
  description = "The path list of Pub/Sub subscriptions associated with the registry"
}
