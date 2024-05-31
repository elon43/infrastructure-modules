variable "env" {
  description = "Environment name"
  type = string
}

variable "eks_version" {
  description = "Desired Kubernetes master version"
  type = string
}

variable "eks_name" {
  description = "Name of the cluster"
  type = string
}


variable "subnet_ids" {
  description = "List of subnet IDs.  Must be in atleast two different availability zones"
  type = list(string)
}

variable "node_iam_policies" {
  description = "List of IAM Policies to attach to EKS-managed nodes"
  type = map(any)
  default = {
    1 = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  }
}

variable "node_groups" {
  description = "EKS node groups"
  type = map(any)
}

variable "enable_irsa" {
  description = "Determines whether to create an OpenID Connect Provider to EKS"
  type = bool
  default = true
}