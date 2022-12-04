module "mig2_template" {
  source             = "terraform-google-modules/vm/google//modules/instance_template"
  version            = "~> 7.9"
  network            = google_compute_network.default.self_link
  subnetwork         = var.subnetwork
  subnetwork_project = var.host_project
  service_account = {
    email  = ""
    scopes = ["cloud-platform"]
  }
  name_prefix    = "shared-vpc-mig"
  startup_script = data.template_file.group-startup-script.rendered
  tags           = ["allow-shared-vpc-mig"]
}

module "mig2" {
  source            = "terraform-google-modules/vm/google//modules/mig"
  version           = "~> 7.9"
  instance_template = module.mig2_template.self_link
  region            = var.region
  hostname          = var.network
  target_size       = 2
  named_ports = [{
    name = "http",
    port = 80
  }]
  network    = google_compute_network.default.self_link
  subnetwork = google_compute_subnetwork.default.self_link
}
