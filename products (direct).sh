#!/bin/bash

# A script to create a set of WooCommerce products using WP-CLI.
# This version ensures every wp command is on a single line to prevent shell errors.

echo "Starting WooCommerce product creation script..."
echo "================================================="

# --- 1. Create Terms (Categories & Tags) and Capture their IDs ---
echo "Creating product categories and tags..."

cat_a_id=$(wp term create product_cat "Category A" --description="Main testing category A" --porcelain)
echo "-> Created 'Category A' with ID: $cat_a_id"

cat_b_id=$(wp term create product_cat "Category B" --description="Main testing category B" --porcelain)
echo "-> Created 'Category B' with ID: $cat_b_id"

cat_c_id=$(wp term create product_cat "Sub-Category C" --description="A child category" --parent="$cat_a_id" --porcelain)
echo "-> Created 'Sub-Category C' (child of Category A) with ID: $cat_c_id"

tag_id=$(wp term create product_tag "Tag X" --porcelain)
echo "-> Created 'Tag X' with ID: $tag_id"

echo "-------------------------------------------------"

# --- 2. Create Simple Products ---
echo "Creating simple products..."

# Each command is now on ONE line.
simple_mug_id=$(wp wc product create --name="Simple Mug" --type=simple --regular_price=15 --manage_stock=true --stock_quantity=50 --categories="[{\"id\":$cat_a_id}]" --sku="MUG-001" --user=admin --porcelain)
echo "-> Created 'Simple Mug' (ID: $simple_mug_id)"

sale_mug_id=$(wp wc product create --name="Simple Mug (On Sale)" --type=simple --regular_price=18 --sale_price=16 --manage_stock=true --stock_quantity=50 --categories="[{\"id\":$cat_a_id}]" --sku="MUG-002-SALE" --user=admin --porcelain)
echo "-> Created 'Simple Mug (On Sale)' (ID: $sale_mug_id)"

wp wc product create --name="Simple Mug (Out of Stock)" --type=simple --regular_price=15 --manage_stock=true --stock_quantity=0 --categories="[{\"id\":$cat_a_id}]" --sku="MUG-003-OOS" --user=admin
echo "-> Created 'Simple Mug (Out of Stock)'"

poster_id=$(wp wc product create --name="Tagged Poster" --type=simple --regular_price=25 --manage_stock=true --stock_quantity=30 --categories="[{\"id\":$cat_b_id}]" --tags="[{\"id\":$tag_id}]" --sku="POSTER-001" --user=admin --porcelain)
echo "-> Created 'Tagged Poster' (ID: $poster_id)"

wp wc product create --name="Sub-Category T-Shirt" --type=simple --regular_price=22 --manage_stock=true --stock_quantity=40 --categories="[{\"id\":$cat_a_id},{\"id\":$cat_c_id}]" --sku="TSHIRT-SUB-001" --user=admin
echo "-> Created 'Sub-Category T-Shirt'"

# Create a placeholder file for downloadable products
touch ./wp-content/uploads/ebook-placeholder.zip

wp wc product create --name="Digital eBook" --type=simple --virtual=true --downloadable=true --regular_price=15 --categories="[{\"id\":$cat_b_id}]" --downloads='[{"name":"eBook File","file":"/wp-content/uploads/ebook-placeholder.zip"}]' --sku="EBOOK-001" --user=admin
echo "-> Created 'Digital eBook'"

wp wc product create --name="One-Hour Consultation" --type=simple --virtual=true --regular_price=100 --categories="[{\"id\":$cat_b_id}]" --sku="SVC-001" --user=admin
echo "-> Created 'One-Hour Consultation'"

echo "-------------------------------------------------"


# --- 3. Create Variable Products (Parents) and Capture their IDs ---
echo "Creating variable products (parents)..."

hoodie_id=$(wp wc product create --name="Hoodie" --type=variable --categories="[{\"id\":$cat_a_id}]" --attributes='[{"name":"Color","options":["Blue","Green"],"variation":true},{"name":"Size","options":["Small","Large"],"variation":true}]' --sku="HOODIE-PARENT" --user=admin --porcelain)
echo "-> Created 'Hoodie' variable product with ID: $hoodie_id"

hoodie_mixed_id=$(wp wc product create --name="Hoodie (Mixed State)" --type=variable --categories="[{\"id\":$cat_a_id}]" --attributes='[{"name":"Color","options":["Blue","Green"],"variation":true},{"name":"Size","options":["Small","Large"],"variation":true}]' --sku="HOODIE-MIXED" --user=admin --porcelain)
echo "-> Created 'Hoodie (Mixed State)' variable product with ID: $hoodie_mixed_id"

hoodie_oos_id=$(wp wc product create --name="Hoodie (All Sold Out)" --type=variable --categories="[{\"id\":$cat_a_id}]" --attributes='[{"name":"Color","options":["Blue","Green"],"variation":true},{"name":"Size","options":["Small","Large"],"variation":true}]' --sku="HOODIE-OOS" --user=admin --porcelain)
echo "-> Created 'Hoodie (All Sold Out)' variable product with ID: $hoodie_oos_id"

software_license_id=$(wp wc product create --name="Software License" --type=variable --virtual=true --categories="[{\"id\":$cat_b_id}]" --attributes='[{"name":"License Type","options":["Single Site","5 Sites","Unlimited"],"variation":true}]' --sku="SOFT-LICENSE" --user=admin --porcelain)
echo "-> Created 'Software License' variable product with ID: $software_license_id"

echo "-------------------------------------------------"


# --- 4. Create Product Variations ---
echo "Creating variations for 'Hoodie' (ID: $hoodie_id)..."
wp wc product_variation create "$hoodie_id" --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Small"}]' --regular_price=40 --manage_stock=true --stock_quantity=20 --user=admin
wp wc product_variation create "$hoodie_id" --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=20 --user=admin
wp wc product_variation create "$hoodie_id" --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Small"}]' --regular_price=40 --manage_stock=true --stock_quantity=20 --user=admin
wp wc product_variation create "$hoodie_id" --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=20 --user=admin

echo "Creating variations for 'Hoodie (Mixed State)' (ID: $hoodie_mixed_id)..."
wp wc product_variation create "$hoodie_mixed_id" --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Small"}]' --regular_price=40 --sale_price=35 --manage_stock=true --stock_quantity=15 --user=admin
wp wc product_variation create "$hoodie_mixed_id" --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=15 --user=admin
wp wc product_variation create "$hoodie_mixed_id" --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Small"}]' --regular_price=40 --manage_stock=true --stock_quantity=0 --user=admin
wp wc product_variation create "$hoodie_mixed_id" --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=15 --user=admin

echo "Creating variations for 'Hoodie (All Sold Out)' (ID: $hoodie_oos_id)..."
wp wc product_variation create "$hoodie_oos_id" --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Small"}]' --regular_price=40 --manage_stock=true --stock_quantity=0 --user=admin
wp wc product_variation create "$hoodie_oos_id" --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=0 --user=admin
wp wc product_variation create "$hoodie_oos_id" --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Small"}]' --regular_price=40 --manage_stock=true --stock_quantity=0 --user=admin
wp wc product_variation create "$hoodie_oos_id" --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=0 --user=admin

echo "Creating variations for 'Software License' (ID: $software_license_id)..."
wp wc product_variation create "$software_license_id" --attributes='[{"name":"License Type","option":"Single Site"}]' --regular_price=59 --downloadable=true --downloads='[{"name":"License File (Single)","file":"/wp-content/uploads/ebook-placeholder.zip"}]' --user=admin
wp wc product_variation create "$software_license_id" --attributes='[{"name":"License Type","option":"5 Sites"}]' --regular_price=129 --downloadable=true --downloads='[{"name":"License File (5 Sites)","file":"/wp-content/uploads/ebook-placeholder.zip"}]' --user=admin
wp wc product_variation create "$software_license_id" --attributes='[{"name":"License Type","option":"Unlimited"}]' --regular_price=249 --downloadable=true --downloads='[{"name":"License File (Unlimited)","file":"/wp-content/uploads/ebook-placeholder.zip"}]' --user=admin

echo "-------------------------------------------------"

# --- 5. Create Grouped Product ---
echo "Creating grouped product..."
grouped_product_ids="$simple_mug_id,$sale_mug_id,$poster_id"
wp wc product create --name="Starter Bundle" --type=grouped --sku="BUNDLE-01" --grouped_products="$grouped_product_ids" --user=admin
echo "-> Created 'Starter Bundle' linking products with IDs: $grouped_product_ids"

echo "================================================="
echo "Script finished successfully!"