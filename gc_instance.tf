resource "google_compute_address" "static" {
  name = "ipv4-address-${random_id.instance_id.hex}"
}

resource "google_compute_firewall" "allow_http" {
  name    = "gci-${random_id.instance_id.hex}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8094", "8080", "8079", "8092"]
  }

  target_tags = ["gci-et-${random_id.instance_id.hex}"]
}

## Create key pair
resource "tls_private_key" "ubuntu_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ubuntu_pem" { 
  filename = "${path.module}/${var.private_ssh_key}"
  content = tls_private_key.ubuntu_key.private_key_pem
  file_permission = 400
}

# A single Google Cloud Engine instance
resource "google_compute_instance" "ubuntu_vm" {

  name         = "${var.hostname}-${random_id.instance_id.hex}"
  machine_type = var.instance_size
  zone         = var.gcloud_zone

  boot_disk {
    initialize_params {
      image = var.gce_image_name # OS version
      size  = var.gce_disk_size  # size of the disk in GB
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Include this section to give the VM an external ip address
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    sshKeys = "${var.gce_username}:${tls_private_key.ubuntu_key.public_key_openssh}"
  }

  tags = ["gci-et-${random_id.instance_id.hex}"]

  connection {
    host        = self.network_interface.0.access_config.0.nat_ip
    type        = "ssh"
    user        = var.gce_username
    private_key = tls_private_key.ubuntu_key.private_key_pem
  }


  provisioner "file" {
    source      = "provision.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provision.sh",
      "/tmp/provision.sh",
    ]
  }
}