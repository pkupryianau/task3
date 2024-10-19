locals {
  bastion_autoscaling_group_ids        = [aws_autoscaling_group.bastions-k8s-cluster-prkpo-com.id]
  bastion_security_group_ids           = [aws_security_group.bastion-k8s-cluster-prkpo-com.id]
  bastions_role_arn                    = aws_iam_role.bastions-k8s-cluster-prkpo-com.arn
  bastions_role_name                   = aws_iam_role.bastions-k8s-cluster-prkpo-com.name
  cluster_name                         = "k8s-cluster.prkpo.com"
  master_autoscaling_group_ids         = [aws_autoscaling_group.control-plane-eu-central-1a-masters-k8s-cluster-prkpo-com.id]
  master_security_group_ids            = [aws_security_group.masters-k8s-cluster-prkpo-com.id]
  masters_role_arn                     = aws_iam_role.masters-k8s-cluster-prkpo-com.arn
  masters_role_name                    = aws_iam_role.masters-k8s-cluster-prkpo-com.name
  node_autoscaling_group_ids           = [aws_autoscaling_group.nodes-eu-central-1a-k8s-cluster-prkpo-com.id]
  node_security_group_ids              = [aws_security_group.nodes-k8s-cluster-prkpo-com.id]
  node_subnet_ids                      = [aws_subnet.eu-central-1a-k8s-cluster-prkpo-com.id]
  nodes_role_arn                       = aws_iam_role.nodes-k8s-cluster-prkpo-com.arn
  nodes_role_name                      = aws_iam_role.nodes-k8s-cluster-prkpo-com.name
  region                               = "eu-central-1"
  route_table_private-eu-central-1a_id = aws_route_table.private-eu-central-1a-k8s-cluster-prkpo-com.id
  route_table_public_id                = aws_route_table.k8s-cluster-prkpo-com.id
  subnet_eu-central-1a_id              = aws_subnet.eu-central-1a-k8s-cluster-prkpo-com.id
  subnet_utility-eu-central-1a_id      = aws_subnet.utility-eu-central-1a-k8s-cluster-prkpo-com.id
  vpc_cidr_block                       = aws_vpc.k8s-cluster-prkpo-com.cidr_block
  vpc_id                               = aws_vpc.k8s-cluster-prkpo-com.id
  vpc_ipv6_cidr_block                  = aws_vpc.k8s-cluster-prkpo-com.ipv6_cidr_block
  vpc_ipv6_cidr_length                 = local.vpc_ipv6_cidr_block == "" ? null : tonumber(regex(".*/(\\d+)", local.vpc_ipv6_cidr_block)[0])
}

output "bastion_autoscaling_group_ids" {
  value = [aws_autoscaling_group.bastions-k8s-cluster-prkpo-com.id]
}

output "bastion_security_group_ids" {
  value = [aws_security_group.bastion-k8s-cluster-prkpo-com.id]
}

output "bastions_role_arn" {
  value = aws_iam_role.bastions-k8s-cluster-prkpo-com.arn
}

output "bastions_role_name" {
  value = aws_iam_role.bastions-k8s-cluster-prkpo-com.name
}

output "cluster_name" {
  value = "k8s-cluster.prkpo.com"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.control-plane-eu-central-1a-masters-k8s-cluster-prkpo-com.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-k8s-cluster-prkpo-com.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-k8s-cluster-prkpo-com.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-k8s-cluster-prkpo-com.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-eu-central-1a-k8s-cluster-prkpo-com.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-k8s-cluster-prkpo-com.id]
}

output "node_subnet_ids" {
  value = [aws_subnet.eu-central-1a-k8s-cluster-prkpo-com.id]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-k8s-cluster-prkpo-com.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-k8s-cluster-prkpo-com.name
}

output "region" {
  value = "eu-central-1"
}

output "route_table_private-eu-central-1a_id" {
  value = aws_route_table.private-eu-central-1a-k8s-cluster-prkpo-com.id
}

output "route_table_public_id" {
  value = aws_route_table.k8s-cluster-prkpo-com.id
}

output "subnet_eu-central-1a_id" {
  value = aws_subnet.eu-central-1a-k8s-cluster-prkpo-com.id
}

output "subnet_utility-eu-central-1a_id" {
  value = aws_subnet.utility-eu-central-1a-k8s-cluster-prkpo-com.id
}

output "vpc_cidr_block" {
  value = aws_vpc.k8s-cluster-prkpo-com.cidr_block
}

output "vpc_id" {
  value = aws_vpc.k8s-cluster-prkpo-com.id
}

output "vpc_ipv6_cidr_block" {
  value = aws_vpc.k8s-cluster-prkpo-com.ipv6_cidr_block
}

output "vpc_ipv6_cidr_length" {
  value = local.vpc_ipv6_cidr_block == "" ? null : tonumber(regex(".*/(\\d+)", local.vpc_ipv6_cidr_block)[0])
}

provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  alias  = "files"
  region = "eu-central-1"
}

resource "aws_autoscaling_group" "bastions-k8s-cluster-prkpo-com" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.bastions-k8s-cluster-prkpo-com.id
    version = aws_launch_template.bastions-k8s-cluster-prkpo-com.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "bastions.k8s-cluster.prkpo.com"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "k8s-cluster.prkpo.com"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "bastions.k8s-cluster.prkpo.com"
  }
  tag {
    key                 = "aws-node-termination-handler/managed"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/bastion"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "bastions"
  }
  tag {
    key                 = "kubernetes.io/cluster/k8s-cluster.prkpo.com"
    propagate_at_launch = true
    value               = "owned"
  }
  target_group_arns   = [aws_lb_target_group.bastion-k8s-cluster-prkpo-qh2bd2.id]
  vpc_zone_identifier = [aws_subnet.eu-central-1a-k8s-cluster-prkpo-com.id]
}

resource "aws_autoscaling_group" "control-plane-eu-central-1a-masters-k8s-cluster-prkpo-com" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.control-plane-eu-central-1a-masters-k8s-cluster-prkpo-com.id
    version = aws_launch_template.control-plane-eu-central-1a-masters-k8s-cluster-prkpo-com.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "control-plane-eu-central-1a.masters.k8s-cluster.prkpo.com"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "k8s-cluster.prkpo.com"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "control-plane-eu-central-1a.masters.k8s-cluster.prkpo.com"
  }
  tag {
    key                 = "aws-node-termination-handler/managed"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/control-plane"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "k8s.io/role/master"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "control-plane-eu-central-1a"
  }
  tag {
    key                 = "kubernetes.io/cluster/k8s-cluster.prkpo.com"
    propagate_at_launch = true
    value               = "owned"
  }
  target_group_arns   = [aws_lb_target_group.kops-controller-k8s-clust-c5rkrt.id, aws_lb_target_group.tcp-k8s-cluster-prkpo-com-lqvpc4.id]
  vpc_zone_identifier = [aws_subnet.eu-central-1a-k8s-cluster-prkpo-com.id]
}

resource "aws_autoscaling_group" "nodes-eu-central-1a-k8s-cluster-prkpo-com" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.nodes-eu-central-1a-k8s-cluster-prkpo-com.id
    version = aws_launch_template.nodes-eu-central-1a-k8s-cluster-prkpo-com.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "nodes-eu-central-1a.k8s-cluster.prkpo.com"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "k8s-cluster.prkpo.com"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "nodes-eu-central-1a.k8s-cluster.prkpo.com"
  }
  tag {
    key                 = "aws-node-termination-handler/managed"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/node"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes-eu-central-1a"
  }
  tag {
    key                 = "kubernetes.io/cluster/k8s-cluster.prkpo.com"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.eu-central-1a-k8s-cluster-prkpo-com.id]
}

resource "aws_autoscaling_lifecycle_hook" "bastions-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.bastions-k8s-cluster-prkpo-com.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "bastions-NTHLifecycleHook"
}

resource "aws_autoscaling_lifecycle_hook" "control-plane-eu-central-1a-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.control-plane-eu-central-1a-masters-k8s-cluster-prkpo-com.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "control-plane-eu-central-1a-NTHLifecycleHook"
}

resource "aws_autoscaling_lifecycle_hook" "nodes-eu-central-1a-NTHLifecycleHook" {
  autoscaling_group_name = aws_autoscaling_group.nodes-eu-central-1a-k8s-cluster-prkpo-com.id
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  name                   = "nodes-eu-central-1a-NTHLifecycleHook"
}

resource "aws_cloudwatch_event_rule" "k8s-cluster-prkpo-com-ASGLifecycle" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_k8s-cluster.prkpo.com-ASGLifecycle_event_pattern")
  name          = "k8s-cluster.prkpo.com-ASGLifecycle"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "k8s-cluster.prkpo.com-ASGLifecycle"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "k8s-cluster-prkpo-com-InstanceScheduledChange" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_k8s-cluster.prkpo.com-InstanceScheduledChange_event_pattern")
  name          = "k8s-cluster.prkpo.com-InstanceScheduledChange"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "k8s-cluster.prkpo.com-InstanceScheduledChange"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "k8s-cluster-prkpo-com-InstanceStateChange" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_k8s-cluster.prkpo.com-InstanceStateChange_event_pattern")
  name          = "k8s-cluster.prkpo.com-InstanceStateChange"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "k8s-cluster.prkpo.com-InstanceStateChange"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_cloudwatch_event_rule" "k8s-cluster-prkpo-com-SpotInterruption" {
  event_pattern = file("${path.module}/data/aws_cloudwatch_event_rule_k8s-cluster.prkpo.com-SpotInterruption_event_pattern")
  name          = "k8s-cluster.prkpo.com-SpotInterruption"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "k8s-cluster.prkpo.com-SpotInterruption"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_cloudwatch_event_target" "k8s-cluster-prkpo-com-ASGLifecycle-Target" {
  arn  = aws_sqs_queue.k8s-cluster-prkpo-com-nth.arn
  rule = aws_cloudwatch_event_rule.k8s-cluster-prkpo-com-ASGLifecycle.id
}

resource "aws_cloudwatch_event_target" "k8s-cluster-prkpo-com-InstanceScheduledChange-Target" {
  arn  = aws_sqs_queue.k8s-cluster-prkpo-com-nth.arn
  rule = aws_cloudwatch_event_rule.k8s-cluster-prkpo-com-InstanceScheduledChange.id
}

resource "aws_cloudwatch_event_target" "k8s-cluster-prkpo-com-InstanceStateChange-Target" {
  arn  = aws_sqs_queue.k8s-cluster-prkpo-com-nth.arn
  rule = aws_cloudwatch_event_rule.k8s-cluster-prkpo-com-InstanceStateChange.id
}

resource "aws_cloudwatch_event_target" "k8s-cluster-prkpo-com-SpotInterruption-Target" {
  arn  = aws_sqs_queue.k8s-cluster-prkpo-com-nth.arn
  rule = aws_cloudwatch_event_rule.k8s-cluster-prkpo-com-SpotInterruption.id
}

resource "aws_ebs_volume" "a-etcd-events-k8s-cluster-prkpo-com" {
  availability_zone = "eu-central-1a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "a.etcd-events.k8s-cluster.prkpo.com"
    "k8s.io/etcd/events"                          = "a/a"
    "k8s.io/role/control-plane"                   = "1"
    "k8s.io/role/master"                          = "1"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_ebs_volume" "a-etcd-main-k8s-cluster-prkpo-com" {
  availability_zone = "eu-central-1a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "a.etcd-main.k8s-cluster.prkpo.com"
    "k8s.io/etcd/main"                            = "a/a"
    "k8s.io/role/control-plane"                   = "1"
    "k8s.io/role/master"                          = "1"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_eip" "eu-central-1a-k8s-cluster-prkpo-com" {
  domain = "vpc"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "eu-central-1a.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "bastions-k8s-cluster-prkpo-com" {
  name = "bastions.k8s-cluster.prkpo.com"
  role = aws_iam_role.bastions-k8s-cluster-prkpo-com.name
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "bastions.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-k8s-cluster-prkpo-com" {
  name = "masters.k8s-cluster.prkpo.com"
  role = aws_iam_role.masters-k8s-cluster-prkpo-com.name
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "masters.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "nodes-k8s-cluster-prkpo-com" {
  name = "nodes.k8s-cluster.prkpo.com"
  role = aws_iam_role.nodes-k8s-cluster-prkpo-com.name
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "nodes.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_iam_role" "bastions-k8s-cluster-prkpo-com" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_bastions.k8s-cluster.prkpo.com_policy")
  name               = "bastions.k8s-cluster.prkpo.com"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "bastions.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_iam_role" "masters-k8s-cluster-prkpo-com" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_masters.k8s-cluster.prkpo.com_policy")
  name               = "masters.k8s-cluster.prkpo.com"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "masters.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_iam_role" "nodes-k8s-cluster-prkpo-com" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_nodes.k8s-cluster.prkpo.com_policy")
  name               = "nodes.k8s-cluster.prkpo.com"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "nodes.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_iam_role_policy" "bastions-k8s-cluster-prkpo-com" {
  name   = "bastions.k8s-cluster.prkpo.com"
  policy = file("${path.module}/data/aws_iam_role_policy_bastions.k8s-cluster.prkpo.com_policy")
  role   = aws_iam_role.bastions-k8s-cluster-prkpo-com.name
}

resource "aws_iam_role_policy" "masters-k8s-cluster-prkpo-com" {
  name   = "masters.k8s-cluster.prkpo.com"
  policy = file("${path.module}/data/aws_iam_role_policy_masters.k8s-cluster.prkpo.com_policy")
  role   = aws_iam_role.masters-k8s-cluster-prkpo-com.name
}

resource "aws_iam_role_policy" "nodes-k8s-cluster-prkpo-com" {
  name   = "nodes.k8s-cluster.prkpo.com"
  policy = file("${path.module}/data/aws_iam_role_policy_nodes.k8s-cluster.prkpo.com_policy")
  role   = aws_iam_role.nodes-k8s-cluster-prkpo-com.name
}

resource "aws_internet_gateway" "k8s-cluster-prkpo-com" {
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_launch_template" "bastions-k8s-cluster-prkpo-com" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 32
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.bastions-k8s-cluster-prkpo-com.id
  }
  image_id      = "ami-08359e82db018c143"
  instance_type = "t3.micro"
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "bastions.k8s-cluster.prkpo.com"
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.bastion-k8s-cluster-prkpo-com.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
      "Name"                                        = "bastions.k8s-cluster.prkpo.com"
      "aws-node-termination-handler/managed"        = ""
      "k8s.io/role/bastion"                         = "1"
      "kops.k8s.io/instancegroup"                   = "bastions"
      "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
      "Name"                                        = "bastions.k8s-cluster.prkpo.com"
      "aws-node-termination-handler/managed"        = ""
      "k8s.io/role/bastion"                         = "1"
      "kops.k8s.io/instancegroup"                   = "bastions"
      "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "bastions.k8s-cluster.prkpo.com"
    "aws-node-termination-handler/managed"        = ""
    "k8s.io/role/bastion"                         = "1"
    "kops.k8s.io/instancegroup"                   = "bastions"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_launch_template" "control-plane-eu-central-1a-masters-k8s-cluster-prkpo-com" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 64
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.masters-k8s-cluster-prkpo-com.id
  }
  image_id      = "ami-08359e82db018c143"
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "control-plane-eu-central-1a.masters.k8s-cluster.prkpo.com"
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.masters-k8s-cluster-prkpo-com.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                                                     = "k8s-cluster.prkpo.com"
      "Name"                                                                                                  = "control-plane-eu-central-1a.masters.k8s-cluster.prkpo.com"
      "aws-node-termination-handler/managed"                                                                  = ""
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/control-plane"                                                                             = "1"
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "control-plane-eu-central-1a"
      "kubernetes.io/cluster/k8s-cluster.prkpo.com"                                                           = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                                                     = "k8s-cluster.prkpo.com"
      "Name"                                                                                                  = "control-plane-eu-central-1a.masters.k8s-cluster.prkpo.com"
      "aws-node-termination-handler/managed"                                                                  = ""
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/control-plane"                                                                             = "1"
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "control-plane-eu-central-1a"
      "kubernetes.io/cluster/k8s-cluster.prkpo.com"                                                           = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                                                     = "k8s-cluster.prkpo.com"
    "Name"                                                                                                  = "control-plane-eu-central-1a.masters.k8s-cluster.prkpo.com"
    "aws-node-termination-handler/managed"                                                                  = ""
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
    "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
    "k8s.io/role/control-plane"                                                                             = "1"
    "k8s.io/role/master"                                                                                    = "1"
    "kops.k8s.io/instancegroup"                                                                             = "control-plane-eu-central-1a"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com"                                                           = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_control-plane-eu-central-1a.masters.k8s-cluster.prkpo.com_user_data")
}

resource "aws_launch_template" "nodes-eu-central-1a-k8s-cluster-prkpo-com" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 128
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.nodes-k8s-cluster-prkpo-com.id
  }
  image_id      = "ami-08359e82db018c143"
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "nodes-eu-central-1a.k8s-cluster.prkpo.com"
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.nodes-k8s-cluster-prkpo-com.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "k8s-cluster.prkpo.com"
      "Name"                                                                       = "nodes-eu-central-1a.k8s-cluster.prkpo.com"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-eu-central-1a"
      "kubernetes.io/cluster/k8s-cluster.prkpo.com"                                = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "k8s-cluster.prkpo.com"
      "Name"                                                                       = "nodes-eu-central-1a.k8s-cluster.prkpo.com"
      "aws-node-termination-handler/managed"                                       = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-eu-central-1a"
      "kubernetes.io/cluster/k8s-cluster.prkpo.com"                                = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "k8s-cluster.prkpo.com"
    "Name"                                                                       = "nodes-eu-central-1a.k8s-cluster.prkpo.com"
    "aws-node-termination-handler/managed"                                       = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/node"                                                           = "1"
    "kops.k8s.io/instancegroup"                                                  = "nodes-eu-central-1a"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com"                                = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_nodes-eu-central-1a.k8s-cluster.prkpo.com_user_data")
}

resource "aws_lb" "api-k8s-cluster-prkpo-com" {
  enable_cross_zone_load_balancing = true
  internal                         = false
  load_balancer_type               = "network"
  name                             = "api-k8s-cluster-prkpo-com-1nbg7c"
  security_groups                  = [aws_security_group.api-elb-k8s-cluster-prkpo-com.id]
  subnet_mapping {
    subnet_id = aws_subnet.utility-eu-central-1a-k8s-cluster-prkpo-com.id
  }
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "api.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_lb" "bastion-k8s-cluster-prkpo-com" {
  enable_cross_zone_load_balancing = false
  internal                         = false
  load_balancer_type               = "network"
  name                             = "bastion-k8s-cluster-prkpo-qh2bd2"
  security_groups                  = [aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id]
  subnet_mapping {
    subnet_id = aws_subnet.utility-eu-central-1a-k8s-cluster-prkpo-com.id
  }
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "bastion.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_lb_listener" "api-k8s-cluster-prkpo-com-3988" {
  default_action {
    target_group_arn = aws_lb_target_group.kops-controller-k8s-clust-c5rkrt.id
    type             = "forward"
  }
  load_balancer_arn = aws_lb.api-k8s-cluster-prkpo-com.id
  port              = 3988
  protocol          = "TCP"
}

resource "aws_lb_listener" "api-k8s-cluster-prkpo-com-443" {
  default_action {
    target_group_arn = aws_lb_target_group.tcp-k8s-cluster-prkpo-com-lqvpc4.id
    type             = "forward"
  }
  load_balancer_arn = aws_lb.api-k8s-cluster-prkpo-com.id
  port              = 443
  protocol          = "TCP"
}

resource "aws_lb_listener" "bastion-k8s-cluster-prkpo-com-22" {
  default_action {
    target_group_arn = aws_lb_target_group.bastion-k8s-cluster-prkpo-qh2bd2.id
    type             = "forward"
  }
  load_balancer_arn = aws_lb.bastion-k8s-cluster-prkpo-com.id
  port              = 22
  protocol          = "TCP"
}

resource "aws_lb_target_group" "bastion-k8s-cluster-prkpo-qh2bd2" {
  connection_termination = "true"
  deregistration_delay   = "30"
  health_check {
    healthy_threshold   = 2
    interval            = 10
    protocol            = "TCP"
    unhealthy_threshold = 2
  }
  name     = "bastion-k8s-cluster-prkpo-qh2bd2"
  port     = 22
  protocol = "TCP"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "bastion-k8s-cluster-prkpo-qh2bd2"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_lb_target_group" "kops-controller-k8s-clust-c5rkrt" {
  connection_termination = "true"
  deregistration_delay   = "30"
  health_check {
    healthy_threshold   = 2
    interval            = 10
    protocol            = "TCP"
    unhealthy_threshold = 2
  }
  name     = "kops-controller-k8s-clust-c5rkrt"
  port     = 3988
  protocol = "TCP"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "kops-controller-k8s-clust-c5rkrt"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_lb_target_group" "tcp-k8s-cluster-prkpo-com-lqvpc4" {
  connection_termination = "true"
  deregistration_delay   = "30"
  health_check {
    healthy_threshold   = 2
    interval            = 10
    protocol            = "TCP"
    unhealthy_threshold = 2
  }
  name     = "tcp-k8s-cluster-prkpo-com-lqvpc4"
  port     = 443
  protocol = "TCP"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "tcp-k8s-cluster-prkpo-com-lqvpc4"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_nat_gateway" "eu-central-1a-k8s-cluster-prkpo-com" {
  allocation_id = aws_eip.eu-central-1a-k8s-cluster-prkpo-com.id
  subnet_id     = aws_subnet.utility-eu-central-1a-k8s-cluster-prkpo-com.id
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "eu-central-1a.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_route" "route-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.k8s-cluster-prkpo-com.id
  route_table_id         = aws_route_table.k8s-cluster-prkpo-com.id
}

resource "aws_route" "route-__--0" {
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.k8s-cluster-prkpo-com.id
  route_table_id              = aws_route_table.k8s-cluster-prkpo-com.id
}

resource "aws_route" "route-private-eu-central-1a-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.eu-central-1a-k8s-cluster-prkpo-com.id
  route_table_id         = aws_route_table.private-eu-central-1a-k8s-cluster-prkpo-com.id
}

resource "aws_route_table" "k8s-cluster-prkpo-com" {
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
    "kubernetes.io/kops/role"                     = "public"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_route_table" "private-eu-central-1a-k8s-cluster-prkpo-com" {
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "private-eu-central-1a.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
    "kubernetes.io/kops/role"                     = "private-eu-central-1a"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_route_table_association" "private-eu-central-1a-k8s-cluster-prkpo-com" {
  route_table_id = aws_route_table.private-eu-central-1a-k8s-cluster-prkpo-com.id
  subnet_id      = aws_subnet.eu-central-1a-k8s-cluster-prkpo-com.id
}

resource "aws_route_table_association" "utility-eu-central-1a-k8s-cluster-prkpo-com" {
  route_table_id = aws_route_table.k8s-cluster-prkpo-com.id
  subnet_id      = aws_subnet.utility-eu-central-1a-k8s-cluster-prkpo-com.id
}

resource "aws_s3_object" "cluster-completed-spec" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_cluster-completed.spec_content")
  key      = "k8s-cluster.prkpo.com/cluster-completed.spec"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "etcd-cluster-spec-events" {
  # acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_etcd-cluster-spec-events_content")
  key      = "k8s-cluster.prkpo.com/backups/etcd/events/control/etcd-cluster-spec"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "etcd-cluster-spec-main" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_etcd-cluster-spec-main_content")
  key      = "k8s-cluster.prkpo.com/backups/etcd/main/control/etcd-cluster-spec"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "k8s-cluster-prkpo-com-addons-aws-cloud-controller-addons-k8s-io-k8s-1-18" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_k8s-cluster.prkpo.com-addons-aws-cloud-controller.addons.k8s.io-k8s-1.18_content")
  key      = "k8s-cluster.prkpo.com/addons/aws-cloud-controller.addons.k8s.io/k8s-1.18.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "k8s-cluster-prkpo-com-addons-aws-ebs-csi-driver-addons-k8s-io-k8s-1-17" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_k8s-cluster.prkpo.com-addons-aws-ebs-csi-driver.addons.k8s.io-k8s-1.17_content")
  key      = "k8s-cluster.prkpo.com/addons/aws-ebs-csi-driver.addons.k8s.io/k8s-1.17.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "k8s-cluster-prkpo-com-addons-bootstrap" {
  # acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_k8s-cluster.prkpo.com-addons-bootstrap_content")
  key      = "k8s-cluster.prkpo.com/addons/bootstrap-channel.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "k8s-cluster-prkpo-com-addons-coredns-addons-k8s-io-k8s-1-12" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_k8s-cluster.prkpo.com-addons-coredns.addons.k8s.io-k8s-1.12_content")
  key      = "k8s-cluster.prkpo.com/addons/coredns.addons.k8s.io/k8s-1.12.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "k8s-cluster-prkpo-com-addons-kops-controller-addons-k8s-io-k8s-1-16" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_k8s-cluster.prkpo.com-addons-kops-controller.addons.k8s.io-k8s-1.16_content")
  key      = "k8s-cluster.prkpo.com/addons/kops-controller.addons.k8s.io/k8s-1.16.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "k8s-cluster-prkpo-com-addons-kubelet-api-rbac-addons-k8s-io-k8s-1-9" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_k8s-cluster.prkpo.com-addons-kubelet-api.rbac.addons.k8s.io-k8s-1.9_content")
  key      = "k8s-cluster.prkpo.com/addons/kubelet-api.rbac.addons.k8s.io/k8s-1.9.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "k8s-cluster-prkpo-com-addons-limit-range-addons-k8s-io" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_k8s-cluster.prkpo.com-addons-limit-range.addons.k8s.io_content")
  key      = "k8s-cluster.prkpo.com/addons/limit-range.addons.k8s.io/v1.5.0.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "k8s-cluster-prkpo-com-addons-networking-cilium-io-k8s-1-16" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_k8s-cluster.prkpo.com-addons-networking.cilium.io-k8s-1.16_content")
  key      = "k8s-cluster.prkpo.com/addons/networking.cilium.io/k8s-1.16-v1.15.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "k8s-cluster-prkpo-com-addons-node-termination-handler-aws-k8s-1-11" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_k8s-cluster.prkpo.com-addons-node-termination-handler.aws-k8s-1.11_content")
  key      = "k8s-cluster.prkpo.com/addons/node-termination-handler.aws/k8s-1.11.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "k8s-cluster-prkpo-com-addons-storage-aws-addons-k8s-io-v1-15-0" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_k8s-cluster.prkpo.com-addons-storage-aws.addons.k8s.io-v1.15.0_content")
  key      = "k8s-cluster.prkpo.com/addons/storage-aws.addons.k8s.io/v1.15.0.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "kops-version-txt" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_kops-version.txt_content")
  key      = "k8s-cluster.prkpo.com/kops-version.txt"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "manifests-etcdmanager-events-control-plane-eu-central-1a" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_manifests-etcdmanager-events-control-plane-eu-central-1a_content")
  key      = "k8s-cluster.prkpo.com/manifests/etcd/events-control-plane-eu-central-1a.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "manifests-etcdmanager-main-control-plane-eu-central-1a" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_manifests-etcdmanager-main-control-plane-eu-central-1a_content")
  key      = "k8s-cluster.prkpo.com/manifests/etcd/main-control-plane-eu-central-1a.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "manifests-static-kube-apiserver-healthcheck" {
  #acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_manifests-static-kube-apiserver-healthcheck_content")
  key      = "k8s-cluster.prkpo.com/manifests/static/kube-apiserver-healthcheck.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "nodeupconfig-control-plane-eu-central-1a" {
  # acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_nodeupconfig-control-plane-eu-central-1a_content")
  key      = "k8s-cluster.prkpo.com/igconfig/control-plane/control-plane-eu-central-1a/nodeupconfig.yaml"
  provider = aws.files
  #server_side_encryption = ""
}

resource "aws_s3_object" "nodeupconfig-nodes-eu-central-1a" {
  # acl                    = ""
  bucket   = "task3kops"
  content  = file("${path.module}/data/aws_s3_object_nodeupconfig-nodes-eu-central-1a_content")
  key      = "k8s-cluster.prkpo.com/igconfig/node/nodes-eu-central-1a/nodeupconfig.yaml"
  provider = aws.files
  # server_side_encryption = ""
}

resource "aws_security_group" "api-elb-k8s-cluster-prkpo-com" {
  description = "Security group for api ELB"
  name        = "api-elb.k8s-cluster.prkpo.com"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "api-elb.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_security_group" "bastion-elb-k8s-cluster-prkpo-com" {
  description = "Security group for bastion ELB"
  name        = "bastion-elb.k8s-cluster.prkpo.com"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "bastion-elb.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_security_group" "bastion-k8s-cluster-prkpo-com" {
  description = "Security group for bastion"
  name        = "bastion.k8s-cluster.prkpo.com"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "bastion.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_security_group" "masters-k8s-cluster-prkpo-com" {
  description = "Security group for masters"
  name        = "masters.k8s-cluster.prkpo.com"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "masters.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_security_group" "nodes-k8s-cluster-prkpo-com" {
  description = "Security group for nodes"
  name        = "nodes.k8s-cluster.prkpo.com"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "nodes.k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-22to22-bastion-elb-k8s-cluster-prkpo-com" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-443to443-api-elb-k8s-cluster-prkpo-com" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.api-elb-k8s-cluster-prkpo-com.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-172-20-0-0--20-ingress-tcp-22to22-bastion-elb-k8s-cluster-prkpo-com" {
  cidr_blocks       = ["172.20.0.0/20"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-22to22-bastion-elb-k8s-cluster-prkpo-com" {
  from_port         = 22
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-443to443-api-elb-k8s-cluster-prkpo-com" {
  from_port         = 443
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.api-elb-k8s-cluster-prkpo-com.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-api-elb-k8s-cluster-prkpo-com-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.api-elb-k8s-cluster-prkpo-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-api-elb-k8s-cluster-prkpo-com-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.api-elb-k8s-cluster-prkpo-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-k8s-cluster-prkpo-com-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-k8s-cluster-prkpo-com-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-k8s-cluster-prkpo-com-ingress-icmp-3to4-bastion-k8s-cluster-prkpo-com" {
  from_port                = 3
  protocol                 = "icmp"
  security_group_id        = aws_security_group.bastion-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id
  to_port                  = 4
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-elb-k8s-cluster-prkpo-com-ingress-tcp-22to22-bastion-k8s-cluster-prkpo-com" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.bastion-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-k8s-cluster-prkpo-com-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-k8s-cluster-prkpo-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-k8s-cluster-prkpo-com-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-k8s-cluster-prkpo-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-k8s-cluster-prkpo-com-ingress-icmp-3to4-bastion-elb-k8s-cluster-prkpo-com" {
  from_port                = 3
  protocol                 = "icmp"
  security_group_id        = aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.bastion-k8s-cluster-prkpo-com.id
  to_port                  = 4
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-k8s-cluster-prkpo-com-ingress-tcp-22to22-masters-k8s-cluster-prkpo-com" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.bastion-k8s-cluster-prkpo-com.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-k8s-cluster-prkpo-com-ingress-tcp-22to22-nodes-k8s-cluster-prkpo-com" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nodes-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.bastion-k8s-cluster-prkpo-com.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-masters-k8s-cluster-prkpo-com-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.masters-k8s-cluster-prkpo-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-k8s-cluster-prkpo-com-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.masters-k8s-cluster-prkpo-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-k8s-cluster-prkpo-com-ingress-all-0to0-masters-k8s-cluster-prkpo-com" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.masters-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.masters-k8s-cluster-prkpo-com.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-masters-k8s-cluster-prkpo-com-ingress-all-0to0-nodes-k8s-cluster-prkpo-com" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.masters-k8s-cluster-prkpo-com.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-prkpo-com-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-k8s-cluster-prkpo-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-prkpo-com-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-k8s-cluster-prkpo-com.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-prkpo-com-ingress-all-0to0-nodes-k8s-cluster-prkpo-com" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.nodes-k8s-cluster-prkpo-com.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-prkpo-com-ingress-tcp-1to2379-masters-k8s-cluster-prkpo-com" {
  from_port                = 1
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.nodes-k8s-cluster-prkpo-com.id
  to_port                  = 2379
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-prkpo-com-ingress-tcp-2382to4000-masters-k8s-cluster-prkpo-com" {
  from_port                = 2382
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.nodes-k8s-cluster-prkpo-com.id
  to_port                  = 4000
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-prkpo-com-ingress-tcp-4003to65535-masters-k8s-cluster-prkpo-com" {
  from_port                = 4003
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.nodes-k8s-cluster-prkpo-com.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-k8s-cluster-prkpo-com-ingress-udp-1to65535-masters-k8s-cluster-prkpo-com" {
  from_port                = 1
  protocol                 = "udp"
  security_group_id        = aws_security_group.masters-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.nodes-k8s-cluster-prkpo-com.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "https-elb-to-master" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.api-elb-k8s-cluster-prkpo-com.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-api-elb-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 3
  protocol          = "icmp"
  security_group_id = aws_security_group.api-elb-k8s-cluster-prkpo-com.id
  to_port           = 4
  type              = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-cp-to-elb" {
  from_port                = 3
  protocol                 = "icmp"
  security_group_id        = aws_security_group.api-elb-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.masters-k8s-cluster-prkpo-com.id
  to_port                  = 4
  type                     = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-elb-to-cp" {
  from_port                = 3
  protocol                 = "icmp"
  security_group_id        = aws_security_group.masters-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.api-elb-k8s-cluster-prkpo-com.id
  to_port                  = 4
  type                     = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-ssh-nlb-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 3
  protocol          = "icmp"
  security_group_id = aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id
  to_port           = 4
  type              = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-ssh-nlb-172-20-0-0--20" {
  cidr_blocks       = ["172.20.0.0/20"]
  from_port         = 3
  protocol          = "icmp"
  security_group_id = aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id
  to_port           = 4
  type              = "ingress"
}

resource "aws_security_group_rule" "icmpv6-pmtu-api-elb-__--0" {
  from_port         = -1
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "icmpv6"
  security_group_id = aws_security_group.api-elb-k8s-cluster-prkpo-com.id
  to_port           = -1
  type              = "ingress"
}

resource "aws_security_group_rule" "icmpv6-pmtu-ssh-nlb-__--0" {
  from_port         = -1
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "icmpv6"
  security_group_id = aws_security_group.bastion-elb-k8s-cluster-prkpo-com.id
  to_port           = -1
  type              = "ingress"
}

resource "aws_security_group_rule" "kops-controller-elb-to-cp" {
  from_port                = 3988
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.api-elb-k8s-cluster-prkpo-com.id
  to_port                  = 3988
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-to-elb" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.api-elb-k8s-cluster-prkpo-com.id
  source_security_group_id = aws_security_group.nodes-k8s-cluster-prkpo-com.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_sqs_queue" "k8s-cluster-prkpo-com-nth" {
  message_retention_seconds = 300
  name                      = "k8s-cluster-prkpo-com-nth"
  policy                    = file("${path.module}/data/aws_sqs_queue_k8s-cluster-prkpo-com-nth_policy")
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "k8s-cluster-prkpo-com-nth"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_subnet" "eu-central-1a-k8s-cluster-prkpo-com" {
  availability_zone                           = "eu-central-1a"
  cidr_block                                  = "172.20.128.0/17"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "eu-central-1a.k8s-cluster.prkpo.com"
    "SubnetType"                                  = "Private"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
    "kubernetes.io/role/internal-elb"             = "1"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_subnet" "utility-eu-central-1a-k8s-cluster-prkpo-com" {
  availability_zone                           = "eu-central-1a"
  cidr_block                                  = "172.20.0.0/20"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "utility-eu-central-1a.k8s-cluster.prkpo.com"
    "SubnetType"                                  = "Utility"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
    "kubernetes.io/role/elb"                      = "1"
  }
  vpc_id = aws_vpc.k8s-cluster-prkpo-com.id
}

resource "aws_vpc" "k8s-cluster-prkpo-com" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = "172.20.0.0/16"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "k8s-cluster-prkpo-com" {
  domain_name         = "eu-central-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    "KubernetesCluster"                           = "k8s-cluster.prkpo.com"
    "Name"                                        = "k8s-cluster.prkpo.com"
    "kubernetes.io/cluster/k8s-cluster.prkpo.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "k8s-cluster-prkpo-com" {
  dhcp_options_id = aws_vpc_dhcp_options.k8s-cluster-prkpo-com.id
  vpc_id          = aws_vpc.k8s-cluster-prkpo-com.id
}

terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      "configuration_aliases" = [aws.files]
      "source"                = "hashicorp/aws"
      "version"               = ">= 5.0.0"
    }
  }
}
