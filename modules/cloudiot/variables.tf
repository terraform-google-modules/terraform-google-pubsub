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

variable "project_id" {
  description = "The project ID to manage the Cloud IoT resources"
}

variable "region" {
  description = "The region to host the registry"
}

variable "name" {
  description = "The Cloud IoT registry name"
}

variable "mqtt_enabled_state" {
  description = "The field allows MQTT_ENABLED or MQTT_DISABLED"
  default     = "MQTT_ENABLED"
}

variable "http_enabled_state" {
  description = "The field allows HTTP_ENABLED or HTTP_DISABLED"
  default     = "HTTP_DISABLED"
}

variable "public_key_certificates" {
  description = "The list for public key certificates"
  default     = []
}

variable "event_notification_config" {
  description = <<EOF
  The event notification configuration for the Cloud IoT registry.
  This contains `topic`, `pull_subscriptions` and `push_subscriptions`.
EOF
  default = {}
}

variable "state_notification_config" {
  description = <<EOF
  The event notification configuration for the Cloud IoT registry.
  This contains `topic`, `pull_subscriptions` and `push_subscriptions`.
EOF
  default = {}
}
