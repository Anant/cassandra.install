# install-cassandra

The purpose of this repository is to:
- Use terraform to create VMs in AWS, Azure or GCP
- Use ansible to install Cassandra on the created VMs

Note:
- Cassandra install has been tested on Ubuntu 22

## Pre-requisites

- Terraform
- Ansible
- Any of the below:
-- AWS account
-- Azure account
-- GCP account

### Install Terraform

- Install Terraform.
- Ensure that your system is up to date and you have installed the gnupg, software-properties-common, and curl packages installed.
```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```
- Install the HashiCorp GPG key.
```
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
```
- Verify the key's fingerprint.
```
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```
- Add the official HashiCorp repository to your system.
```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```
- Install Terraform from the new repository.
```
sudo apt update
sudo apt-get install terraform
```
- Verify Installation
```
terraform -help
```

### Install Ansible

- Install Ansible on the same host as Terraform.
- 

### Configure AWS CLI

- You will have to install AWS CLI on your Terraform\Ansible host.
- Check if you have Python3 installed on the server:
```
python3 --version
```
- Install pip:
```
sudo apt install python3-pip
```
- Install AWS CLI:
```
sudo apt install awscli
```
- After installing the AWS CLI, you'll need to configure it with your AWS access keys and default region. You can do this by running the following command:
```
aws configure
```

### Configure Azure CLI
- Get packages needed for the install process:
```
sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
```
- Download and install the Microsoft signing key:
```
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
```
- Add the Azure CLI software repository:
```
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list
```
- Update repository information and install the azure-cli package:
```
sudo apt-get update
sudo apt-get install azure-cli
```
- Login to your Azure account:
```
az login
```

# Start

- Download this repository and place it in a directory of your choice.
- Go inside terraform directory and initialize terraform:
```
terraform init
```