#This associates the subnets to the route tables
resource "aws_route_table_association" "rt_mypublicsubnet_1a" {
  subnet_id      = aws_subnet.mypublicsubnet_1a.id
  route_table_id = aws_route_table.mypubrt.id
}

resource "aws_route_table_association" "rt_mypublicsubnet_1b" {
  subnet_id      = aws_subnet.mypublicsubnet_1b.id
  route_table_id = aws_route_table.mypubrt.id
}

resource "aws_route_table_association" "rt_myprivatesubnet_1a" {
  subnet_id      = aws_subnet.myprivatesubnet_1a.id
  route_table_id = aws_route_table.myprvrt.id
}

resource "aws_route_table_association" "rt_myprivatesubnet_1b" {
  subnet_id      = aws_subnet.myprivatesubnet_1b.id
  route_table_id = aws_route_table.myprvrt.id
}
