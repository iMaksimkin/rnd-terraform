provider "aws" {
}


resource "aws_instance" "ubuntu" {
  count         = 3
  ami           = "ami-0093cac2bf998a669"
  instance_type = "t3.micro"
  tags = {
    Name  = "RnD example"
    Owner = "Elijah Maksimkin"
  }
}
