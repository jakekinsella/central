#! /bin/bash

IMAGE=$1
DOCKERFILE=$2

VERSION=$(git rev-parse --short HEAD)

echo "Building image [$IMAGE @ $VERSION]"

export ARCH="arm64v8/"

mkdir -p tmp/deploy/docker/$IMAGE

envsubst < $DOCKERFILE > tmp/deploy/docker/$IMAGE/Dockerfile

docker buildx build --platform linux/arm64/v8 . -f $DOCKERFILE -t "$IMAGE:$VERSION"
