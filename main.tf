terraform {
  cloud {
    organization = "DavidsSnowflake"

  }
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.68"
    }
  }
}

provider "snowflake" {
  role = "SYSADMIN"
}
#Create data base manual way
resource "snowflake_database" "test_db" {
  name    = "TEST_DB"
  comment = "Database for Snowflake Terraform Testing"
}
#Create user accounts via module
module "all_user_accounts" {
  source = "./user"
  count  = local.enable_in_dev_flag
  user_map = {
    "admin@davidssnowflake.com" : { "first_name" = "Test", "last_name" = "Module", "email" = "admin@davidssnowflake.com" }
  }
}
#Create new service role via module
module "regression_role" {
  source       = "./roles"
  role_name    = "DEPLOY-REGRESSION"
  role_comment = "Snowflake role used regression testing"

  roles = ["SYSADMIN"]
  users = [lower("${var.env_code}_entechlog_dbt_user")]

  depends_on = [module.all_service_accounts]
}
#Create warehouse via module
module "davids_module_warehouse" {
  source                 = "./warehouse"
  warehouse_name         = "DAVID-WAREHOUSE-MODULE"
  warehouse_size         = "XSMALL"
  warehouse_auto_suspend = 30
  warehouse_grant_roles = {
    "OWNERSHIP" = ["SYSADMIN"]
  }
}
#Create database & schema via module
module "module_made_db" {
  source = "./database"

  db_name    = "MODULE_MADE_DB"
  db_comment = "Database to store the ingested RAW data"

  db_grant_roles = {
    "OWNERSHIP" = ["SYSADMIN"]
  }

  schemas = ["DATAGEN", "SEED", "YELLOW_TAXI"]

  /* https://docs.snowflake.com/en/user-guide/security-access-control-privileges.html#schema-privileges */
  schema_grant = {
    "DATAGEN OWNERSHIP"        = { "roles" = ["SYSADMIN"] },
    "DATAGEN USAGE"            = { "roles" = ["SYSADMIN"] },
    "DATAGEN CREATE TABLE"     = { "roles" = ["SYSADMIN"] },
    "DATAGEN CREATE VIEW"      = { "roles" = ["SYSADMIN"] },
    "DATAGEN CREATE STAGE"     = { "roles" = ["SYSADMIN"] },
    "DATAGEN CREATE PIPE"      = { "roles" = ["SYSADMIN"] },
    "DATAGEN CREATE FUNCTION"  = { "roles" = ["SYSADMIN"] },
    "SEED OWNERSHIP"           = { "roles" = ["SYSADMIN"] },
    "SEED USAGE"               = { "roles" = ["SYSADMIN"] },
    "SEED CREATE TABLE"        = { "roles" = ["SYSADMIN"] },
    "SEED CREATE VIEW"         = { "roles" = ["SYSADMIN"] },
    "SEED CREATE STAGE"        = { "roles" = ["SYSADMIN"] },
    "YELLOW_TAXI OWNERSHIP"    = { "roles" = ["SYSADMIN"] },
    "YELLOW_TAXI USAGE"        = { "roles" = ["SYSADMIN"] },
    "YELLOW_TAXI CREATE TABLE" = { "roles" = ["SYSADMIN"] },
    "YELLOW_TAXI CREATE VIEW"  = { "roles" = ["SYSADMIN"] },
    "YELLOW_TAXI CREATE STAGE" = { "roles" = ["SYSADMIN"] },
  }

  table_grant = {
    "DATAGEN SELECT"     = { "roles" = ["ACCOUNTADMIN"] }
    "SEED SELECT"        = { "roles" = ["ACCOUNTADMIN"] }
    "YELLOW_TAXI SELECT" = { "roles" = ["ACCOUNTADMIN"] }
  }
}