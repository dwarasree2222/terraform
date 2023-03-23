resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "actual-vpc-name"
  }


}

resource "aws_subnet" "subnet1" {
  #count             = length(var.vpc-subnet-info.app-name)
  count             = length(var.vpc-subnet-info.cidr-block-subnet1)
  cidr_block        = cidrsubnet(var.vpc-subnet-info.vpc_cidr, 8, count.index)
  availability_zone = "${var.region}${var.vpc-subnet-info.subnet-azs[count.index]}"

  tags = {
    Name = var.vpc-subnet-info.app-name[count.index]
  }
  vpc_id = aws_vpc.my-vpc.id #implicit dependency 
  depends_on = [
    aws_vpc.my-vpc
  ]

}

/*resource "aws_subnet" "subnet2" {
  cidr_block        = var.cidr-block-subnet2
  availability_zone = "${var.region}b"
  tags = {
    Name = "actual-subnet2"
  }
  vpc_id = aws_vpc.my-vpc.id #implicit dependency 
  depends_on = [
    aws_vpc.my-vpc
  ]

}
resource "aws_subnet" "subnet3" {
  cidr_block        = var.cidr-block-subnet3
  availability_zone = "${var.region}c"
  tags = {
    Name = "actual-subnet3"
  }
  vpc_id = aws_vpc.my-vpc.id #implicit dependency 
  depends_on = [
    aws_vpc.my-vpc
  ]

}*/
