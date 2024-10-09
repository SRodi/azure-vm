# Terraform Azure Virtual Machine Infrastructure

This project sets up Azure infrastructure using OpenTF. It includes network security groups, network interfaces, and other necessary resources to create a VM. For more information, visit the [OpenTF website](https://opentf.org).

## Prerequisites

- [OpenTofu](https://opentofu.org/docs/intro/install/) v1.0.0 or higher
- Azure subscription

## Project Structure

The initial project structure is as follows:

```
.
├── .gitignore
├── LICENCE
├── .terraform.lock.hcl
├── main.tf
├── providers.tf
└── variables.tf
```

After running the instructions mentioned in the section [Usage](#usage) the structure will look as follows:

```
.
├── .gitignore
├── LICENCE
├── .terraform/
│   ├── providers/
│   │   ├── registry.opentofu.org/
│   │   │   ├── hashicorp/
│   │   │   │   ├── azurerm/
│   │   │   │   │   ├── 4.4.0/
│   │   │   │   │   │   ├── linux_amd64/
│   │   │   │   │   │   │   ├── CHANGELOG.md
│   │   │   │   │   │   │   ├── LICENSE
│   │   │   │   │   │   │   ├── README.md
│   │   │   │   │   │   │   └── terraform-provider-azurerm
├── .terraform.lock.hcl
├── main.tf
├── providers.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
└── variables.tf
```

- **.terraform.lock.hcl**: Used to lock the versions of Terraform providers to ensure consistent and reproducible builds.
- **main.tf**: Defines the main infrastructure resources.
- **providers.tf**: Specifies the required providers and their configurations.
- **terraform.tfvars**: Contains variable values. See [Usage](#usage)
- **variables.tf**: Defines the variables used in the project.
- **.gitignore**: Specifies files and directories to be ignored by git.

## Usage

1. **Clone the repository**:
    ```sh
    git clone <repository-url>
    cd <repository-directory>
    ```

2. **Initialize Terraform**:
    ```sh
    terraform init
    ```

3. **Create a `terraform.tfvars` file**:
    ```sh
    touch terraform.tfvars
    ```

    Populate `terraform.tfvars` with the required variables:
    ```hcl
    subscription_id = "<your-subscription-id>"
    tenant_id       = "<your-tenant-id>"
    prefix          = "<resource-prefix>"
    location        = "<resource-location>"
    ```

4. **Plan the infrastructure**:
    ```sh
    terraform plan
    ```

5. **Apply the infrastructure changes**:
    ```sh
    terraform apply
    ```


## Cleanup

To destroy the infrastructure managed by Terraform, run:
```sh
terraform destroy
```

## License
This project is licensed under the Apache 2.0 License. See the [LICENSE](LICENSE) file for details.

