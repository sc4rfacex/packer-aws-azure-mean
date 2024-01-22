# Packer Ubuntu Images for AWS and Azure with Node.js Hello World App

## Overview

This repository contains Packer configurations to generate custom Ubuntu images for deployment on Amazon Web Services (AWS) and Microsoft Azure. The images are preconfigured with a simple Node.js Hello World application.

## Prerequisites

Before using these Packer configurations, ensure that you have the following prerequisites installed:

- [Packer](https://www.packer.io/downloads)
- [AWS CLI](https://aws.amazon.com/cli/) (for AWS builds)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) (for Azure builds)

## Usage

**Clone this repository:**
   ```bash
   git clone https://github.com/sc4rfacex/packer-aws-azure-mean.git
   cd packer-aws-azure-mean
 ```

 ### Review and customize the Packer configuration files according to your requirements:
- aws-ubuntu-mean.pkr.hcl: Configuration for AWS.
- az-ubuntu-mean.pkr.hcl: Configuration for Azure.
  

### Run Packer to build the images:
```
packer build aws-ubuntu-mean.pkr.hcl
packer build az-ubuntu-mean.pkr.hcl
```

### NodeJS Hello World App
The NodeJS Hello World application is included in the custom images. The source code for the app can be found in the app directory. You can modify this application or replace it with your own Node.js application.

## Directory Structure
- app/: Node.js Hello World application source code.
- packer: 
  - aws-ubuntu-mean.pkr.hcl: Packer configuration for AWS.
  - az-ubuntu-mean.pkr.hcl: Packer configuration for Azure.
- util.sh: Utility script used during image provisioning.
  
### Customization
Feel free to customize the Packer configurations, application code, or any other components to suit your specific needs. For more information on Packer and its capabilities, refer to the Packer Documentation.****