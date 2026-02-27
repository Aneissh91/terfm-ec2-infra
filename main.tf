resource "aws_instance" "public" {
  ami                         = "ami-0ac0e4288aa341886"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-05cd8a01d22a5ccaf"
  associate_public_ip_address = true
  key_name                    = "ane-key-pair"
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "ane-ec2"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "ane-terraform-security-group"
  description = "Allow SSH inbound"
  vpc_id      = "vpc-024ab25ff63a3d405"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

