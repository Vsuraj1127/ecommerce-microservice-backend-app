provider "aws" {
  region = "ap-south-1"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
}

data "aws_eks_cluster" "cluster" {
  name = "my-k8s-cluster"
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.cluster.name
}

resource "kubernetes_deployment" "user_service" {
  metadata {
    name      = "user-service"
    namespace = "default"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "user-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "user-service"
        }
      }

      spec {
        container {
          name  = "user-service"
          image = "vsuraj1127/user-service:latest"
          ports {
            container_port = 8700
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "order_service" {
  metadata {
    name      = "order-service"
    namespace = "default"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "order-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "order-service"
        }
      }

      spec {
        container {
          name  = "order-service"
          image = "vsuraj1127/order-service:latest"
          ports {
            container_port = 8300
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "payment_service" {
  metadata {
    name      = "payment-service"
    namespace = "default"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "payment-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "payment-service"
        }
      }

      spec {
        container {
          name  = "payment-service"
          image = "vsuraj1127/payment-service:latest"
          ports {
            container_port = 8400
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "user_service" {
  metadata {
    name      = "user-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "user-service"
    }
    port {
      port        = 8700
      target_port = 8700
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_service" "order_service" {
  metadata {
    name      = "order-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "order-service"
    }
    port {
      port        = 8300
      target_port = 8300
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_service" "payment_service" {
  metadata {
    name      = "payment-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "payment-service"
    }
    port {
      port        = 8400
      target_port = 8400
    }
    type = "LoadBalancer"
  }
}
