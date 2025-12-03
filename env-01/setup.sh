
WP_CLI="docker compose exec -u www-data wordpress wp"

# 2. Install and activate WooCommerce
echo "Installing WooCommerce version latest..."
$WP_CLI plugin install woocommerce  --activate --force

# 3. Install and activate your plugin
echo "Activating CampaignBay plugin..."
$WP_CLI plugin activate campaignbay

# 4. Install and activate the theme
echo "Installing and activating theme: storefront..."
    $WP_CLI theme install storefront --activate

echo "--- Setup Complete! ---"
echo "Access site at http://localhost:8001"