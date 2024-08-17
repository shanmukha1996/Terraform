// Configure the Google Cloud provider
provider "google" {
 credentials = file("/Users/pavanpss/Desktop/terraform.json") // Credentials file path
 project     = "jenkins1-290810" // Your Google Cloud Project
 region      = "europe-west2" // Your Region
}


// Creating Compute Engine instances
resource "google_compute_instance" "default" {
 name         = "myinstance"
 machine_type = "f1-micro"
 zone         = "europe-west2-a"
 tags         = ["foo","bar"]
 count        = 2
 boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts" // Boot Disk Image
    }
  }    
 network_interface {
   network = google_compute_network.default.name
   access_config {
  }
 }
}
// Firewall Creation
resource "google_compute_firewall" "default" {
  name    = "my-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_tags = ["web"]
}
resource "google_compute_network" "default" {
  name = "network"
}