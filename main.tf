terraform {
  required_version = "= 0.12.19"
}

# NOTE: change the region in which resources will be created
provider "aws" {
  region = "ap-northeast-1"
}

##################################Logic Function Belows##############################################

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_security_group" "allow_all_traffics" {
  name        = "allow_all_traffic"
  description = "Allow all inbound traffic"

  ingress {
    description = "All traffics from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  for_each = {for vm in var.vms:  vm.ami => vm}
  ami           = each.value.ami
  instance_type = each.value.instance_type
  availability_zone = data.aws_availability_zones.available.names[0]
  key_name      = var.key_name
  security_groups = [aws_security_group.allow_all_traffics.name]
  user_data = each.value.user_data
}

resource "aws_ebs_volume" "example" {
  for_each = {for vm in var.vms:  vm.ami => vm}
  availability_zone = data.aws_availability_zones.available.names[0]
  size              = var.size_in_GB
}

resource "aws_volume_attachment" "ebs_att" {
  for_each = {for vm in var.vms:  vm.ami => vm}
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example[each.key].id
  instance_id = aws_instance.web[each.key].id
}