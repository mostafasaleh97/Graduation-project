resource "google_container_cluster" "app_cluster" {
  name     = "app-cluster"
  location = "asia-east1"
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 2

  ip_allocation_policy {
    # cluster_ipv4_cidr_block = "10.72.0.0/14"
    # services_ipv4_cidr_block = "192.168.0.0/25"
  }
  network = google_compute_network.vpc_network.name
  subnetwork = google_compute_subnetwork.restricted.name

  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  maintenance_policy {
    daily_maintenance_window {
      start_time = "02:00"
    }
  }

#   master_auth {
#     username = "my-user"
#     password = "useYourOwnPassword."

#     client_certificate_config {
#       issue_client_certificate = false
#     }
#   }

  dynamic "master_authorized_networks_config" {
    for_each = google_compute_subnetwork.managment.ip_cidr_range != null ? [google_compute_subnetwork.managment.ip_cidr_range] : []
    content {
      cidr_blocks {
        cidr_block   = google_compute_subnetwork.managment.ip_cidr_range
        display_name = "External Control Plane access"
      }
    }
  }

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  release_channel {
      channel = "STABLE"
  }

  addons_config {
    // Enable network policy (Calico)
    network_policy_config {
        disabled = false
      }
  }

  /* Enable network policy configurations (like Calico).
  For some reason this has to be in here twice. */
  network_policy {
    enabled = "true"
  }

 
}

resource "google_container_node_pool" "app_cluster_linux_node_pool" {
  name           = "${google_container_cluster.app_cluster.name}--linux-node-pool"
  location       = google_container_cluster.app_cluster.location
  node_locations = ["asia-east1-b"]
  cluster        = google_container_cluster.app_cluster.name
  node_count     = 1

  autoscaling {
    max_node_count = 1
    min_node_count = 1
  }
  max_pods_per_node = 100

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = true
    disk_size_gb = 10

    service_account = google_service_account.gcr-service.email
    oauth_scopes = ["cloud-platform"]

    labels = {
      cluster = google_container_cluster.app_cluster.name
    }

    shielded_instance_config {
      enable_secure_boot = true
    }

    // Enable workload identity on this node pool.
    

    metadata = {
      // Set metadata on the VM to supply more entropy.
      google-compute-enable-virtio-rng = "true"
      // Explicitly remove GCE legacy metadata API endpoint.
      disable-legacy-endpoints = "true"
    }
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 1
  }
}
