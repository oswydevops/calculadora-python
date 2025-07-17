provider "google" {
  project = var.gcp_project
  region  = "us-central1"
}

resource "google_cloud_run_service" "calculadora" {
  name     = "calculadora-python"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/${var.gcp_project}/calculadora-python:latest"  # Jenkins actualizará esto
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Permite acceso público a la app
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service_iam_policy" "public_access" {
  location = google_cloud_run_service.calculadora.location
  project  = google_cloud_run_service.calculadora.project
  service  = google_cloud_run_service.calculadora.name

  policy_data = data.google_iam_policy.noauth.policy_data
}