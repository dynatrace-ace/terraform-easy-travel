terraform {
  required_version = ">= 0.12.20"
  required_providers {
    google = {
      version = ">= 3.58.0"
    }
    random = {
      version = "~> 2.2"
    }
    local = {
      version = "~> 1.4"
    }
  }
}