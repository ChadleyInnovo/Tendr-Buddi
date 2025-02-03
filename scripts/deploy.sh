#!/bin/bash
set -e

echo "🚀 Starting deployment process..."

# 1. Check environment variables
echo "📝 Checking environment variables..."
if [ -z "$DATABASE_URL" ] || [ -z "$NEXTAUTH_URL" ] || [ -z "$NEXTAUTH_SECRET" ]; then
    echo "❌ Missing required environment variables"
    exit 1
fi

# 2. Install dependencies
echo "📦 Installing dependencies..."
npm ci

# 3. Generate Prisma client
echo "🔄 Generating Prisma client..."
npx prisma generate

# 4. Run database migrations
echo "🗃️ Running database migrations..."
npx prisma migrate deploy

# 5. Build the application
echo "🏗️ Building the application..."
npm run build

# 6. Start the application
echo "✨ Starting the application..."
npm start

