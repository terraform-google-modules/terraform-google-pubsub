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

variable "credentials_file_path" {
  description = "Service account json auth path"
}

variable "project" {
  description = "The project to run tests against"
}

variable "region" {
  description = "The region for hosting the registry"
  default     = "us-central1"
}

variable "registry_name" {
  description = "The project to run tests against"
}
