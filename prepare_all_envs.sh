#!/bin/bash

# ==============================================================================
# WooCommerce Smart Campaigns - All Environment PREPARATION Script
# ==============================================================================
# This script STOPS all running containers and PREPARES the configuration
# files for all 8 test environments. It does NOT start them.
#
# Run this from the root `campaign-bay-testing/` directory.
# ==============================================================================

# Stop the script if any command fails
set -e

echo "====================================================="
echo "STEP 1: Stopping all running project containers..."
echo "====================================================="

# Loop through all environment directories and shut them down
for i in {1..8}
do
    ENV_DIR="env-0$(printf "%d" "$i")"
    if [ -d "$ENV_DIR" ] && [ -f "$ENV_DIR/docker-compose.yml" ]; then
        echo "--> Shutting down containers in $ENV_DIR..."
        (cd "$ENV_DIR" && docker compose down -v --remove-orphans > /dev/null 2>&1)
    fi
done
echo "All existing containers have been stopped and removed."
echo ""

echo "====================================================="
echo "STEP 2: Preparing configuration for all environments..."
echo "====================================================="

# Loop through environments from 1 to 8 to prepare them
for i in {1..8}
do
    ENV_DIR="env-0$(printf "%d" "$i")"
    PORT=$((8000 + i))
    
    # --- Configuration Matrix ---
    case $i in
        1|2|5|6) TEMPLATE="modern" ;;
        3|4|7|8) TEMPLATE="legacy" ;;
    esac

    echo "--- Preparing Env #$i in $ENV_DIR ---"

    if [ ! -d "$ENV_DIR" ]; then
        echo "Directory $ENV_DIR not found. Skipping."
        continue
    fi

    # 1. Copy the correct template
    cp "docker-compose.$TEMPLATE.yml" "$ENV_DIR/docker-compose.yml"

    # 2. Copy the setup script
    cp "setup.sh" "$ENV_DIR/setup.sh"

    # 3. Modify the docker-compose.yml file
    #    - Remove the obsolete 'version' line
    #    - Set the unique port
    sed -i -e "/version: '3.8'/d" -e "s/8000:80/$PORT:80/" "$ENV_DIR/docker-compose.yml"

    # 4. Make the setup script executable
    chmod +x "$ENV_DIR/setup.sh"

    echo "Configuration for Env #$i is complete."
done

echo ""
echo "====================================================="
echo "All environments have been prepared successfully."
echo "====================================================="