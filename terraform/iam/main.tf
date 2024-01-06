provider "aws" {
  region = "us-west-2"
}

module "jenkins_iam" {
  source                = "../modules/iam"
  instance_profile_name = "jenkins-profile-name"
  iam_policy_name       = "jenkins-policy-name"
  role_name             = "jenkins-role"
}