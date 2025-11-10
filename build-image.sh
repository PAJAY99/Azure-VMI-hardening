#!/bin/bash

# Configuration
RESOURCE_GROUP="AzureAMI"
GALLERY_NAME="Ubuntu_AMI"
IMAGE_DEFINITION="golden-ubuntu-image"
PUBLISHER="Canonical"
OFFER="UbuntuServer"
SKU="22_04-lts-gen2"
OS_TYPE="Linux"
IMAGE_VERSION="1.0.0"

# Check if image definition exists
echo "Checking if image definition '$IMAGE_DEFINITION' exists in gallery '$GALLERY_NAME'..."

az sig image-definition show \
  --resource-group "$RESOURCE_GROUP" \
  --gallery-name "$GALLERY_NAME" \
  --gallery-image-definition "$IMAGE_DEFINITION" &> /dev/null

if [ $? -ne 0 ]; then
  echo "Image definition not found. Creating it..."
  az sig image-definition create \
    --resource-group "$RESOURCE_GROUP" \
    --gallery-name "$GALLERY_NAME" \
    --gallery-image-definition "$IMAGE_DEFINITION" \
    --publisher "$PUBLISHER" \
    --offer "$OFFER" \
    --sku "$SKU" \
    --os-type "$OS_TYPE"
else
  echo "Image definition already exists."
fi