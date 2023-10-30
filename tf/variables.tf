# Required variables
variable "gcp_project" {
  description = "optimal-sylph-399301"
  default     = "optimal-sylph-399301"
}

# Optional variables
variable "os_pd_ssd_size" {
  description = "Size of OS disk in GB"
  default     = "50"
}

variable "gcp_region" {
  description = "GCP region, e.g. us-east1"
  default     = "us-east5"
}

variable "machine_type" {
  description = "GCP machine type"
  default     = "e2-medium"
}

variable "instance_name" {
  description = "GCP instance name"
  default     = ["cks-master", "cks-worker"]
}

variable "image" {
  description = "image to build instance from in the format: image-family/os. See: https://cloud.google.com/compute/docs/images#os-compute-support"
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

# variable "startup_script" {
#   description = "A startup script passed as metadata"
#   default     = "touch /tmp/created_by_terraform"
# }
# variable "startup_script" {
#   description = "Configure Master/Worker"
#   default     = ["sudo -i && bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_master.sh) >> /tmp/install.log", "sudo -i && bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_worker.sh) >> /tmp/install.log"]
# }

variable "labels" {
  type = map(string)
  default = {
    owner       = "ajusrlocalbin"
    environment = "cks-lab"
  }
}

variable "num_of_master" {
  description = "Adjust the qty. of servers and associated OS disks created"
  default     = 1
}

variable "num_of_worker" {
  description = "Adjust the qty. of servers and associated OS disks created"
  default     = 1
}