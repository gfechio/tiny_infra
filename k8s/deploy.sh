echo "Prepare environment"
sed -i -e "s/ACCOUNT_ID/$account_id/g" app_deployment.yaml
NEW_VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:Name, Values=backbase-assignment" | jq .Vpcs[0].VpcId)
sed -i "s/NEW-VPC-ID/$NEW_VPC_ID/" alb-ingress-controller.yaml
sed -i "s/REGION/$region/" alb-ingress-controller.yaml
aws eks --region $region update-kubeconfig --name eks

echo "Deploy K8S services"
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
