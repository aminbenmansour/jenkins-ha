packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  } 
}


variable "ami_id" {
  type    = string
  default = "ami-0735c191cf914754d"
}

variable "efs_mount_point" {
  type    = string
  default = ""
}

locals {
  app_name = "jenkins-controller"
}

source "amazon-ebs" "jenkins" {
  ami_name = "${local.app_name}"

  instance_type = "t2.micro"
  source_ami    = "${var.ami_id}"

  region            = "us-west-2"
  availability_zone = "us-west-2a"

  ssh_username = "ubuntu"

  tags = {
    Env  = "dev"
    Name = "${local.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.jenkins"]

  provisioner "ansible" {
    playbook_file   = "ansible/jenkins-controller.yml"
    extra_arguments = ["--extra-vars", "ami-id=${var.ami_id} efs_mount_point=${var.efs_mount_point}", "--scp-extra-args", "'-O'", "--ssh-extra-args", "-o IdentitiesOnly=yes -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa"]
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}