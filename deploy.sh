#!/bin/bash

# Build the application
echo "Building the application..."
npm run build

# Start the production server
echo "Starting the production server..."
NODE_ENV=production node server.js

