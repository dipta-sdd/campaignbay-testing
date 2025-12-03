# docker compose exec db mysql -u root -p
# cd env-02 && docker compose exec wordpress bash
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
which wp
exit

cd .. && cd env-03 && docker compose exec wordpress bash
apt-get update && apt-get install -y nano && nano /var/www/html/wp-config.php


echo "deb http://archive.debian.org/debian/ buster main" > /etc/apt/sources.list && \
echo "deb http://archive.debian.org/debian-security/ buster/updates main" >> /etc/apt/sources.list && \
echo "deb http://archive.debian.org/debian/ buster-updates main" >> /etc/apt/sources.list




// Enable WP_DEBUG mode
define( 'WP_DEBUG', true );

// Enable Debug logging to the /wp-content/debug.log file
define( 'WP_DEBUG_LOG', true );

// Disable display of errors and warnings
define( 'WP_DEBUG_DISPLAY', false );


cd env-01 && docker compose exec wordpress tail -f /var/www/html/wp-content/debug.log