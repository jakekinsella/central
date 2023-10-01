terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.13"
    }
  }

  required_version = ">= 1.1.8"
}

provider "aws" {
  region  = "us-east-1"
}

variable "node_token" {
  type = string
}

data "aws_ami" "common_ami" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["common-ubuntu-*"]
  }
}

data "aws_key_pair" "reader" {
  key_name = "reader"
}

data "aws_iam_policy" "ecr_access" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

data "aws_iam_instance_profile" "node" {
  name = "reader_node"
}

data "aws_security_group" "control_plane" {
  name = "reader_control_plane"
}

resource "aws_launch_template" "node" {
  name = "central_node"
  image_id = data.aws_ami.common_ami.id
  instance_type = "t4g.small"

  network_interfaces {
    associate_public_ip_address = true
    security_groups = ["${data.aws_security_group.control_plane.id}"]
  }

  key_name = data.aws_key_pair.reader.key_name

  iam_instance_profile {
    name = data.aws_iam_instance_profile.node.name
  }

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 8
    }
  }

  user_data                   = base64encode(<<-EOL
  #!/bin/bash
  
  cat /home/ubuntu/install.sh | sh -s - agent --token "${var.node_token}" --server https://cluster.jakekinsella.com:6443 --node-label node=1

  sleep 60
  cd /home/ubuntu && ./ecr_refresh.sh

  echo "Central Node setup complete"
  EOL
  )
}

resource "aws_autoscaling_group" "node" {
  name = "reader_node"
  max_size = 1
  min_size = 0
  availability_zones = ["us-east-1a"]
  
  launch_template {
    id      = aws_launch_template.node.id
    version = "$Latest"
  }
}
