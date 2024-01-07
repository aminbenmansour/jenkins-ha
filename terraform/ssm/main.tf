provider "aws" {
  region = "us-west-2"
}

module "jenkins_ssm" {
  source            = "../modules/ssm"
  ssh_key_file_path = "~/.ssh/id_rsa"
}