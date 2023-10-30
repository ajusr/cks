terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.3.0"
    }
  }
}

provider "google" {
  # alias   = "columbus"
  region  = "us-east5"
  project = "optimal-sylph-399301"
}
