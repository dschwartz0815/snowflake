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
}

resource "snowflake_database" "test_db" {
  name    = "TEST_DB"
  comment = "Database for Snowflake Terraform Testing"
}