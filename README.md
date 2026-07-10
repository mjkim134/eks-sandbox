# AWS EKS & GitOps 인프라 프로비저닝

이 레포지토리는 EKS 클러스터 구축(Terraform) 및 배포를 위한 프로젝트 소스코드입니다.

- `/.github/workflows`: GitHub Actions 기반 CI 파이프라인 (이미지 빌드 및 ECR 푸시)
- `/eks-demo`: EKS 테스트용 Spring Boot 애플리케이션
- `/gitops`: ArgoCD 'App of Apps' 패턴을 활용한 클러스터 부트스트래핑
- `/helm-values`: 클러스터 내부 애드온과 app 헬름 values
- `/init-manifests`: 클러스터 전역 인프라 매니페스트 (StorageClass, NodePool, ClusterSecretStore 등)
- `/terraform`: Terraform 기반 인프라 프로비저닝 (VPC, EKS, IRSA, Addons, ECR)