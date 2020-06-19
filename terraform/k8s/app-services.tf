resource "kubernetes_service" "service_tomcat" {
  metadata {
    name      = "service-tomcat"
    namespace = "tomcat"
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = "8080"
    }

    selector = {
      app = "tomcat"
    }

    type = "LoadBalancer"
  }
}

