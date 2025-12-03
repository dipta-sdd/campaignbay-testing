
WP_CLI="docker compose exec -u www-data wordpress wp"

echo "Installing WordPress version"
$WP_CLI core download --version=5.6 --force

# 2. Install and activate WooCommerce
echo "Installing WooCommerce version latest..."
$WP_CLI plugin install woocommerce --version=4.0.0 --activate --force

# 3. Install and activate your plugin
echo "Activating CampaignBay plugin..."
$WP_CLI plugin activate campaignbay

# 4. Install and activate the theme
echo "Installing and activating theme: twentytwentyfour..."
$WP_CLI theme install twentytwentyfour --activate

echo "--- Setup Complete! ---"
echo "Access site at http://localhost:8008"