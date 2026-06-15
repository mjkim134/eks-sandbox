# AWS EKS & GitOps 인프라 프로비저닝

이 레포지토리는 EKS 클러스터 구축(Terraform) 및 배포를 위한 실습 보관 레포입니다.

- `/terraform`: Terraform 기반 인프라 프로비저닝 (VPC, EKS, IRSA, Addons, ECR)
- `/helm`: 클러스터 내부 애드온(ALB Controller, external-dns, karpenter, ArgoCD, prometheus stack) 헬름 차트
- `/.github/workflows`: GitHub Actions 기반 CI 파이프라인 (이미지 빌드 및 ECR 푸시)
- `/eks-demo`: EKS 테스트용 Spring Boot 애플리케이션 (ALB 라우팅 및 파드 동작 검증)