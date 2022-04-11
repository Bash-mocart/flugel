module "eks" {
  source   = "../eks"
}

resource "null_resource" "cluster_deployment" {

  provisioner "local-exec" {
    # Bootstrap script called with private_ip of each node in the clutser
    working_dir = "./ansible"
    command = "ansible-playbook deploy-microservices.yml --extra-vars='ACCOUNT_ID=$ACCOUNT_ID CLUSTER_NAME=$CLUSTER_NAME'"
    environment = {
      ACCOUNT_ID = var.account_id
      CLUSTER_NAME = module.eks.eks_name
    }
  }
  
  }