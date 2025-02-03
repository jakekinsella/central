#! /bin/bash

export CLUSTER=$1

echo "Tearing down ${CONTROL_PLANE_IP} [$CLUSTER]"

ssh ubuntu@"${CONTROL_PLANE_IP}" "sudo kubectl delete -f $CLUSTER"
