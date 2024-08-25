resource "aws_vpc" "vpc" {
  cidr_block = var.ntt-vpc

  tags = {
    Name = "ntt-vpc"
  }
}
resource "aws_subnet" "subnet" {
  count             = length(var.ntt-subnets)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.ntt-subnets[count.index]
  availability_zone = "${var.region}${var.ntt-subnets-az[count.index]}"

  tags = {
    Name = var.subnet-tags[count.index]
  }
}
