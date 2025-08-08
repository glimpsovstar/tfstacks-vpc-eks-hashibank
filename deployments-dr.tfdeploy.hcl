identity_token "aws" {
  audience = ["terraform-stacks-private-preview"]
}


identity_token "k8s" {
  audience = ["aws.workload.identity"]
}


deployment "DR" {
  inputs = {
    aws_identity_token = identity_token.aws.jwt
    role_arn            = "arn:aws:iam::521614675974:role/tfstacks-role"
    regions             = ["ap-southeast-1"]
    vpc_name = "vpc-djoo-DR1"
    vpc_cidr = "10.0.0.0/16"

    #EKS Cluster
    kubernetes_version = "1.33"
    cluster_name = "eks-djoo-DR01"
    
    #EKS OIDC
    tfc_kubernetes_audience = "aws.workload.identity"
    tfc_hostname = "https://app.terraform.io"
    tfc_organization_name = "djoo-hashicorp"
    eks_clusteradmin_arn = "arn:aws:iam::521614675974:role/aws_david.joo_test-developer"
    eks_clusteradmin_username = "aws_djoo_test-developer"

    #K8S
    k8s_identity_token = identity_token.k8s.jwt
    namespace = "hashibank"

  }
}