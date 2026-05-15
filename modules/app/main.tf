resource "kubernetes_deployment" "hello_world" {
  metadata {
    name = "hello-world"
    labels = { app = "hello-world" }
  }

  spec {
    replicas = 2

    selector {
      match_labels = { app = "hello-world" }
    }

    template {
      metadata { labels = { app = "hello-world" } }

      spec {
        container {
          image = "nginx:alpine"
          name  = "nginx"
          port { container_port = 80 }
        }
      }
    }
  }
}

resource "kubernetes_service" "hello_world" {
  metadata { name = "hello-world" }

  spec {
    selector = { app = "hello-world" }
    port { port = 80; target_port = 80 }
    type = "ClusterIP"
  }
}
