#!/bin/sh

#Start with installing Nvidia drivers on our nodes
#Ref: https://www.linode.com/docs/guides/ai-chatbot-and-rag-pipeline-for-inference-on-lke/
#Ref: https://docs.ori.co/kubernetes/examples/llama405B-run/

#TO DO: Exception handling
helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
helm repo update
helm install --wait --generate-name -n gpu-operator --create-namespace nvidia/gpu-operator --version=v24.9.1

#Create the namespace.
kubectl apply -f ./k8s/base/ollama-namespace.yaml

#Because best practices to create a configmap file. ;)
#TO DO: Fix the params, make it useful.
kubectl apply -f ./k8s/base/entrypoint-configmap.yaml

#Deploy Ollama pods
kubectl apply -f ./k8s/base/ollama-deployment.yaml

#Expose the aollama service
kubectl apply -f ./k8s/base/ollama-service.yaml

#Deploy OpenWebUI
kubectl apply -f ./k8s/base/openwebui-deployment.yaml

#Expose the OpenWebUI service
kubectl apply -f ./k8s/base/openwebui-service.yaml
