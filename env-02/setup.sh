#!/bin/bash
# setup.sh

# --- Configuration ---
WP_VERSION=$1
WC_VERSION=$2
THEME_SLUG=$3
THEME_TYPE=$4 # 'classic' or 'block'

# --- Script ---
echo "--- Starting setup for WP $WP_VERSION, WC $WC_VERSION, Theme $THEME_SLUG ---"

# The command to run WP-CLI inside the docker container
# CORRECTED: Uses 'docker compose' (with a space) instead of 'docker-compose'
WP_CLI="docker compose exec -u www-data wordpress wp"

# 1. Install correct WordPress version if needed
# (The legacy docker image already has 4.4, but this ensures it)
if [ "$WP_VERSION" != "latest" ]; then
    echo "Installing WordPress version $WP_VERSION..."
    $WP_CLI core download --version=$WP_VERSION --force
fi

# 2. Install and activate WooCommerce
echo "Installing WooCommerce version $WC_VERSION..."
$WP_CLI plugin install woocommerce --version=$WC_VERSION --activate --force

# 3. Install and activate your plugin
echo "Activating CampaignBay plugin..."
$WP_CLI plugin activate campaign-bay

# 4. Install and activate the theme
echo "Installing and activating theme: $THEME_SLUG..."
if [ "$THEME_TYPE" == "classic" ]; then
    $WP_CLI theme install storefront --activate
else
    # For block themes, we might need a specific one or the default
    $WP_CLI theme install twentytwentyfour --activate
fi

# 5. Import WooCommerce sample data (optional but recommended)
# You need to have the sample data csv file available
# Example: $WP_CLI wc product create --user=admin /path/to/sample_products.csv

echo "--- Setup Complete! ---"
echo "Access site at http://localhost:<PORT>"