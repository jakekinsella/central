#! /bin/bash

export VERSION=${1:-latest}

echo "Pushing to ${CONTROL_PLANE_IP} @ $VERSION"

export IMAGE="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/central:$VERSION"
export UI_IMAGE="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/central_ui:$VERSION"
export IMAGE_POLICY="IfNotPresent"
export HOST="central.jakekinsella.com"
export NODE_SELECTOR="      nodeSelector:
        node-role.kubernetes.io/control-plane: \"true\""

rm -rf tmp/
mkdir -p tmp/build/cluster/

for f in build/cluster/*.yaml; do envsubst < $f > tmp/$f; done

ssh ubuntu@"${CONTROL_PLANE_IP}" "mkdir -p ~/cluster/central"

scp -r secrets.env ubuntu@"${CONTROL_PLANE_IP}":~/secrets.env
scp -r tmp/build/cluster/* ubuntu@"${CONTROL_PLANE_IP}":~/cluster/central/
