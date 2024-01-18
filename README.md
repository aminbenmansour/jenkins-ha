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
> [!WARNING]
> Some hard-coded values need to be changed manually such as AMI IDs

## IV. System design
The diagram below shows how we designed the tools and services above to work together and achieve our goal.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/aminbenmansour/jenkins-ha/assets/50111205/01c6d7fd-71ab-4030-81c6-dd0f1b080fdb">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/aminbenmansour/jenkins-ha/assets/50111205/5b67b8c7-25a9-49b0-9927-3404c5d681db">
  <img alt="System design of Jenkins HA cluster on AWS" src="https://github.com/aminbenmansour/jenkins-ha/assets/50111205/01c6d7fd-71ab-4030-81c6-dd0f1b080fdb">
</picture>

> [!CAUTION]
> The diagram above is NOT too accurate (on purpose)! It defines all the possibilities that we might encounter.

> [!IMPORTANT]
> Give attention to the note attached to the system design diagram.

> [!NOTE]
> In this project, we also introduced the concept of immutable infrastructure by creating a new AMI containing upgrades and updating the `ami_id` attribute in Terraform when needed. See [differences and trade-offs between mutable and immutable infrastructure](https://www.hashicorp.com/resources/what-is-mutable-vs-immutable-infrastructure).

> [!TIP]
> It is recommended to keep secrets and configurations external. Thanks to AWS SSM we can always rotate our keypair without downtime.

## V. Roadmap
We need to keep this project as close as possible to be production-ready. Here are a few things to keep in mind regarding a real-world comparison.

Everyone can track upcoming features [here](https://github.com/users/aminbenmansour/projects/1) and contributions are more than welcome :)

### Real-world setup
1. Private network, DNS and TLS
2. Jenkins access through a VPN/VDI connection
3. Jenkins user authentication will be based on LDAP / SSO (Eg. Okta)
### Real-world implementation
* **VPC**: 3 public subnets and 3 private subnets
* **Client to Site VPN**
* **ASG in Private Subnet**:
* **EFS in Private Subnet**: Inbound access only from Private Subnets CIDR.
* **Load Balancer with TLS**: TLS configured in Load Balancer
* **CloudWatch Monitoring and Logging**: Both for AWS Resources and Jenkins.
* **EFS Backup**: AWS Backup Service / EFS to EFS Backup.
## VI. License
