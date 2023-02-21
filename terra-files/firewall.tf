resource "google_compute_firewall" "ingress" {
  name    = "ingress-firewall"
  network = google_compute_network.vpc_network.name
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  
}
resource "google_compute_firewall" "outgress" {
  name    = "egress-firewall"
  network = google_compute_network.vpc_network.name
  direction = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = [""]
  }

  
}
