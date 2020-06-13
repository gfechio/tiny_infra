#!/bin/bash
source .aws_export.env

aws eks --region $REGION update-kubeconfig --name eks-backbase
kubectl apply -f tomcat-deploy.yaml
kubectl apply -f tomcat-ingress.yaml
kubectl apply -f docker-builder-cron.yaml
kubectl apply -f init-docker-builder-cron.yaml



