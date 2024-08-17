// Configure the Google Cloud provider
provider "google" {
 // Specify the path of the JSON credentials file
 credentials = file("/full_path/Credentials.json")
 project     = "your_project_name"
 region      = "your_region"
}


// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "myinstance"
 machine_type = "f1-micro"
 zone         = "your_zone"

 boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }
 
 network_interface {
   network = "default"
 }
}

// Firewall Rules
resource "google_compute_firewall" "default" {
  name    = "my-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    // Specify the ports that you want to access
    ports    = ["80", "8080", "1000-2000"] 
  }

  source_tags = ["web"]
}

resource "google_compute_network" "default" {
  name = "my-network"
}
