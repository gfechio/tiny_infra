resource "kubernetes_ingress" "tomcat_ingress" {
  metadata {
    name      = "tomcat-ingress"
    namespace = "tomcat"

    labels = {
      app = "tomcat"
    }

    annotations = {
      "alb.ingress.kubernetes.io/scheme" = "internal"

      "kubernetes.io/ingress.class" = "alb"
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/*"

          backend {
            service_name = "service-tomcat"
            service_port = "8080"
          }
        }
      }
    }
  }
}

