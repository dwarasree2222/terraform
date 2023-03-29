data "aws_subnets" "db" {
  filter {
    name   = "tag:Name"
    values = var.vpc-subnet-info.db_subnets
  }
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
  depends_on = [
    aws_subnet.subnets
  ]

}

resource "aws_security_group" "dbsecg" {
  ingress {
    from_port   = local.mysql_port
    to_port     = local.mysql_port
    protocol    = local.protocol
    cidr_blocks = [var.vpc-subnet-info.vpc_cidr]
  }
  tags = {
    Name = "mysqlsg"

  }
  vpc_id = local.vpc_id
  depends_on = [
    aws_subnet.subnets
  ]
}

resource "aws_db_subnet_group" "dbsubnetg" {
  name       = "dbsubnetg"
  subnet_ids = data.aws_subnets.db.ids
  tags = {
    Name = "My DB subnet group"
  }
  depends_on = [
    aws_subnet.subnets
  ]

}

resource "aws_db_instance" "mysqlref" {
  allocated_storage      = 10
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = "adminadmin"
  vpc_security_group_ids = [aws_security_group.dbsecg.id]
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.dbsubnetg.name
  tags = {
    Name = "mydb-tag"
  }
  depends_on = [
    aws_db_subnet_group.dbsubnetg,
    aws_security_group.dbsecg
  ]
}