# AWS EKS & GitOps 인프라 프로비저닝

이 레포지토리는 엔터프라이즈 환경을 가정한 EKS 클러스터 구축(Terraform) 및 배포(GitOps)를 위한 코드 보관소입니다.

- `/terraform`: Terraform 기반 인프라 프로비저닝 (VPC, EKS, IRSA, Addons 등)
- `/helm`: 클러스터 내부 애드온(ALB Controller, ArgoCD 등) 매니페스트 및 차트