resource "aws_ssm_parameter" "ssh_private" {
  name   = "/devops-tools/jenkins/id_rsa"
  type   = "SecureString"
  key_id = "alias/aws/ssm"
  value  = file("${var.ssh_key_file_path}")
}

resource "aws_ssm_parameter" "ssh_public" {
  name   = "/devops-tools/jenkins/id_rsa.pub"
  type   = "SecureString"
  key_id = "alias/aws/ssm"
  value  = file("${var.ssh_key_file_path}.pub")

}