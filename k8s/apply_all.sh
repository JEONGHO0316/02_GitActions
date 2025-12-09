echo "--- 3. WAS (백엔드) 배포 ---"
kubectl apply -f was-deployment.yaml
kubectl apply -f was-service.yaml

echo "--- 4. WEB (프론트엔드) 배포 ---"
kubectl apply -f web-deployment.yaml
kubectl apply -f web-service.yaml

echo "--- 5. IngressClass & Ingress (로드밸런서) 배포 ---"
# Ingress는 서비스가 다 있는 상태에서 만드는 게 좋습니다.
kubectl apply -f ingressclass.yaml
kubectl apply -f web-ingress-service.yaml

echo "-------------------- 배포 완료 및 상태 확인 ---------------------"
sleep 2
watch -n 1 kubectl get all,ingress -n petclinic
