provider "google" {
 credentials = file(var.credentials)
 project     = "prod-320818"
 region      = "us-central1"
}
resource "google_sql_database" "database" {
  name     = "prd_SQL"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name   = "prd_SQL"
  database_version = "SQLSERVER_2017_STANDARD"
  region = "us-central1"
  root_password = "040188"
  settings {
    tier = "db-custom-2-4"
  }

  deletion_protection  = "false"
}
