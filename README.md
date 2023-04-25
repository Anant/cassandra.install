# cassandra.install

The purpose of this repository is to:
- Use terraform to create VMs in AWS, Azure or both.
- Use ansible to install Cassandra on the created VMs.

Note:
- This has been tested on Ubuntu 22.

## Pre-requisites

- Terraform
- Ansible
- AWS\Azure account

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
```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

### Configure AWS CLI
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
- Also create your SSH key that will be provided to Azure instances for access:
```
ssh-keygen -t rsa -b 4096
```

# Cassandra Installation

- Download this repository and place it in a directory of your choice.
- In terraform\variables.tf, update the "enable_aws" and ""enable_azure" variables depending on when you want to create your VMs.
- For AWS, provide the subnet in your account where you want to create your VMs.
- Go inside terraform directory and initialize terraform:
```
terraform init
```
- Create your spefied VMs by running the apply command:
```
terraform apply
```
- Once the VMs are created and you have confirmed SSH access to the servers, use ansible to install Cassandra on them.
- Go to the ansible\hosts file and update the IPs of your servers. Verify ansible is able to access all your servers using the below command:
```
ansible all -m ping
```
- Execute the Cassandra pre-requisites and the setup playbooks to configure Cassandra on your servers.
```
ansible-playbook -i ansible/hosts -k ansible/playbooks/cassandra-pre.yml
ansible-playbook -i ansible/hosts -k ansible/playbooks/cassandra-setup.yml
```
- The cluster is now configured and you can start the services.
