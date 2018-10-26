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

provider "google" {
  credentials = "${file(var.credentials_file_path)}"
}

module "pubsub" {
  source     = "../../"
  project_id = "${var.project}"
  topic      = "${var.topic_name}"

  push_subscriptions = [
    {
      name                 = "push"
      push_endpoint        = "https://${var.project}.appspot.com/"
      attributes           = "x-goog-version:v1beta1"
      ack_deadline_seconds = 20
    },
  ]

  pull_subscriptions = [
    {
      name = "pull"
    },
  ]
}
