resource "aws_iam_policy" "jenkins_iam_policy" {
  name = var.iam_policy_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParameterByPath"
        ]
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "jenkins_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "jenkins_role_policy_attachment" {
  name       = "Policy Attachement"
  policy_arn = aws_iam_policy.jenkins_iam_policy.arn
  roles      = [aws_iam_role.jenkins_role.name]
}

resource "aws_iam_instance_profile" "jenkins_instance_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.jenkins_role.name
}