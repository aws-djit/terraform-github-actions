
# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Get default security group
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

# Find latest Ubuntu 24.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create EC2 instance
resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id = data.aws_subnets.default.ids[0]

  vpc_security_group_ids = [
    data.aws_security_group.default.id
  ]

  associate_public_ip_address = true

  tags = {
    Name        = "GitHub-Actions-EC2"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}
