resource "aws_vpc" "vpc" {
  cidr_block = var.ntt-vpc-info.ntt-vpc-cidr

  tags = {
    Name = "ntt-vpc"
  }
}
resource "aws_subnet" "subnet" {
  count             = length(var.ntt-vpc-info.subnet-names)
  cidr_block        = cidrsubnet(var.ntt-vpc-info.ntt-vpc-cidr, 8, count.index)
  availability_zone = "${var.region}${var.ntt-vpc-info.ntt-subnet-az[count.index]}"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    Name = var.ntt-vpc-info.subnet-names[count.index]
  }
}
