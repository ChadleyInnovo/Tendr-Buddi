#!/bin/bash

# Check required environment variables
echo "Checking environment variables..."
required_vars=(
  "DATABASE_URL"
  "NEXTAUTH_SECRET"
  "NEXTAUTH_URL"
)

for var in "${required_vars[@]}"; do
  if [ -z "${!var}" ]; then
    echo "❌ Missing required environment variable: $var"
    exit 1
  fi
done

# Check database connection
echo "Checking database connection..."
npx prisma db push --skip-generate
if [ $? -ne 0 ]; then
  echo "❌ Database connection failed"
  exit 1
fi

# Build check
echo "Checking build..."
npm run build
if [ $? -ne 0 ]; then
  echo "❌ Build failed"
  exit 1
fi

echo "✅ All deployment checks passed!"

