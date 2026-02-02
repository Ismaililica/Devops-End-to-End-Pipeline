resource "aws_instance" "demo-server" {

  instance_type          = "t3.micro"
  ami                    = "ami-01fd6fa49060e89a6"
  key_name               = "dpp"
  subnet_id              = aws_subnet.devops-project-public-subnet-01.id
  vpc_security_group_ids = [aws_security_group.ssh-sg.id]

  for_each = toset(["Build-slave", "Ansible"])
  tags = {
    Name = "${each.key}"
  }

}

resource "aws_instance" "jenkins-master" {

  instance_type          = "t3.medium"
  ami                    = "ami-01fd6fa49060e89a6"
  key_name               = "dpp"
  subnet_id              = aws_subnet.devops-project-public-subnet-01.id
  vpc_security_group_ids = [aws_security_group.ssh-sg.id]

  tags = {

    Name = "Jenkins-Master"

  }

}






resource "aws_security_group" "ssh-sg" {

  vpc_id = aws_vpc.devops-project-vpc.id

  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]



  }

  ingress {

    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {

    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    Name = "ssh-sg"
  }

}

resource "aws_vpc" "devops-project-vpc" {

  cidr_block = "10.1.0.0/16"

  tags = {

    Name = "devops-project-vpc"
  }


}

resource "aws_subnet" "devops-project-public-subnet-01" {

  vpc_id                  = aws_vpc.devops-project-vpc.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1a"

  tags = {
    Name = "devops-project-public-subnet"
  }

}

resource "aws_subnet" "devops-project-public-subnet-02" {
  vpc_id                  = aws_vpc.devops-project-vpc.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = true

  tags = {

    Name = "devops-project-public-subnet-02"
  }

}

resource "aws_internet_gateway" "devops-project-igw" {
  vpc_id = aws_vpc.devops-project-vpc.id

  tags = {
    Name = "devops-project-igw"
  }

}

resource "aws_route_table" "devops-project-route-table" {

  vpc_id = aws_vpc.devops-project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops-project-igw.id
  }

  tags = {

    Name = "devops_project-route-table"
  }

}

resource "aws_route_table_association" "devops-project-rtasc-01" {

  route_table_id = aws_route_table.devops-project-route-table.id
  subnet_id      = aws_subnet.devops-project-public-subnet-01.id

}

resource "aws_route_table_association" "devops-project-rtasc-02" {
  subnet_id      = aws_subnet.devops-project-public-subnet-02.id
  route_table_id = aws_route_table.devops-project-route-table.id

}