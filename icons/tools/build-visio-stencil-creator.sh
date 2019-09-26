#!/bin/bash

GITHUB_ORG="hoveytechllc"
REPO_NAME="visio-stencil-creator"
TAG_NAME="v1.0"

GCR_REPO="gcr.k8s.io/${REPO_NAME}:${TAG_NAME}"

rm -fdr ./tools/${REPO_NAME}

# Clone repository in current path
git clone --branch release/${TAG_NAME} https://github.com/${GITHUB_ORG}/${REPO_NAME}.git ./tools/${REPO_NAME}

# build image using Dockerfile from github repository
# Tag resulting image for pushing to k8s.gcr.io
docker build \
    -t ${GCR_REPO} \
    -f ./tools/${REPO_NAME}/Dockerfile \
    ./tools/${REPO_NAME}

# Clean up source code
rm -fdr ./tools/${REPO_NAME}

docker push ${GCR_REPO}