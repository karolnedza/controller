resource "aws_vpc" "avtx_ctrl_vpc" {
  cidr_block       = var.cidr

  tags = {
    Name = "shared-aws"
  }
}

resource "aws_internet_gateway" "gw" {
#  count = (var.vpc == "new" ? 1 : 0)
  vpc_id = aws_vpc.avtx_ctrl_vpc.id
}

resource "aws_subnet" "avtx_ctrl_subnet" {
  availability_zone = "eu-central-1a"
  vpc_id     = aws_vpc.avtx_ctrl_vpc.id
  cidr_block = var.cidr

  tags = {
    Name = "shared-aws"
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = "${aws_vpc.avtx_ctrl_vpc.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

resource "aws_key_pair" "avtx_ctrl_key" {
  key_name   = "avtx-ctrl-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBi5Pg8eGmsNOjiktdPMOxoflTaZ43A0DzZl+0l9ezGv5UJDbbZLFoQrJKuTwnc9KZRTaO6LIClU8A6fiKMid+6cn8X5+g052WP1uK7jQ9kdxnqtxQyywbZY9d7cW4tzU9bM1N3W8B59YB240aEQVFLyjgVzebUmTqIVmqLDYMEiGIgpIPFgOCUn6yM64v+yb4+dSvrB2zzjhVdTPB+RV9c6aL9GTsZftQPJ6m0TUKS9+vU9PQoY84xY3lz6wggDUU9Sx/JosQnHPf0C1oKl77a3BvV+8pdEqpkBGRUK7j/YPMX20uTw41DmwzIlwNHeOvLVGhRmX5WL9M91EClR3J9PiQxyBN3DkzbePrfm4qRUnPd5/5U4QfLghB8o4OhpFegAucYz0dBOpQcHmXPnY9A4zTDyFGX8ikBDjWmqlVLHIlSqRuXZst+C2VrHZORVZQeDNrDb2FbqoVgSrNHRJCVXuIiGDCYacJ6AExegQnaliqwjYStAz6YKbKjHQ1zxs= controller.public"
}
