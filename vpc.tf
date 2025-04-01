# VPC creation #
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.name}-vpc"
  }
}

# subnet creation #
resource "aws_subnet" "eks_subnet" {
  vpc_id = aws_vpc.eks_vpc.id
  count = length(var.subnet_cidr)
  availability_zone = element(var.zone, count.index)
  cidr_block = element(var.subnet_cidr, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-subnet-${count.index + 1}"
  }
}
# internet gateway #
resource "aws_internet_gateway" "eks_gw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "${var.name}-igw"
  }
}
# route table creation #
resource "aws_route_table" "eks_rt" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = var.default
    gateway_id = aws_internet_gateway.eks_gw.id
  }
  tags = {
    Name = "${var.name}-rt"
  }
}

# Route table association #
resource "aws_route_table_association" "eks_subnet1-asso" {
  count = length(var.subnet_cidr)
  subnet_id      = aws_subnet.eks_subnet[count.index].id
  route_table_id = aws_route_table.eks_rt.id

}