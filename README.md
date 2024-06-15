# FastAPI App with Azure Kubernetes Service and Istio

This project demonstrates how to create a simple FastAPI application, package it in a Docker container, deploy it to Azure Kubernetes Service (AKS), and manage traffic using Istio.

## Prerequisites

- Docker
- Azure CLI
- kubectl
- istioctl
- python-dotenv

## Setup Instructions

### Step 1: Build and Run FastAPI Application Locally

1. Create a virtual environment and install dependencies:

    ```sh
    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt
    ```

2. Run the application locally:

    ```sh
    uvicorn app.main:app --host 0.0.0.0 --port 8000
    ```

### Step 2: Build Docker Image

1. Build the Docker image:

    ```sh
    docker build -t myapp:v1 .
    ```

2. Tag the Docker image:

    ```sh
    docker tag myapp:v1 myContainerRegistry.azurecr.io/myapp:v1
    ```

3. Log in to Azure Container Registry (ACR):

    ```sh
    az acr login --name myContainerRegistry
    ```

4. Push the Docker image to ACR:

    ```sh
    docker push myContainerRegistry.azurecr.io/myapp:v1
    ```

### Step 3: Create Azure Resources

1. Create a resource group:

    ```sh
    az group create --name myResourceGroup --location eastus
    ```

2. Create an Azure Container Registry (ACR):

    ```sh
    az acr create --resource-group myResourceGroup --name myContainerRegistry --sku Basic
    ```

3. Create an Azure Kubernetes Service (AKS) cluster:

    ```sh
    az aks create --resource-group myResourceGroup --name myAKSCluster --node-count 1 --enable-addons monitoring --generate-ssh-keys
    ```

4. Connect to the AKS cluster:

    ```sh
    az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
    ```

### Step 4: Deploy to AKS

1. Apply Kubernetes deployment and service files:

    ```sh
    kubectl apply -f deployment-v1.yaml
    kubectl apply -f deployment-v2.yaml
    kubectl apply -f service.yaml
    ```

### Step 5: Configure Istio

1. Install Istio following the [official installation guide](https://istio.io/latest/docs/setup/getting-started/).

2. Apply Istio destination rule and virtual service:

    ```sh
    kubectl apply -f destination-rule.yaml
    kubectl apply -f virtual-service.yaml
    ```

### Step 6: Access the Application

1. Find the external IP of the Istio ingress gateway:

    ```sh
    kubectl get svc -n istio-system
    ```

2. Access the FastAPI application at `http://<EXTERNAL-IP>/hello`.

## Conclusion

You have successfully deployed a FastAPI application to Azure Kubernetes Service with traffic management using Istio.
