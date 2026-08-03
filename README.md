# EKS 기반 클라우드 인프라 구축 및 GitOps 운영 기반 환경 설계

Terraform 기반으로 Dev/Prod 환경을 고려한 AWS EKS 인프라를 구성하고,
ArgoCD GitOps 기반 배포 구조와 KEDA/Karpenter를 활용한 자동 확장 환경을 검증한 프로젝트입니다.

## Repository Structure
```text
.
├── .github
│   └── workflows
│       └── ci-pipeline.yml    # GitHub Actions CI 구성
│
├── docs
│   └── images
│
├── terraform                  # Terraform EKS/VPC Module 및 환경별 분리
│   ├── modules
│   │   ├── eks
│   │   └── vpc
│   └── envs
│       ├── dev
│       └── prod
│
├── gitops                     # Application CRD를 활용해 단계별 Apply 수행을 위한 디렉토리 구조
│   ├── charts
│   └── envs
│       ├── dev
│       └── prod
│
├── helm-values                # 환경별 Helm values 구성
│   ├── dev
│   └── prod
│
├── init-manifests             # 운영 전 클러스터에 필요한 CRD 및 manifests
│   ├── dev
│   └── prod
│
└── eks-demo                   # 스프링부트 데모 앱
```
## Architecture
![alt text](docs/images/eks.png)

## GitOps Structure
![alt text](docs/images/gitops.png)