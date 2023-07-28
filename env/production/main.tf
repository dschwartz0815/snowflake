terraform {
  cloud {
    organization = "DavidsSnowflake"

    workspaces {
      name = "snowflake-production"
    }
  }
}
