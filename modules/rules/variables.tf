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

variable "bucket" {
  description = "The GCS bucket where rules will be uploaded"
  type        = "string"
}

variable "org_id" {
  description = "The organization ID"
}

variable "domain" {
  description = "The domain associated with the GCP Organization ID"
}

variable "rules_path" {
  description = "The path to the rules folder (leave empty to use default rules)"
  default     = ""
}

variable "rules_files" {
  description = "The name of the rule files to sync"
  type        = "list"
  default     = []
}
