terraform {

}

provider "google" {
  project = var.gcloud_project
  region  = join("-", slice(split("-", var.gcloud_zone), 0, 2))
  credentials = file(var.gcloud_cred_file)
}

# Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  byte_length = 8
}