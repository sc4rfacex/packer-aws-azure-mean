packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

// Define the source configuration for creating an Azure ARM image using Ubuntu
source "azure-arm" "ubuntu" {
  // Define Azure tags for the image
  azure_tags = {
    dept = "Engineering"
    task = "Image deployment"z
  }

  // Azure authentication credentials
  client_id     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  client_secret = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

  // Image details
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_publisher = "canonical"
  image_sku       = "22_04-lts"

  // Azure region
  location = "East US"

  // Managed image details
  managed_image_name                = "azPackerMeanImage"
  managed_image_resource_group_name = "rg-for-packer"

  // Operating system type
  os_type = "Linux"

  // Azure subscription and tenant IDs
  subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  tenant_id       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

  // Virtual machine size
  vm_size = "Standard_DS2_v2"
}

// Build configuration
build {
  // Use the defined source for building the image
  sources = ["source.azure-arm.ubuntu"]

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
    inline = [
      "ls -l ~/",
      "cd ~/",
      "chmod +x util.sh",
      "./util.sh"
    ]
  }
}
