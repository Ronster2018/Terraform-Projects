resource "aws_instance" "ubuntu_20_04" {
  ami                         = "ami-0261755bbcb8c4a84"
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = var.default_kp
  instance_type               = var.instance_type_common
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  user_data                   = <<-EOF
		           #! /bin/bash
               sudo apt-get update
		           sudo apt-get install -y apache2
		           sudo systemctl start apache2
		           sudo systemctl enable apache2
		           echo "<h1>Deployed via Terraform from $(hostname -f)</h1>" | sudo tee /var/www/html/index.html
  EOF
  tags = {
    Name = "Ubuntu 20.04 Server"
  }
}

resource "aws_instance" "win2019" {
  ami                         = "ami-065b889ab5c33720e" # Microsoft Windows Server 2019 with Desktop Experience Locale English AMI provided by Amazon
  instance_type               = var.instance_type_common
  key_name                    = var.default_kp
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "Win 2019 Server"
  }
}
