resource "aws_security_group" "ghost-web" {
  name        = "ghost-web"
  description = "Web access"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow web access"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    description = "Allow all ip and ports outbound"    
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ghost-web"
  }
}

