#!/bin/bash

# ==============================================================================
# Start All Test Environments
# ==============================================================================
# This script starts the Docker containers for all 8 test environments.
# It should be run from the root `campaign-bay-testing/` directory.
# ==============================================================================

# Stop the script if any command fails
set -e

echo "====================================================="
echo "====================================================="

# Loop through all environment directories from 1 to 8
for i in {1..8}
do
    ENV_DIR="env-0$(printf "%d" "$i")"

    # Check if the environment directory exists
    if [ -d "$ENV_DIR" ]; then
        echo "--- Clearing Debug Log #$i in $ENV_DIR ---"
        
        # Navigate into the directory and run the start command
        (cd "$ENV_DIR" && docker compose exec wordpress sh -c 'for i in $(seq 1 60); do echo; done > /var/www/html/wp-content/debug.log')
        
    else
        echo "--> Directory $ENV_DIR not found. Skipping."
    fi
done

echo ""
echo "====================================================="
echo "====================================================="