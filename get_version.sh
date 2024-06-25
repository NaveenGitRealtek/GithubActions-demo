#!/bin/bash

# Define the version tag
VERSION="V0.0.13"

# Build Docker image
docker build -t my-go-app:$VERSION .

# Tag Docker image
docker tag my-go-app:$VERSION ***/*/my-go-app:$VERSION

# Push Docker image
docker push ***/*/my-go-app:$VERSION

