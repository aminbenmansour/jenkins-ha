# Jenkins HA
### Jenkins Highly Available (HA) cluster setup on AWS using Autoscaling Group (ASG) and Application Load Balancer (ALB) through ***Packer***, ***Ansible***, and ***Terraform***

## I. Introduction

## II. Tools
### Third party prerequisites
* **Terraform**: Provisioning AWS resources.
* **Packer**: Building Jenkins controller and agent AMIs (Amazon Machine Images).
* **Ansible**: Configuring both Jenkins controller and agent during the AMI build process.
* **AWS CLI**: Interacting with AWS Services through terminal.
### AWS services
* **IAM Roles**: Grant permissions to Jenkins controller and agent instances.
* **EFS Filesystem**: Persist Jenkins data (backup data when EC2 instance is recreated).
* **AWS Parameter Store**: Store SSH keypair.
* **Autoscaling Group (ASG)**: Recreate the Jenkins controller instance whenever terminated.
* **Application Load Balancer (ALB)**: Routes to the Jenkins controller instance deployed in a random AZ.

## III. Setup
>You need to follow the following steps

i. Generate SSH keys
```bash
ssh-keygen  
```
ii. upload ssh keypair
```bash
cd terraform/ssm ; terraform init && terraform apply -auto-approve
``` 

iii. Build AWS AMIs
```bash
$ make jenkins-agent
$ make jenkins-controller efs_id=<efs-filesystem-id> region=<aws-region>
```
iv. Provision resources accordingly through terraform modules

> ⚠️ Caveat: Some hard-coded values need to change manually such as AMI ids

## IV. Diagrams

## V. Roadmap

## VI. License
