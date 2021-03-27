resource "kubernetes_namespace" "n" {
  metadata {
    name = "demo-events-feed"
  }
}