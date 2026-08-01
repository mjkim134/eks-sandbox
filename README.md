# EKS 기반 클라우드 인프라 구축 및 GitOps 운영 기반 환경 설계

Terraform, Helm, ArgoCD 기반으로 확장 가능한 AWS EKS 운영 환경을 설계하고 구축한 개인 프로젝트입니다.

IaC 기반 인프라 프로비저닝부터 GitOps 배포 자동화, Kubernetes 운영 환경 구성, Event Driven Autoscaling 및 Observability 환경까지 Kubernetes 기반 운영 플랫폼 구축 과정을 검증했습니다.

SQS Queue 기반 이벤트 처리 환경을 가정하여 KEDA 기반 Pod Autoscaling과 Karpenter 기반 Node Provisioning 구조를 구현하고, Locust 부하 테스트와 Prometheus/Grafana를 활용하여 Scale-out 과정을 검증했습니다.

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

## Architecture
![alt text](docs/images/eks.png)

## GitOps Structure
![alt text](docs/images/gitops.png)