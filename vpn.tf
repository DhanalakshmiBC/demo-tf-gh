

resource "aws_vpc" "demo_vpn" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "demo-vpc"
    }
}

resource "aws_subnet" "main_subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.demo_vpn.id
    availability_zone = "us-west2a"
    tags = {
        Name = "main-subnet"
    }
}
resource "aws_internet_gateway" "demo_gateway" {
    vpc_id = aws_vpc.demo_vpn.id
    tags = {
        Name = "demo-gateway"
    }

}

resource "aws_route_table" "main_route_table" {
    vpc_id = aws_vpc.demo_vpn.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo_gateway.id
    }
    tags = {
        Name = "main-route-table"
    }
}

resource "aws_route_table_association" "main_association" {
    subnet_id = aws_subnet.main_subnet.id
    route_table_id = aws_route_table.main_route_table.id
}

resource "aws_security_group" "demo_sg" {
    vpc_id = aws_vpc.demo_vpn.id
    name = "allow-ssh"
    description = "Allow SSH access"
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "demo-security-group"
    }
}


