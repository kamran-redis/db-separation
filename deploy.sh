#!/bin/bash
kubectl create namespace  operator
kubectl create namespace  application

kubectl apply -f bundle.yaml  -n operator
kubectl apply -f role.yaml -n application
kubectl apply -f role_binding.yaml -n application
kubectl apply -f svc-rec-application.yaml  -n operator
kubectl apply -f rec.yaml -n application

kubectl apply -f db.yaml -n application

