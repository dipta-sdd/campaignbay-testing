#!/bin/bash

# ==============================================================================
# WP-CLI Installer Script
# ==============================================================================
# This script is run automatically by the Docker container on its first start.
# It checks for the existence of WP-CLI and installs it if not found.
# ==============================================================================

set -e

# The target location for the WP-CLI executable
WP_CLI_PATH="/usr/local/bin/wp"

# Check if WP-CLI is already installed
if [ -f "$WP_CLI_PATH" ]; then
    echo "WP-CLI is already installed at $WP_CLI_PATH. Skipping installation."
else
    echo "WP-CLI not found. Starting installation..."
    
    # Download the WP-CLI phar file using curl
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    
    # Make the file executable
    chmod +x wp-cli.phar
    
    # Move it to a location in the system's PATH and rename it to 'wp'
    mv wp-cli.phar "$WP_CLI_PATH"
    
    echo "WP-CLI installed successfully to $WP_CLI_PATH."
fi