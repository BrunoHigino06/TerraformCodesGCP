provider "google" {
 credentials = file(var.Provider)
 project     = "prod-320818"
 region      = "us-central1"
}

#DB Instance

resource "google_sql_database_instance" "instance" {
  name   = "prd-sql-02"
  database_version = "SQLSERVER_2017_STANDARD"
  region = "us-central1"
  root_password = var.RootPassword
  settings {
    tier = "db-custom-2-4096"
    ip_configuration {
      authorized_networks {
        name = "Whitelist"
        value = var.WhitelistNetworks
        
      }
      authorized_networks {
        name = "Whitelist1"
        value = var.WhitelistNetworks1
        
      }
    }
    user_labels = {
      "db" = "sql-prod-system"
    }
  }
  deletion_protection  = "false"
  
}

#DataBase (Created after the creation of a DB instance)

resource "google_sql_database" "database" {
  name     = "prd-database-sql"
  instance = google_sql_database_instance.instance.name
  depends_on = [
    google_sql_database_instance.instance
  ]
}
