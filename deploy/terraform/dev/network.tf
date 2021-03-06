/**
 * Copyright 2021 Security Union LLC
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

module "gke-network" {
  source       = "terraform-google-modules/network/google"
  project_id   = var.project_id
  network_name = "${var.name}-network"

  subnets = [
    {
      subnet_name   = "${var.name}-subnet"
      subnet_ip     = "10.0.0.0/24"
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "${var.name}-subnet" = [
      {
        range_name    = "${var.name}-ip-range-pods"
        ip_cidr_range = "10.1.0.0/16"
      },
      {
        range_name    = "${var.name}-ip-range-services"
        ip_cidr_range = "10.2.0.0/20"
      },
  ] }
}
