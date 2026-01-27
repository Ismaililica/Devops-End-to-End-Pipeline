resource "aws_instance" "demo-server" {

  instance_type   = "t3.micro"
  ami             = "ami-04233b5aecce09244"
  key_name        = "dpp"
  subnet_id       = "subnet-05540b2a592348cfc"
  security_groups = ["ssh-sg"]


  tags = {
    Name = "EC2-V1"
  }

}
resource "aws_security_group" "ssh-sg" {

  ingress {

    from_port   = 22
    to_port     = 22
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
    Name = "ssh-sg"
  }

}