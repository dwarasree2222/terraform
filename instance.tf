resource "aws_security_group" "ec2secg" {
  ingress {
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    protocol    = local.protocol
    cidr_blocks = [local.anywhere]
  }
  ingress {
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.protocol
    cidr_blocks = [local.anywhere]
  }
  tags = {
    Name = "ec2sg"

  }
  vpc_id = local.vpc_id
  depends_on = [
    aws_subnet.subnets
  ]
}

data "aws_ami_ids" "ubuntu_2204" {
  owners = ["099720109477"]
  filter {
    name   = "description"
    values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-02-08"]
  }
  filter {
    name   = "is-public"
    values = ["true"]
  }

}

data "aws_subnet" "web" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = [var.vpc-subnet-info.web_ec2_subnet]
  }

  depends_on = [
    aws_subnet.subnets
  ]
}
resource "aws_instance" "web" {
  ami                         = local.ami_id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.web.id
  vpc_security_group_ids      = [aws_security_group.ec2secg.id]
  tags = {
    Name = "web1"
  }


  depends_on = [
    aws_db_instance.mysqlref,
    aws_security_group.ec2secg
  ]

}


