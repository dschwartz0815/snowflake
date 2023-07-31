# Snowflake CICD Pipeline with Terraform

## Overview

This repository contains the code and configuration for setting up a Continuous Integration and Continuous Deployment (CICD) pipeline to manage changes to a Snowflake instance using Terraform. The pipeline is designed to automate the deployment process, ensuring smooth and consistent updates to the Snowflake infrastructure when code changes are made to various branches.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Configuration](#configuration)
4. [Usage](#usage)
5. [Contributing](#contributing)
6. [License](#license)

## Prerequisites

Before setting up the CICD pipeline, you'll need the following prerequisites:

- Snowflake Trial Account: You must have access to a Snowflake account where you want to apply the infrastructure changes.

- Terraform Cloud: Make sure you have a Terraform Cloud account, and optionally, Terraform CLI installed on your local machine. The pipeline will use Terraform to manage the Snowflake infrastructure.

- GitHub: You need GitHub Actions to orchestrate the pipeline.

## Installation

1. Clone this repository to your local machine using the following command:
git clone https://github.com/dschwartz0815/snowflake.git

cd snowflake

2. Install any necessary dependencies and setup GitHub accordingly.

## Configuration

### Snowflake Credentials

In order to interact with your Snowflake instance, you need to provide the necessary credentials. This can be achieved using environment variables, configuration files, or secrets managed by GitHub Actions Secrets. Ensure that the credentials are stored securely and not exposed in your repository.

### Terraform Variables

The Terraform code in this repository may contain variables that you can customize based on your Snowflake environment's specific needs. These variables can be set as environment variables or passed through GitHub Actions YML.

## Usage

The CICD pipeline is triggered automatically whenever changes are pushed to specific branches. The workflow includes the following stages:

1. **Build**: In this stage, the GitHub Actions will prepare the environment, install dependencies, and validate the TF code.

2. **Test**: This stage involves running tests on the Terraform code and infrastructure to ensure it meets the defined criteria.

3. **Deploy**: If the tests pass successfully, the changes will be deployed to the Snowflake instance using Terraform.

4. **Rollback (Optional)**: Depending on your configuration, a rollback stage may be included to revert changes if any errors occur during the deployment. (WIP)

## License

This project is licensed under the [MIT License](LICENSE). You are free to modify, distribute, and use the code in this repository, subject to the terms and conditions of the MIT License.
