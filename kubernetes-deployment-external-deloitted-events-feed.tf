resource "kubernetes_deployment" "demo-external-events-feed-deployment" {
  metadata {
    name = "demo-external-events-feed-deployment"
    labels = {
      App = "demo-external-events-feed"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 1
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "demo-external-events-feed"
      }
    }
    template {
      metadata {
        labels = {
          App = "demo-external-events-feed"
        }
      }
      spec {
        container {
          image = "gcr.io/deloitte-demo-308622/external-image:v2.1"
          name  = "demo-external-events-feed"

          env {
            name = "SERVER"
            value = "http://events-internal-service:8082"
          }

          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests = {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}