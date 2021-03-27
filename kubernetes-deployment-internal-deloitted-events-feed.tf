resource "kubernetes_deployment" "demo-internal-events-feed-deployment" {
  metadata {
    name = "demo-internal-events-feed-deployment"
    labels = {
      App = "demo-internal-events-feed"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 1
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "demo-internal-events-feed"
      }
    }
    template {
      metadata {
        labels = {
          App = "demo-internal-events-feed"
        }
      }
      spec {
        container {
          image = "gcr.io/deloitte-demo-308622/internal-image:v2.1"
          name  = "demo-internal-events-feed"

          port {
            container_port = 8082
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