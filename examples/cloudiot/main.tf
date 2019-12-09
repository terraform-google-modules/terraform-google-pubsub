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

provider "google" {
  version = "~> 2.13"
  region  = var.region
}

module "iot" {
  source             = "../../modules/cloudiot"
  name               = var.name
  region             = var.region
  project_id         = var.project_id
  mqtt_enabled_state = "MQTT_ENABLED"
  http_enabled_state = "HTTP_DISABLED"
  public_key_certificates = [
    {
      format      = "X509_CERTIFICATE_PEM"
      certificate = var.rsa_cert1_pem
    },
    {
      format      = "X509_CERTIFICATE_PEM"
      certificate = var.rsa_cert2_pem
    },
  ]
  event_notification_config = {
    topic              = "${var.name}-event-topic"
    topic_labels       = {}
    create_topic       = true
    push_subscriptions = []
    pull_subscriptions = [
      {
        name                 = "${var.name}-event-pull"
        ack_deadline_seconds = 20
      }
    ]
  }
  state_notification_config = {
    topic        = "${var.name}-state-topic"
    topic_labels = {}
    create_topic = true
    push_subscriptions = [
      {
        name                 = "${var.name}-state-push"
        push_endpoint        = "https://${var.project_id}.appspot.com/"
        x-goog-version       = "v1beta1"
        ack_deadline_seconds = 20
      },
    ]
    pull_subscriptions = []
  }
}
