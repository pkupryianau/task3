#!/bin/bash
export KOPS_STATE_STORE="s3://task3kops"
  export CONTROL_PLANE_SIZE="t2.micro"
  export NODE_SIZE="t2.micro"
  export ZONES="eu-central-1a"
  kops create cluster k8s-cluster.prkpo.com \
  --cloud aws \
  --node-count 1 \
  --zones $ZONES \
  --node-size $NODE_SIZE \
  --control-plane-size $CONTROL_PLANE_SIZE \
  --control-plane-zones $ZONES \
  --networking cilium \
  --topology private \
  --bastion="true" \
  --target=terraform \
  --ssh-public-key=~/.ssh/rsa_kops.pub
  --out=. \
  
