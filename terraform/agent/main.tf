provider "aws" {
  region = "us-west-2"
}

module "ec2_instance" {
  source = "../modules/ec2"

  instance_name      = "jenkins-agent"
  ami_id             = "ami-0e68ab34763bcba1f" # Jenkins Agent AMI ID built with Packer
  instance_type      = "t2.micro"
  key_name           = "mykeypair"
  subnet_ids         = ["subnet-058a7514ba8adbb07", "subnet-0dbcd1ac168414927", "subnet-032f5077729435858"]
  instance_count     = 1
}