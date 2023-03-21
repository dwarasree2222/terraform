resource "aws_vpc" "my-vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "actual-vpc-name"
  }


}

resource "aws_subnet" "subnet1" {
  #count             = 3
  count             = length(var.cidr-block-subnet1)
  cidr_block        = var.cidr-block-subnet1[count.index]
  availability_zone = "${var.region}${var.subnet-azs[count.index]}"

  tags = {
    Name = var.app-name[count.index]
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
