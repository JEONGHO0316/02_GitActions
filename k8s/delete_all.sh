#!/bin/bash

echo "----------------- 1. WEB Ingress 삭제 시작 ---------------"

# 1. Ingress를 먼저 삭제 (ALB 삭제 시작)
# 이 리소스가 다른 서비스와 클래스를 참조하므로 가장 먼저 삭제 요청
kubectl delete -f web-ingress-service.yaml
echo "----------------- 2. Deployment (Pod) 삭제 시작 ----------"

# 2. Deployment를 삭제하여 Pod를 먼저 종료
kubectl delete -f web-deployment.yaml
kubectl delete -f was-deployment.yaml
echo "---------------- 3. Service 삭제 시작 --------------------"

# 3. Pod가 사라진 후 Service를 삭제
kubectl delete -f web-service.yaml
kubectl delete -f was-service.yaml
echo "-------------------- 4. IngressClass 삭제 시작 -----------"

# 4. Ingress가 모두 삭제된 후 (이론상), IngressClass를 삭제
kubectl delete -f ingressclass.yaml
sleep 10
echo "--------------------- 삭제 완료 --------------------------"

# 실시간으로 상태 확인 가능 
watch -n 1 kubectl  get all,ingress -n petclinic
