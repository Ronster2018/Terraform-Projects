output "ubuntu_instance_public_ip" {
  value = aws_instance.ubuntu_20_04.public_ip
}

output "windows_instance_public_ip" {
  value = aws_instance.win2019.public_ip
}
