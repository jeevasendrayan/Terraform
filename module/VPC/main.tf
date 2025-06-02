# Provider details
provider "aws" {
    region = var.region
}


# VPC Range
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "${var.project_name}_vpc"
    }
}

#Public Subnet 1

resource "aws_subnet" "public_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[0]
    availability_zone = var.availability_zones[0]
    map_public_ip_on_launch = true
    tags = {
        Name = "public_subnet1_${var.project_name}"
    }

}

#Public subnet 2

resource "aws_subnet" "public_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[1]
    availability_zone = var.availability_zones[1]
    map_public_ip_on_launch = true
    tags = {
        Name = "public_subnet2_${var.project_name}"
    }

}

#Private Subnet 1

resource "aws_subnet" "private_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[0]
    availability_zone = var.availability_zones[2]
    tags = {
        Name = "private_subnet1_jeeva"
    }
}

#Private Subnet 2

resource "aws_subnet" "private_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[1]
    availability_zone = var.availability_zones[3]
    tags = {
        Name = "private_subnet2_jeeva"
    }
}


# Internet Gateway

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "hackathon-igw"
    }


}

# Nat Gateway

resource "aws_eip" "nat" {
    vpc = true
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public_1.id
    tags = {
        Name = "nat-gateway-jeeva"
    }

}


#Public Route table
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public-rt-jeeva"
    }
}

# Private route table


resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = "privte-rt-jeeva"

    }
}


#Route Table Associate Public

resource "aws_route_table_association" "public_1" {
    subnet_id = aws_subnet.public_1.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
    subnet_id = aws_subnet.public_2.id
    route_table_id = aws_route_table.public.id
}

#Route Table Associate Private
resource "aws_route_table_association" "private_1" {
    subnet_id = aws_subnet.private_1.id
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
    subnet_id = aws_subnet.private_2.id
    route_table_id = aws_route_table.private.id
}
