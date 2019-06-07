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
  credentials = "${file(var.credentials_file_path)}"
}

module "iot" {
  source     = "../../../modules/cloudiot"
  project_id = "${var.project}"
  name       = var.registry_name
  region     = "${var.region}"
  mqtt_enabled_state = "MQTT_ENABLED"
  public_key_certificates = [
    {
      format = "X509_CERTIFICATE_PEM"
      certificate = file("./rsa_cert1.pem")
    },
    {
      format = "X509_CERTIFICATE_PEM"
      certificate = file("./rsa_cert2.pem")
    },
  ]
  event_notification_config = {
    topic_name = "${var.registry_name}-event-topic"
    pull_subscriptions = [
      {
        name = "${var.registry_name}-event-pull"
        ack_deadline_seconds = 20
      }
    ]
  }
  state_notification_config = {
    topic_name = "${var.registry_name}-state-topic"
    push_subscriptions = [
      {
        name                 = "${var.registry_name}-state-push"
        push_endpoint        = "https://${var.project}.appspot.com/"
        x-goog-version       = "v1beta1"
        ack_deadline_seconds = 20
      },
    ]
  }
}
