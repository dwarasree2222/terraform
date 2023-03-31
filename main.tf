resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc-subnet-info.vpc_cidr
  tags = {
    Name = "actual-vpc-name"
  }


}

resource "aws_subnet" "subnets" {
  #count             = length(var.vpc-subnet-info.app-name)
  count             = length(var.vpc-subnet-info.cidr-block-subnets)
  cidr_block        = cidrsubnet(var.vpc-subnet-info.vpc_cidr, 8, count.index)
  availability_zone = "${var.vpc-subnet-info.region}${var.vpc-subnet-info.subnet-azs[count.index]}"

  tags = {
    Name = var.vpc-subnet-info.app-name[count.index]
  }
  #vpc_id = aws_vpc.my-vpc.id #implicit dependency 
  vpc_id = local.vpc_id
  depends_on = [
    aws_vpc.my-vpc
  ]

}

resource "aws_internet_gateway" "igref" {
  vpc_id = local.vpc_id
  depends_on = [
    aws_vpc.my-vpc
  ]
  tags = {
    Name = "ig-gw"
  }
}


resource "aws_route_table" "public" {
  vpc_id = local.vpc_id
  depends_on = [
    aws_vpc.my-vpc
  ]
  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.igref.id
  }
  tags = {
    Name = "public"
  }

}

resource "aws_route_table" "private" {
  vpc_id = local.vpc_id
  depends_on = [
    aws_vpc.my-vpc
  ]

  tags = {
    Name = "private"
  }

}
data "aws_subnets" "publicdataref" {
  filter {
    name   = "tag:Name"
    values = var.vpc-subnet-info.public_subnets
  }
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
  depends_on = [
    aws_subnet.subnets
  ]
}
data "aws_subnets" "privatedataref" {
  filter {
    name   = "tag:Name"
    values = var.vpc-subnet-info.private_subnets
  }
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
  depends_on = [
    aws_subnet.subnets
  ]
}
resource "aws_route_table_association" "publicassrttableref" {
  count          = length(data.aws_subnets.publicdataref.ids)
  route_table_id = aws_route_table.public.id
  subnet_id      = data.aws_subnets.publicdataref.ids[count.index]
  depends_on = [
    data.aws_subnets.publicdataref
  ]



}
resource "aws_route_table_association" "privateassrttableref" {
  count          = length(data.aws_subnets.privatedataref.ids)
  route_table_id = aws_route_table.private.id
  subnet_id      = data.aws_subnets.privatedataref.ids[count.index]
  depends_on = [
    data.aws_subnets.privatedataref
  ]


}

