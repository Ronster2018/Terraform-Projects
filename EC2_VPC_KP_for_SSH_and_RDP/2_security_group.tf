resource "aws_security_group" "security_group" {
  name        = "allow_ssh_rdp"
  description = "Security Group that allows SSH and RDP into the VPCs resources"
  vpc_id      = aws_vpc.develop_vpc.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #RDP
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Ping
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  #Egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols are allowed.
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow SSH, RDP, HTTP, PING"
  }
}
