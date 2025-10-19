# Create "Category A"
docker compose exec -u www-data wordpress /usr/local/bin/wp term create product_cat "Category A" --description="Main testing category A"

docker compose exec -u www-data wordpress /usr/local/bin/wp term create product_cat "Category B" --description="Main testing category B"

docker compose exec -u www-data wordpress /usr/local/bin/wp term create product_cat "Sub-Category C" --description="A child category" --parent="16"

docker compose exec -u www-data wordpress /usr/local/bin/wp term create product_tag "Tag X"

#===============================================================================================
# cat_id_a
# cat_id_b
# cat_id_c
# tag_id

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="Simple Mug" --type=simple --regular_price=15 --manage_stock=true --stock_quantity=50 --categories='[{"id":cat_a_id}]' --sku="MUG-001" --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="Simple Mug (On Sale)" --type=simple --regular_price=18 --sale_price=16 --manage_stock=true --stock_quantity=50 --categories='[{"id":cat_a_id}]' --sku="MUG-002-SALE" --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="Simple Mug (Out of Stock)" --type=simple --regular_price=15 --manage_stock=true --stock_quantity=0 --categories='[{"id":cat_a_id}]' --sku="MUG-003-OOS" --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="Tagged Poster" --type=simple --regular_price=25 --manage_stock=true --stock_quantity=30 --categories='[{"id":cat_id_b}]' --tags='[{"id":tag_id}]' --sku="POSTER-001" --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="Sub-Category T-Shirt" --type=simple --regular_price=22 --manage_stock=true --stock_quantity=40 --categories='[{"id":cat_id_a},{"id":cat_id_c}]' --sku="TSHIRT-SUB-001" --user=admin

docker compose exec wordpress touch /var/www/html/wp-content/uploads/ebook-placeholder.zip

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="Digital eBook" --type=simple --virtual=true --downloadable=true --regular_price=15 --categories='[{"id":cat_id_b}]' --downloads='[{"name":"eBook File","file":"/var/www/html/wp-content/uploads/ebook-placeholder.zip"}]' --sku="EBOOK-001" --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="One-Hour Consultation" --type=simple --virtual=true --regular_price=100 --categories='[{"id":cat_id_b}]' --sku="SVC-001" --user=admin
#============================================================================================
echo "_______________________________________________________________________________________________"

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="Hoodie" --type=variable --categories='[{"id":cat_a_id}]' --attributes='[{"name":"Color","options":["Blue","Green"],"variation":true},{"name":"Size","options":["Small","Large"],"variation":true}]' --sku="HOODIE-PARENT" --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="Hoodie (Mixed State)" --type=variable --categories='[{"id":cat_a_id}]' --attributes='[{"name":"Color","options":["Blue","Green"],"variation":true},{"name":"Size","options":["Small","Large"],"variation":true}]' --sku="HOODIE-MIXED" --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="Hoodie (All Sold Out)" --type=variable --categories='[{"id":cat_a_id}]' --attributes='[{"name":"Color","options":["Blue","Green"],"variation":true},{"name":"Size","options":["Small","Large"],"variation":true}]' --sku="HOODIE-OOS" --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="Software License" --type=variable --virtual=true --categories='[{"id":cat_id_b}]' --attributes='[{"name":"License Type","options":["Single Site","5 Sites","Unlimited"],"variation":true}]' --sku="SOFT-LICENSE" --user=admin

# ##############################################################################################

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Small"}]' --regular_price=40 --manage_stock=true --stock_quantity=20 --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=20 --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Small"}]' --regular_price=40 --manage_stock=true --stock_quantity=20 --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=20 --user=admin


####################################################################################################

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Small"}]' --regular_price=40 --sale_price=35 --manage_stock=true --stock_quantity=15 --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=15 --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Small"}]' --regular_price=40 --manage_stock=true --stock_quantity=0 --user=admin


docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=15 --user=admin



###########################################################################################################

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Small"}]' --regular_price=40 --manage_stock=true --stock_quantity=0 --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Blue"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=0 --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Small"}]' --regular_price=40 --manage_stock=true --stock_quantity=0 --user=admin

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"Color","option":"Green"},{"name":"Size","option":"Large"}]' --regular_price=42 --manage_stock=true --stock_quantity=0 --user=admin


#########################################################################################################

docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"License Type","option":"Single Site"}]' --regular_price=59 --downloadable=true --downloads='[{"name":"License File (Single)","file":"/var/www/html/wp-content/uploads/ebook-placeholder.zip"}]' --user=admin
docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"License Type","option":"5 Sites"}]' --regular_price=129 --downloadable=true --downloads='[{"name":"License File (5 Sites)","file":"/var/www/html/wp-content/uploads/ebook-placeholder.zip"}]' --user=admin
docker compose exec -u www-data wordpress /usr/local/bin/wp wc product_variation create product_id --attributes='[{"name":"License Type","option":"Unlimited"}]' --regular_price=249 --downloadable=true --downloads='[{"name":"License File (Unlimited)","file":"/var/www/html/wp-content/uploads/ebook-placeholder.zip"}]' --user=admin


#############################################################################################################
docker compose exec -u www-data wordpress /usr/local/bin/wp wc product create --name="Starter Bundle" --type=grouped --sku="BUNDLE-01" --grouped_products="11,12,14" --user=admin