resource "aws_security_group" "alb_sg" {
  name_prefix = "alb-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-alb-sg"
  }
}

resource "aws_lb" "jenkins" {
  name               = "jenkins-alb"
  internal           = false
  load_balancer_type = "application"

  subnets         = var.subnets
  security_groups = [aws_security_group.alb_sg.id]

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

