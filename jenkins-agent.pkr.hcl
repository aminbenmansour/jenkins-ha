packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}


variable "ami_id" {
  type    = string
  default = "ami-0735c191cf914754d"
}

variable "public_key_path" {
  type    = string
  default = "/devops-tools/jenkins/id_rsa.pub"
}

locals {
  app_name = "jenkins-agent"
}

source "amazon-ebs" "jenkins" {
  ami_name = "${local.app_name}"

  instance_type = "t2.micro"
  source_ami    = "${var.ami_id}"

  region            = "us-west-2"
  availability_zone = "us-west-2a"

  ssh_username         = "ubuntu"
  iam_instance_profile = "jenkins-instance-profile"

  tags = {
    Env  = "dev"
    Name = "${local.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.jenkins"]

  provisioner "ansible" {
    playbook_file   = "ansible/jenkins-agent.yml"
    extra_arguments = ["--extra-vars", "public_key_path=${var.public_key_path}", "--scp-extra-args", "'-O'", "--ssh-extra-args", "-o IdentitiesOnly=yes -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa"]
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}