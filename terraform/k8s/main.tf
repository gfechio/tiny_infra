
module "tomcat-deployment" {
}

module "tomcat-ingress" {

}

resource "null_resource" "build_docker_image" {
  provisioner "local-exec" {
    command = "cd "
  }
}