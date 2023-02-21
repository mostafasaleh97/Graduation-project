resource "google_container_cluster" "app_cluster" {
  name     = "app-cluster"
  location = "asia-east1-a"
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
  }
  network = google_compute_network.vpc_network.name
  subnetwork = google_compute_subnetwork.restricted.name


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

  

 
}

resource "google_container_node_pool" "app_cluster_linux_node_pool" {
  name           = "${google_container_cluster.app_cluster.name}--linux-node-pool"
  location       = google_container_cluster.app_cluster.location
  node_locations = ["asia-east1-b"]
  cluster        = google_container_cluster.app_cluster.name
  node_count     = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }
  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }
  node_config {
    preemptible  = true
    image_type = "COS_CONTAINERD"
    machine_type = "e2-standard-4"
    service_account = google_service_account.gcr-service.email
    oauth_scopes = ["cloud-platform"]

    labels = {
      cluster = google_container_cluster.app_cluster.name
    }
  
    
  }
}
