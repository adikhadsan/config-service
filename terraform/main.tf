# -------------------------
# main.tf
# -------------------------
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.18.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"  # Ensure this points to your Minikube kubeconfig
}

# -------------------------
# PostgreSQL Deployment
# -------------------------
resource "kubernetes_deployment" "postgres" {
  metadata {
    name = "postgres"
    labels = {
      app = "postgres"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "postgres"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgres"
        }
      }

      spec {
        container {
          name  = "postgres"
          image = "postgres:15"

          env {
            name  = "POSTGRES_USER"
            value = "admin"
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = "admin"
          }

          env {
            name  = "POSTGRES_DB"
            value = "configdb"
          }

          port {
            container_port = 5432
          }

          # Listen on all interfaces (already default in postgres:15)
        }
      }
    }
  }
}

# -------------------------
# PostgreSQL Service
# -------------------------
resource "kubernetes_service" "postgres" {
  metadata {
    name = "postgres"
  }

  spec {
    selector = {
      app = kubernetes_deployment.postgres.metadata[0].labels.app
    }

    port {
      port        = 5432
      target_port = 5432
      protocol    = "TCP"
    }

    type = "ClusterIP"
  }
}
