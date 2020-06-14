resource "kubernetes_deployment" "tomcat_123" {
  metadata {
    name = "tomcat"
      labels = {
        test = "tomcat"
      }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "tomcat"
      }
    }

    template {
      metadata {
        labels = {
          test = "tomcat"
        }
      }

      spec {
        container {
          image = "438717801519.dkr.ecr.eu-central-1.amazonaws.com/tomcat_backbase:latest"
          name  = "tomcat_backbase"

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/sample"
              port = 8080
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
          readiness_probe {
            http_get {
              path = "/sample"
              port = 8080
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
