provider "google" {
 credentials = file(var.Provider)
 project     = "prod-320818"
 region      = "us-central1"
}
resource "google_sql_database" "database" {
  name     = "prd-database-sql"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name   = "prd-sql"
  database_version = "SQLSERVER_2017_STANDARD"
  region = "us-central1"
  root_password = "040188"
  settings {
    tier = "db-custom-2-4096"
  }

  deletion_protection  = "false"
}
