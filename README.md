# config-service

# Spring Boot Config Management App – Complete Guide

## Features

- Health check: `GET /ping` → `"pong"`
- Config management:
  - `GET /configs/:id` → fetch configs
  - `POST /configs` → insert/update configs
- Uses PostgreSQL for storage
- Can run locally or inside Minikube

---

## Prerequisites

- Docker  
- Minikube  
- Terraform  
- kubectl  

---

## Provision PostgreSQL in Minikube via Terraform

- cd terraform
- terraform init
- terraform plan
- terraform apply

---

## Build App

- Docker build -t config-service .

---

## Minikube Setup

- chmod +x setup-minikube.sh
- ./setup-minikube.sh
- minikube status


## Deploy Spring Boot App on Minikube Via Jenkins

- minikube start --driver=docker
- cd k8s
- kubectl apply -f configmap.yaml
- kubectl apply -f secret.yaml
- kubectl apply -f deployment.yaml

<img width="1277" height="296" alt="image" src="https://github.com/user-attachments/assets/54524ecd-f7bb-4544-a942-c2ed7f4a3774" />



