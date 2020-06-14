#!/bin/bash
source .aws_export.env

aws eks --region eu-central-1 update-kubeconfig --name eks
kubectl apply -f tomcat-deploy.yaml
kubectl apply -f tomcat-ingress.yaml
kubectl apply -f docker-builder-cron.yaml
kubectl apply -f init-docker-builder-cron.yaml


kubectl apply -f app1.yaml
kubectl apply -f svc-app1.yaml
kubectl get deploy
kubectl get services
kubectl get ep
kubectl create namespace ingress
kubectl get deployments.
kubectl get deployments. -n ingress
kubectl get service
kubectl get service -n ingress
kubectl get ep -n ingress

kubectl apply -f nginx-ingress-controller-config-map.yaml -n ingress
kubectl describe configmaps nginx-ingress-controller-conf -n ingress
kubectl get configmaps -n ingress

