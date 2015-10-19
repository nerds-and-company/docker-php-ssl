FROM itmundi/php-base
MAINTAINER Arjan Kleene <a.kleene@itmundi.nl>

# Add required modules for SSL (these are disabled by default)
RUN a2enmod socache_shmcb ssl

# Update the reference for the certificate file so it uses the .crt extension instead of .pem
RUN sed -i.bak s/snakeoil.pem/snakeoil.crt/ /etc/apache2/sites-available/default-ssl.conf
RUN a2ensite default-ssl

COPY apache-sites/http-redirect.conf /etc/apache2/sites-available/http-redirect.conf
RUN a2ensite http-redirect

# The self-signed certificates use these names in the default apache config
# For this copy to work, these files need to be present in the project root.
ONBUILD COPY ssl-cert-snakeoil.key /etc/ssl/private/
ONBUILD COPY ssl-cert-snakeoil.crt /etc/ssl/certs/

# Copy dep files first so Docker caches the install step if they don't change
ONBUILD COPY composer.lock /var/www/html/
ONBUILD COPY composer.json /var/www/html/
ONBUILD ADD . /var/www/html/

# Run composer install
ONBUILD RUN composer install --prefer-source --no-interaction
