output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_ids" {
  value = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)
}