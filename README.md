# EKS 인프라 구축 및 GitOps 기반 환경 설계 프로젝트

AWS EKS 기반 인프라를 Terraform으로 구축하고, ArgoCD 기반 GitOps로 Addon과 애플리케이션을 배포하며, KEDA+Karpenter를 활용하여 SQS 큐 기반 오토스케일링을 검증한 프로젝트입니다.

## Repository Structure
```text
.
├── terraform                      # Terraform EKS/VPC Module 및 환경별 분리
│   ├── modules
│   │   ├── eks
│   │   └── vpc
│   └── envs
│       ├── global
│       ├── dev
│       │   ├── eks
│       │   ├── vpc
│       │   ├── apps
│       │   └── acm
│       └── prod
│
├── gitops                         # ArgoCD Application CRD 기반 단계별 배포 구조
│   ├── charts
│   └── envs
│       ├── dev
│       │   ├── root-application       # 1단계: Bootstrap 진입점
│       │   ├── primary-application    # 2단계: 핵심 Controller/CRD Addon
│       │   ├── secondary-application  # 3단계: CRD 의존 Custom Resource
│       │   ├── manifests-application  # 4단계: Custom Resource 의존 Addon
│       │   └── service-application    # 5단계: 서비스 Application
│       └── prod
│
├── helm-values                    # 환경별 Helm values 구성
│   ├── dev
│   └── prod
│
├── init-manifests                 # 운영 전 클러스터에 필요한 CRD 및 manifests
│   ├── dev
│   └── prod
│
└── eks-demo                       # 스프링부트 데모 앱
```
## Architecture (Single NAT Gateway)
![alt text](docs/images/eks.png)

## GitOps Structure
![alt text](docs/images/gitops.png)