# Easy Travel Terraform

## Requirements

Terraform needs to be locally installed.
A GCP account is needed.

## Instructions for GCP

1. Prepare Service Account and download JSON key credentials in GCP.

    ```yaml
    https://cloud.google.com/iam/docs/creating-managing-service-accounts
    ```

1. Initialize terraform

    ```bash
    $ terraform init
    ```

1. Create a `terraform.tfvars` file inside the *terraform/gcloud* folder
   It needs to contain the following as a minimum:

    ```hcl
    gcloud_project    = "myGCPProject" # GCP Project you want to use
    gcloud_cred_file  = "/location/to/sakey.json" # location of the Service Account JSON created earlier
    gcloud_zone       = "us-east1-b" # zone where you want to provision the resources. Check out https://cloud.google.com/compute/docs/regions-zones#available for available zones
    ```

    Check out `variables.tf` for a complete list of variables

1. Verify the configuration by running `terraform plan`

    ```bash
    $ terraform plan
    ```

1. Apply the configuration

    ```bash
    $ terraform apply
    ```

## Useful Terraform Commands

Command  | Result
-------- | -------
`terraform destroy` | deletes any resources created by Terraform |
`terraform plan -destroy` | view a speculative destroy plan, to see what the effect of destroying would be |
`terraform show` | Outputs the resources created by Terraform. Useful to verify IP addresses and the dashboard URL. 
