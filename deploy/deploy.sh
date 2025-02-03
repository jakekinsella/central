#! /bin/bash

CLUSTER=$1
VERSION=$2

echo "Deploying to ${CONTROL_PLANE_IP} [$CLUSTER @ $VERSION]"

./build/push.sh $VERSION

PASSWORD=$(ssh ubuntu@"${CONTROL_PLANE_IP}" "aws ecr get-login-password --region us-east-1")
NODES=$(ssh ubuntu@"${CONTROL_PLANE_IP}" "sudo kubectl get nodes -owide" | grep -v NAME | awk '{print $6}')
for node in $NODES
do
  echo $node
  ssh -A ubuntu@"${CONTROL_PLANE_IP}" ssh -o "StrictHostKeyChecking=no" ubuntu@"${node}" "sudo ./ecr_refresh.sh $PASSWORD"
done

ssh ubuntu@"${CONTROL_PLANE_IP}" "sudo kubectl delete secret reader-secrets"
ssh ubuntu@"${CONTROL_PLANE_IP}" "sudo kubectl create secret generic reader-secrets --from-env-file secrets.env"
ssh ubuntu@"${CONTROL_PLANE_IP}" "sudo kubectl delete secret reader-cert"
ssh ubuntu@"${CONTROL_PLANE_IP}" "sudo kubectl create secret tls reader-cert --key=/etc/letsencrypt/live/jakekinsella.com/privkey.pem --cert=/etc/letsencrypt/live/jakekinsella.com/fullchain.pem"

ssh ubuntu@"${CONTROL_PLANE_IP}" "sudo kubectl apply -f $CLUSTER
