# gcloud compute instances create cks-master --zone=europe-west3-c \
# --machine-type=e2-medium \
# --image=ubuntu-2004-focal-v20230918 \
# --image-project=ubuntu-os-cloud \
# --boot-disk-size=50GB

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

data "google_compute_zones" "available" {
  region  = var.gcp_region
  project = var.gcp_project
}

resource "google_compute_instance" "cks-lab" {
  # name         = format("%s-%s-%d", var.instance_name, random_string.random-identifier.result, count.index)
  # name         = format("%s", var.instance_name[count.index])  
  # name         = count.index < var.num_of_master ? "cks-master" : "cks-worker"
  name         = format("%s-%s-%d", count.index < var.num_of_master ? var.instance_name[0] : var.instance_name[1], random_string.random-identifier.result, count.index)
  count        = var.num_of_master + var.num_of_worker
  machine_type = var.machine_type
  zone         = data.google_compute_zones.available.names[0]
  labels       = var.labels
  allow_stopping_for_update = true



  boot_disk {
    source = google_compute_disk.os-disk[count.index].name
    auto_delete = false
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  #  metadata_startup_script = var.startup_script
   metadata_startup_script = count.index < var.num_of_master ? var.startup_script[0] : var.startup_script[1]
}

resource "random_string" "random-identifier" {
  length  = 4
  special = false
  upper   = false
  lower   = true
  numeric  = true
}

resource "google_compute_disk" "os-disk" {
  count        = var.num_of_master + var.num_of_worker
  name   = format("os-disk-%s-%d", random_string.random-identifier.result, count.index)
  type   = "pd-ssd"
  image  = var.image
  labels = var.labels
  size   = var.os_pd_ssd_size
  zone   = data.google_compute_zones.available.names[0]
}
