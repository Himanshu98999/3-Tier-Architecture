 module "gce-ilb" {
  source       = "GoogleCloudPlatform/lb-internal/google"
  version      = "~> 2.0"
  region       = var.region
  name         = "group2-ilb"
  ports        = ["80"]
  health_check = var.health_check
  source_tags  = ["allow-group1"]
  target_tags  = ["allow-group2"]
  backends     = [
    { group = module.mig2.instance_group, description = "", failover = false }
     ]
}
