resource "google_compute_subnetwork" "managment" {
  name          = "managment"
  ip_cidr_range = "10.0.0.0/24"
  region        = "asia-east1"
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
  stack_type = "IPV4_ONLY"
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
  

}
resource "google_compute_subnetwork" "restricted" {
  name          = "restricted"
  ip_cidr_range = "10.0.1.0/24"
  region        = "asia-east1"
  network       = google_compute_network.vpc_network.id
  stack_type = "IPV4_ONLY"
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.20.0/24"
  }
  
}