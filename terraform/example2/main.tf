provider "aws" {
  region = "eu-central-1"
}


resource "aws_instance" "my_webserver" {
  ami                    = "ami-03a71cec707bfc3d7"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Ilya",
    l_name = "Maksimkin",
    names  = ["Pasha", "Yura", "Masha", "Sasha", "Vlad", "Misha", "Nastya"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Elijah Maksimkin"
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"

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
    Name  = "Web Server SecurityGroup"
    Owner = "Elijah Maksimkin"
  }
}

output "ec2_ip" {
  value = aws_instance.my_webserver.public_ip
}
