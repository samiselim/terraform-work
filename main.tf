
resource "google_compute_instance" "my-instance" {
  name         = var.instanceConfigs.name
  machine_type = var.instanceConfigs.machine_type
  zone         = var.instanceConfigs.zone
  allow_stopping_for_update = var.instanceConfigs.allow_stopping_for_update
  boot_disk {
    initialize_params {
        image = var.instanceConfigs.disk.source_image
    }
  }
  network_interface {
    network = google_compute_network.terraform-network.self_link
    subnetwork = google_compute_subnetwork.terraform-subnetwork.self_link
    access_config {
      // Ephemeral public IP
    }
  }
}
resource "google_compute_network" "terraform-network" {
  name = "terraform-network"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "terraform-subnetwork" {
    name= "terraform-subnetwork"
    ip_cidr_range = "10.20.0.0/16"
    region = "us-central1"
    network = google_compute_network.terraform-network.id
  
}
output "network_id" {
    value = google_compute_network.terraform-network.id
}
output "subnet_id" {
    value = google_compute_subnetwork.terraform-subnetwork.id
}
output "instance_id" {
    value = google_compute_instance.my-instance.id
}