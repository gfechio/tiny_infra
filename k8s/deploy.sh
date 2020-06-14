aws eks --region eu-central-1 update-kubeconfig --name eks
kubectl apply -f rbac-role.yaml
kubectl apply -f alb-ingress-controller.yaml
kubectl apply -f app_namespace.yaml
kubectl apply -f app_deployment.yaml
kubectl apply -f app_services.yaml
kubectl apply -f app_ingress.yaml

echo "Kubernetes autoscaler"
kubectl autoscale deployment tomcat --cpu-percent=50 --min=1 --max=10 -n tomcat
kubectl get hpa

kubectl get pods,svc,deployment,ep,ingress,hpa -n tomcat
