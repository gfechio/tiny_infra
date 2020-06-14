resource "kubernetes_ingress" "tomcat" {
  metadata {
    name = "tomcat"
  }

  spec {
    backend {
      service_name = "tomcat"
      service_port = 8080
    }

    rule {
      http {
        path {
          backend {
            service_name = "tomcat"
            service_port = 8080
          }

          path = "/sample"
        }
      }
    }

    tls {
      secret_name = "tls-secret"
    }
  }
}

resource "kubernetes_pod" "tomcat" {
  metadata {
    name = "tomcat"
    labels = {
      app = "tomcat_backbase"
    }
  }

  spec {
    container {
      image = "438717801519.dkr.ecr.eu-central-1.amazonaws.com/tomcat_backbase:latest"
      name  = "tomcat"

      port {
        container_port = 8080
      }
    }
  }
}

