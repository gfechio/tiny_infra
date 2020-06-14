kubectl create -f tomcat-deployment.yaml 
kubectl create nginx-ingress.yaml 
kubectl create -f tomcat-service.yaml

kubectl create namespace ingress
kubectl create -f default-backend-service.yaml -n ingress
kubectl create -f nginx-ingress-controller-config-map.yaml -n ingress
kubectl create -f nginx-ingress-controller-deployment.yaml -n ingress
kubectl create -f nginx-ingress-controller-roles.yaml -n ingress
kubectl create -f nginx-ingress.yaml 

kubectl create -f tomcat-ingress.yaml 
