#!/bin/bash
set -e

echo "🚀 Starting deployment process..."

# Store the current directory
APP_DIR="/var/www/tendr-buddi"
BACKUP_DIR="/var/www/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Create backup of current version
if [ -d "$APP_DIR" ]; then
    echo "📦 Creating backup of current version..."
    mkdir -p "$BACKUP_DIR"
    tar -czf "$BACKUP_DIR/backup_$TIMESTAMP.tar.gz" -C "$APP_DIR" .
fi

# Pull latest changes
echo "⬇️ Pulling latest changes..."
git pull origin main

# Install dependencies
echo "📦 Installing dependencies..."
npm ci

# Generate Prisma client
echo "🔄 Generating Prisma client..."
npx prisma generate

# Run database migrations
echo "🗃️ Running database migrations..."
npx prisma migrate deploy

# Build the application
echo "🏗️ Building the application..."
npm run build

# Restart the application (using PM2)
echo "🔄 Restarting the application..."
pm2 reload tendr-buddi

echo "✅ Deployment complete!"

# Function to rollback if needed
rollback() {
    echo "❌ Error detected, rolling back..."
    if [ -f "$BACKUP_DIR/backup_$TIMESTAMP.tar.gz" ]; then
        rm -rf "$APP_DIR"/*
        tar -xzf "$BACKUP_DIR/backup_$TIMESTAMP.tar.gz" -C "$APP_DIR"
        pm2 reload tendr-buddi
        echo "✅ Rollback complete!"
    else
        echo "❌ No backup found to rollback to!"
    fi
}

# Set up error handling
trap rollback ERR

