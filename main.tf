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
  role = "ACCOUNTADMIN"
}
#Create data base manual way
resource "snowflake_database" "test_db" {
  name    = "TEST_DB"
  comment = "Database for Snowflake Terraform Testing"
}
#Create user accounts via module
resource "snowflake_user" "cicd_user" {
  name         = lower("CICD_USER")
  login_name   = "CICD_USER"
  comment      = "Snowflake user account made by cicd"
  password     = "cicduser"
  disabled     = false
  display_name = "CICD User"
  email        = "cicd_user@example.com"
  first_name   = "CICD"
  last_name    = "User"

  default_warehouse = "COMPUTE_WH"
  default_role      = "PUBLIC"

  must_change_password = false
}
#Create new service role via module
resource "snowflake_role" "cicd_role" {
  name    = "CICD_ROLE"
  comment = "Snowflake role made by cicd"
}
#Create warehouse via module
resource "snowflake_warehouse" "cicd_warehouse" {
  name                = "CICD_WAREHOUSE"
  comment             = "Small warehouse created by cicd"
  warehouse_size      = "small"
  auto_resume         = true
  auto_suspend        = 10
  initially_suspended = true
}
#Create database & schema via cicd
resource "snowflake_database" "cicd_database" {
  name    = "CICD_DATABASE"
  comment = "Database made by cicd"
}

resource "snowflake_database" "develop_db" {
  name    = "DEVELOP_DATABASE"
  comment = "Database for Development"
}