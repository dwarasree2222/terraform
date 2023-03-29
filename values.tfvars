vpc-subnet-info = {
  subnet-azs         = ["a", "b", "a", "b", "a", "b"]
  app-name           = ["db1", "db2", "app1", "app2", "web1", "web2"]
  cidr-block-subnets = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24", "192.168.4.0/24", "192.168.5.0/24"]
  vpc_cidr           = "192.168.0.0/16"
  region             = "us-east-1"
  public_subnets     = ["web1", "web2"]
  private_subnets    = ["db1", "db2", "app1", "app2"]
  db_subnets         = ["db1", "db2"]
  web_ec2_subnet     = "web1"

}