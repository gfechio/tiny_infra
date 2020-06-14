resource "kubernetes_deployment" "tomcat" {
  metadata {
    name      = "tomcat"
    namespace = "tomcat"
  }

  spec {
    replicas = 4

    selector {
      match_labels = {
        app = "tomcat"
      }
    }

    template {
      metadata {
        labels = {
          app = "tomcat"
        }
      }

      spec {
        container {
          name  = "tomcat"
          image = "ACCOUNT_ID.dkr.ecr.eu-central-1.amazonaws.com/tomcat_backbase:latest"

          port {
            container_port = 8080
          }

          image_pull_policy = "Always"
        }
      }
    }

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_surge = "1"
      }
    }
  }
}

