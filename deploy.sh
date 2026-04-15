#!/bin/bash
set -euo pipefail

source .env

ENV=${1:-staging}
echo "Deploying to $ENV..."

aws s3 sync ./dist s3://my-app-${ENV}-bucket \
  --region "$AWS_DEFAULT_REGION"

aws ecs update-service \
  --cluster my-cluster \
  --service my-app-${ENV} \
  --force-new-deployment

echo "Done."
