resource "google_compute_instance" "private-instance" {
  name         = "private-instance"
  machine_type = "e2-small"
  zone = "asia-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.managment.name

    
  }


  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.cluster-service.email
    scopes = ["cloud-platform"]
  }
}