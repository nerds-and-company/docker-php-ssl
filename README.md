# nerdsandcompany/php-ssl
Nerds and Company PHP + SSL image for Docker
This container extends the `nerdsandcompany/php-base` container. See for more information that container.

## Usage

Make sure you add the following lines to your project's Dockerfile:
```
FROM nerdsandcompany/php-base

# The self-signed certificates use these names in the default apache config
# For this copy to work, these files need to be present in the project root.
ONBUILD COPY ssl-cert-snakeoil.key /etc/ssl/private/
ONBUILD COPY ssl-cert-snakeoil.crt /etc/ssl/certs/

# Run composer install if composer.json is present
ONBUILD COPY composer.json /var/www/html/
ONBUILD COPY composer.lock /var/www/html/
ONBUILD RUN [ ! -e composer.json ] || composer install --prefer-source --no-interaction

# Copy dep files first so Docker caches the install step if they don't change
ONBUILD ADD . /var/www/html/
```

## Additionally contains

### services
 - SSL (Apache)

### PHP Extensions
 - socache_shmcb
 - ssl

## See also
- [`nerdsandcompany/php-base`](https://github.com/nerds-and-company/docker-php-base)

## License
[MIT](LICENSE)
