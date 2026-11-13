
output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.my_ec2.id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = aws_instance.my_ec2.public_ip
}

output "ami_id" {
  description = "Ubuntu AMI ID"
  value       = data.aws_ami.ubuntu.id
}
