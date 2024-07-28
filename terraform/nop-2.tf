# create vpc
resource "aws_vpc" "nopvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name : "nopvpc"
  }
}

# create subnet
resource "aws_subnet" "nopsubnet" {
  vpc_id                  = aws_vpc.nopvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "nopsubnet"
  }
}

# create internet gateway
resource "aws_internet_gateway" "nopgateway" {
  vpc_id = aws_vpc.nopvpc.id
  tags = {
    Name = "nopgateway"
  }
}
# create aws route table
resource "aws_route_table" "noproutetable" {
  vpc_id = aws_vpc.nopvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nopgateway.id
  }
  tags = {
    Name = "noproutetable"
  }
}

# create aws route table association
resource "aws_route_table_association" "noprouteasso" {
  subnet_id      = aws_subnet.nopsubnet.id
  route_table_id = aws_route_table.noproutetable.id
}

# create aws security group
resource "aws_security_group" "nopsecgrp" {
  vpc_id = aws_vpc.nopvpc.id
  ingress {
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH traffic from anywhere 
  }
  ingress {
    to_port     = 5000
    from_port   = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allowe nop traffic from anywhere
  }

  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
  tags = {
    Name = "MySecurityGroup"
  }
}
# create data source for ubuntu 22.04 
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}
# create ec2 instance
resource "aws_instance" "nopserver" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = "mykey"
  subnet_id                   = aws_subnet.nopsubnet.id
  vpc_security_group_ids      = [aws_security_group.nopsecgrp.id]
  associate_public_ip_address = true
  tags = {
    Name = "nopserver"
  }
}
# public ip out
output "nopserver_url" {
  value = "${aws_instance.nopserver.public_ip} ansible_user=ubuntu"
}