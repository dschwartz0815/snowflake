terraform {
  cloud {
    organization = "DavidsSnowflake"

    workspaces {
      name = "snowflake-develop"
    }
  }
}