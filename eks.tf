resource "aws_eks_cluster" "eks_cluster" {
  name = "${var.name}-cluster"
  role_arn = aws_iam_role.global_role.arn
  version = "1.31"

  vpc_config {
    subnet_ids = [for subnet in aws_subnet.eks_subnet : subnet.id]
  }
    depends_on = [
      aws_iam_role.global_role
    ]
  tags = {
    Name = "clustertype"
    Environment = var.env
  }
}