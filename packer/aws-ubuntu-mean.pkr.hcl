/*
  This Packer configuration file is used to create an Amazon Machine Image (AMI) for an Ubuntu-based MEAN stack application.
  It utilizes the "amazon-ebs" builder to create the AMI in the specified region and instance type.
  The source AMI is filtered based on the Ubuntu version and other criteria.
  The build process includes provisioning files and executing shell commands.
*/

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

// Define the source configuration for creating an Amazon EBS image using Ubuntu
source "amazon-ebs" "ubuntu" {
  ami_name      = "mean-packer-ubuntu-aws"
  region        = "us-east-1"
  instance_type = "t2.micro"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }

  ssh_username = "ubuntu"
}

// Build configuration
build {
  name = "ami-mean-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  // Copy utility script and application files to the image
  provisioner "file" {
    source      = "../util.sh"
    destination = "~/"
  }

  provisioner "file" {
    source      = "../app"
    destination = "~/"
  }

  // Execute shell commands on the image
  provisioner "shell" {
    environment_vars = [

    ]
    inline = [
      "ls -l ~/",
      "cd ~/",
      "chmod +x util.sh",
      "./util.sh"
    ]
  }
}
