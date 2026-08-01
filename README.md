# EKS 기반 클라우드 인프라 구축 및 GitOps 운영 기반 환경 설계

Terraform, Helm, ArgoCD 기반으로 확장 가능한 AWS EKS 운영 환경을 설계하고 구축한 개인 프로젝트입니다.

IaC 기반 인프라 프로비저닝부터 GitOps 배포 자동화, Kubernetes 운영 환경 구성, Event Driven Autoscaling 및 Observability 환경까지 Kubernetes 기반 운영 플랫폼 구축 과정을 검증했습니다.

SQS Queue 기반 이벤트 처리 환경을 가정하여 KEDA 기반 Pod Autoscaling과 Karpenter 기반 Node Provisioning 구조를 구현하고, Locust 부하 테스트와 Prometheus/Grafana를 활용하여 Scale-out 과정을 검증했습니다.


## Architecture
![alt text](docs/images/eks.png)

## GitOps Structure
![alt text](docs/images/gitops.png)

## Repository Structure
```text
.
├── .github
│   └── workflows
│       └── ci.yaml
│
├── terraform
│   ├── modules
│   └── environments
│
├── gitops
│   ├── bootstrap
│   ├── applications
│   └── addons
│
├── helm-values
│   ├── argocd
│   ├── karpenter
│   └── monitoring
│
├── init-manifests
│   ├── storageclass
│   ├── nodepool
│   └── secrets
│
└── eks-demo
    └── spring-boot-app