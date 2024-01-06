resource "aws_ssm_parameter" "ssh_private" {
  name   = "/devops-tools/jenkins/id_rsa"
  type   = "SecureString"
  key_id = "alias/aws/ssm"
  value  = file("/home/amin/.ssh/id_rsa")
}

resource "aws_ssm_parameter" "ssh_public" {
  name   = "/devops-tools/jenkins/id_rsa.pub"
  type   = "SecureString"
  key_id = "alias/aws/ssm"
  value  = file("/home/amin/.ssh/id_rsa.pub")

}