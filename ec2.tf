resource "aws_instance" "example" {
  ami           = "ami-05ee755be0cd7555c" # Replace with a valid AMI ID for us-west-2
  instance_type = "t2.micro"
  security_groups = [aws_security_group.demo_sg.id]
  subnet_id= aws_subnet.main_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "demo-instance"
  }
}

