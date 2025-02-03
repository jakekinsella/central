#! /bin/bash

IMAGE=$1

VERSION=$(git rev-parse --short HEAD)

echo "Pushing image [$IMAGE @ $VERSION]"

aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com
docker tag $(docker images | grep $IMAGE | head -n1 | awk '{print $3}') $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE:$VERSION
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE:$VERSION
