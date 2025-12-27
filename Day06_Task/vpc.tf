# Virtual Private Cloud (VPC)
resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = merge(local.common_tags, {
        Name = local.vpc_name
    })
}

# Internet Gateway
resource "aws_internet_gateway" "main_igw" {
    vpc_id = aws_vpc.main_vpc.id

    tags = merge(local.common_tags, {
        Name = "${local.name_prifix}-igw"
    })
}

resource "aws_subnet" "public_subnets" {
    count = length((var.availability_zones))

    vpc_id            = aws_vpc.main_vpc.id
    cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true

    tags = merge(local.common_tags, {
        Name = "${local.name_prifix}-public-subnet-${count.index + 1}"
        Type = "Public"
    })
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_igw.id
    }

    tags = merge(local.common_tags, {
        Name = "${local.name_prifix}-public-rt"
    })
  
}

resource "aws_route_table_association" "public_rt_association" {
    count = length(var.availability_zones)

    subnet_id      = aws_subnet.public_subnets[count.index].id
    route_table_id = aws_route_table.public_rt.id
}