# EKS + Istio 실습

이 페이지는 EKS와 Istio를 활용해 `bookinfo.yaml` 예제를 배포하고,
Istio의 트래픽 관리와 서비스 메시 동작을 학습해보는 실습용 자료입니다.

## 실습 순서
1. `create-eks.sh`를 바탕으로 EKS 클러스터 생성
2. `istioctl x precheck` 를 통해 클러스터 준비 상태 점검
3. `istioctl install --set profile=demo -y` 를 통해 Istio 컨트롤 플레인 설치
4. `kubectl label namespace default istio-injection=enabled` 를 통해 사이드카가 파드 생성 시 자동으로 붙도록 설정 추가(현재 default)
5. `kubectl apply -f istio-1.29.2/samples/bookinfo/platform/kube/bookinfo.yaml` 을 바탕으로 Bookinfo 샘플 앱 배포(이후 `kubectl get pods` 로 파드들이 READY 2/2인지 확인)
6. `kubectl apply -f istio-1.29.2/samples/bookinfo/networking/bookinfo-gateway.yaml` 을 바탕으로 EKS 외부에서 서비스에 접속할 수 있도록 입구를 열어줌(`kubectl get svc istio-ingressgateway -n istio-system` 을 통해 접속 주소 확인)

## 스크립트

- `create-eks.sh`
  - `eksctl`을 사용해 EKS 클러스터를 생성합니다.
  - 기본 변수:
    - `CLUSTER_NAME`: 생성할 클러스터 이름
    - `REGION`: AWS 리전
    - `NODE_TYPE`: 노드 인스턴스 타입
    - `NODE_COUNT`: 노드 개수
  - 생성 완료 시 `kubectl get nodes`로 노드 상태를 확인합니다.

- `cleanup-eks.sh`
  - `eksctl`을 사용해 생성한 EKS 클러스터를 삭제합니다.
  - 기본 변수:
    - `CLUSTER_NAME`: 삭제할 클러스터 이름
    - `REGION`: AWS 리전

## 사전 준비

- AWS 자격 증명 설정 완료 (`aws configure` 또는 IAM Role)
- `eksctl`, `kubectl`, `aws` CLI 설치
