resource "aws_security_group" "private" {
  name        = "Allow form lan-to-lan"
  description = "${var.env_name}-lan"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.my_vpc.id

  tags = merge(
    {
      "Name" = format("%v-private-security-group", var.env_name)
    },
  )
}

resource "aws_security_group" "public" {
  name        = "Allow from  public"
  description = "${var.env_name}-public"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["2.55.150.40/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["2.55.150.40/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.my_vpc.id

  tags = merge(
    {
      "Name" = format("%v-public-security-group", var.env_name)
    },
  )
}

output "public_security_groups" {
  value = aws_security_group.public.id
}

output "private_security_groups" {
  value = aws_security_group.private.id
}
