resource "kubernetes_deployment" "tomcat" {
  metadata {
    name = "tomcat"
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
          image = "tomcat-backbase"
          name  = "k8s_assignment/tomcat-backbase"

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
