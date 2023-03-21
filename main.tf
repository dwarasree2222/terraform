resource "aws_vpc" "my-vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "actual-vpc-name"
  }


}

resource "aws_subnet" "subnet1" {
  cidr_block = var.cidr-block-subnet1
  tags = {
    Name = "actual-subnet1"
  }
  vpc_id = aws_vpc.my-vpc.id #implicit dependency 
  depends_on = [
    aws_vpc.my-vpc
  ]

}
resource "aws_subnet" "subnet2" {
  cidr_block = var.cidr-block-subnet2
  tags = {
    Name = "actual-subnet2"
  }
  vpc_id = aws_vpc.my-vpc.id #implicit dependency 
  depends_on = [
    aws_vpc.my-vpc
  ]

}
resource "aws_subnet" "subnet3" {
  cidr_block = var.cidr-block-subnet3
  tags = {
    Name = "actual-subnet3"
  }
  vpc_id = aws_vpc.my-vpc.id #implicit dependency 
  depends_on = [
    aws_vpc.my-vpc
  ]

}