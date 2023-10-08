module "eks" {
  source  = "./modules/eks"
  depends_on = [ module.vpc ]
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

#these are mandatory for all clusters so no need to paramterize
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnets
  #control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  #Self Managed Node Group(s)
#   self_managed_node_group_defaults = {
#    instance_type                          = "t3.large"
#    update_launch_template_default_version = true
#    iam_role_additional_policies = {
#      AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#    }
#   }

#  self_managed_node_groups = {
#    one = {
#      name         = "mixed-1"
#      desired_size = 1

#      use_mixed_instances_policy = true
#       mixed_instances_policy = {
#        instances_distribution = {
#          on_demand_base_capacity                  = 0
#          on_demand_percentage_above_base_capacity = 10
#          spot_allocation_strategy                 = "capacity-optimized"
#        }

#        override = [
#          {
#            instance_type     = "t3.large"
#            weighted_capacity = "1"
#          },
#          {
#            instance_type     = "t3.large"
#            weighted_capacity = "2"
  #        },
  #      ]
  #    }
  #  }
  # }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    #blue = {}
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
    }
  }

  # Fargate Profile(s)
  #fargate_profiles = {
   # default = {
   #   name = "default"
    #  selectors = [
   #     {
     #     namespace = "default"
     #   }
     # ]
    #}
  #}

  # aws-auth configmap
  #manage_aws_auth_configmap = true

 # aws_auth_roles = [
   # {
  #    rolearn  = "arn:aws:iam::66666666666:role/role1"
   #   username = "role1"
   #   groups   = ["system:masters"]
   # },
  #]

  #aws_auth_users = [
   # {
   #   userarn  = "arn:aws:iam::66666666666:user/user1"
     # username = "user1"
    #  groups   = ["system:masters"]
   # },
   # {
 #     userarn  = "arn:aws:iam::66666666666:user/user2"
  #    username = "user2"
   #   groups   = ["system:masters"]
   # },
  #]

  #aws_auth_accounts = [
  #  "777777777777",
  #  "888888888888",
  #]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}