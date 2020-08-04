resource "//cloudresourcemanager.googleapis.com/projects/${GCP_PROJECT}" {
  roles = ["roles/viewer"]
}
