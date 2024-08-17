// Configure the Google Cloud provider
provider "google" {
 credentials = file("/Users/pavanpss/Desktop/mykey.json")
 project     = "instancepaa"
 region      = "europe-west2"
}


// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "myinstance"
 machine_type = "f1-micro"
 zone         = "europe-west2-a"

 boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }    
 network_interface {
   network = "default"
 }
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
}

resource "google_compute_network" "default" {
  name = "test-network"
}
