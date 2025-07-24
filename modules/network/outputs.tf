output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [aws_subnet.public_subnet.id]
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat_gateway[0].id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}