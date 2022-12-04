# Handle Database
resource "google_sql_database_instance" "main" {
  name             = "${var.deployment_name}-db-${random_id.id.hex}"
  database_version = "MYSQL_5_7"
  region           = var.region
  project          = var.project_id

  settings {
    tier                  = "db-g1-small"
    disk_autoresize       = true
    disk_autoresize_limit = 0
    disk_size             = 10
    disk_type             = "PD_SSD"
    user_labels           = var.labels
    ip_configuration {
      ipv4_enabled    = false
      private_network = module.network-safer-mysql-simple.network_self_link
    }
    location_preference {
      zone = var.zone
    }
  }
  deletion_protection = false
  depends_on = [
    module.project-services,
    google_vpc_access_connector.main,
  ]
}

resource "google_sql_database" "database" {
  project  = var.project_id
  name     = "todo"
  instance = google_sql_database_instance.main.name
}
