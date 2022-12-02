provider"google" {

  project               ="main"

  user_project_override = true

  # to be replaced with service account key

  credentials = "C:\\Users\\user_id\\AppData\\Roaming\\gcloud\\application_default_credentials.json"

}



provider"google-beta" {

  project               ="main"

  user_project_override = true

}
