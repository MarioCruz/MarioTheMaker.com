#!/bin/bash

# Configuration
S3_BUCKET="www.mariothemaker.com"
CLOUDFRONT_DIST_ID="E7SOA1Y4SF2O9"
PROFILE="PITA"

# Sync to S3
echo "Deploying to S3..."
aws s3 sync . s3://$S3_BUCKET/ \
  --exclude ".git/*" \
  --exclude ".claude/*" \
  --exclude "*.md" \
  --exclude "deploy.sh" \
  --profile $PROFILE

# Invalidate CloudFront cache
echo "Invalidating CloudFront cache..."
aws cloudfront create-invalidation \
  --distribution-id $CLOUDFRONT_DIST_ID \
  --paths "/*" \
  --profile $PROFILE

echo "Deployment complete!"
