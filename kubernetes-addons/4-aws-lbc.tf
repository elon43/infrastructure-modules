data "aws_iam_policy_document" "aws_lbc" {
  count = var.enable_loadbalancer_controller ? 1 : 0

  statement {
    effect = "Allow"
    
    principals {
      type = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
  
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]   
  }  
}
resource "aws_iam_role" "aws_lbc" {
  count = var.enable_loadbalancer_controller ? 1 : 0
  
  name = "${var.eks_name}-aws-lbc"
  assume_role_policy = data.aws_iam_policy_document.aws_lbc[0].json
}

resource "aws_iam_policy" "aws_lbc" {
  count = var.enable_loadbalancer_controller ? 1 : 0

  policy = file ("/home/ubuntu/AntonTerragruntTutorial/devel/infrastructure-modules/iam/AWSLoadBalancerController.json")
  name = "${var.eks_name}-aws-lbc"
}

resource "aws_iam_role_policy_attachment" "aws_lbc" {
  role       = aws_iam_role.aws_lbc[0].name
  policy_arn = aws_iam_policy.aws_lbc[0].arn
}

resource "aws_eks_pod_identity_association" "aws_lbc" {
  cluster_name    = var.eks_name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn        = aws_iam_role.aws_lbc[0].arn
}

resource "helm_release" "aws_lbc" {
  count = var.enable_loadbalancer_controller ? 1 : 0

  name       = "aws-lbc"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace = "kube-system"
  version    = var.aws_lbc_helm_version
  
  set {
    name  = "clusterName"
    value = var.eks_name
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  depends_on = [ helm_release.cluster_autoscaler ] 
}
