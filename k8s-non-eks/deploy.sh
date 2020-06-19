echo "Deploy K8S services"
kubectl create namespace ingress
kubectl apply -f app-namespace.yaml
kubectl apply -f app-deployment.yaml
kubectl apply -f app-services.yaml


echo "Kubernetes autoscaler"
kubectl autoscale deployment tomcat --cpu-percent=50 --min=1 --max=10 -n tomcat
kubectl get hpa

kubectl get pods,svc,deployment,ep,ingress,hpa -n tomcat


echo "Alternatively you can use Helm"

function use_helm() {
	helm install metallb stable/metallb --namespace kube-system \
	  --set configInline.address-pools[0].name=default \
	  --set configInline.address-pools[0].protocol=layer2 \
	  --set configInline.address-pools[0].addresses[0]=192.168.0.240-192.168.0.250
	
	kubectl get pods -n kube-system -l app=metallb -o wide
	
	helm install nginx-ingress stable/nginx-ingress --namespace kube-system \
	    --set controller.image.repository=quay.io/kubernetes-ingress-controller/nginx-ingress-controller-arm \
	    --set controller.image.tag=0.25.1 \
	    --set controller.image.runAsUser=33 \
	    --set defaultBackend.enabled=false
}

function use_nginx_lb() { 
	kubectl apply -f default-backend.yaml
	kubectl apply -f ingress-controller-config-map.yaml -n ingress
	kubectl apply -f ingress-controller-roles.yaml -n ingress 
	kubectl apply -f ingress-controller-deployment.yaml -n ingress
	kubectl apply -f nginx-ingress.yaml -n ingress
	kubectl apply -f app-ingress.yaml
}
