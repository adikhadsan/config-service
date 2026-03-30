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

## ConfigDB Setup

This setup creates a configdb database and a configs table using a Kubernetes pod provisioned via Terraform.

 Table Schema
    The configs table includes:
      id (Primary Key, auto-increment)
      host
      port
      app_name
      log_level
      
CREATE DATABASE configdb;
USE configdb;
CREATE TABLE configs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    host VARCHAR(255),
    port INT,
    app_name VARCHAR(255),
    log_level VARCHAR(50)
);

Usage
Create a pod using Terraform
Execute SQL inside the pod:kubectl exec -it <pod-name> -- mysql -u <user> -p<password> -e "<SQL_COMMANDS>"
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



