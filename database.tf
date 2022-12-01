module "sql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "8.0.0"
}
