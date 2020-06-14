helm repo add haproxytech https://haproxytech.github.io/helm-charts
helm repo update
helm search repo haproxy
helm install mycontroller haproxytech/kubernetes-ingress
kubectl --namespace default get nodes -o jsonpath="{.items[0].status.addresses[1].address}"
helm repo update
