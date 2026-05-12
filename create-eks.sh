#!/bin/bash

# 변수 설정
CLUSTER_NAME="istio-lab"
REGION="ap-northeast-2"
NODE_TYPE="t3.medium"
NODE_COUNT=2

echo "----------------------------------------------------"
echo "작업 시작: EKS 클러스터 생성을 시작합니다."
echo "클러스터 이름: $CLUSTER_NAME"
echo "인스턴스 타입: $NODE_TYPE ($NODE_COUNT nodes)"
echo "대기 시간: 약 15~20분이 소요됩니다."
echo "----------------------------------------------------"

# EKS 클러스터 생성 실행
eksctl create cluster \
  --name $CLUSTER_NAME \
  --region $REGION \
  --nodegroup-name istio-nodes \
  --node-type $NODE_TYPE \
  --nodes $NODE_COUNT \
  --managed

# 생성 완료 후 노드 상태 확인
if [ $? -eq 0 ]; then
    echo "----------------------------------------------------"
    echo "성공: EKS 클러스터 생성이 완료되었습니다."
    kubectl get nodes
    echo "----------------------------------------------------"
else
    echo "오류: 클러스터 생성 중 문제가 발생했습니다."
fi
