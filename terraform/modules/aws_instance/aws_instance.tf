resource "aws_instance" "cassandra" {
  count         = var.instances
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet

  tags = {
    Name = "cassandra-${count.index}"
  }
}