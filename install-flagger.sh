#!/bin/bash

set -e

# 1. Flagger Helm 레포지토리 확인 및 추가
echo "Checking Flagger Helm repository..."

if helm repo list | grep -q "^flagger"; then
  echo "Flagger repo already exists. Skipping add."
else
  echo "Adding Flagger Helm repository..."
  helm repo add flagger https://flagger.app
fi

# repo update는 항상 수행
echo "Updating Helm repositories..."
helm repo update

# 2. Flagger 네임스페이스 생성
echo "Creating flagger namespace..."
kubectl create ns flagger --dry-run=client -o yaml | kubectl apply -f -

# 3. Flagger 설치
echo "Installing Flagger via Helm..."

helm upgrade -i flagger flagger/flagger \
  --namespace flagger \
  --set metricsServer=http://prometheus.istio-system:9090 \
  --set meshProvider=istio \
  --set controlLoopInterval=15s

echo "Flagger installation completed!"

kubectl get pods -n flagger
