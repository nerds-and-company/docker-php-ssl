FROM itmundi/php

# The self-signed certificates use these names in the default apache config
# For this copy to work, these files need to be present in the project root.
COPY ssl-cert-snakeoil.key /etc/ssl/private/
COPY ssl-cert-snakeoil.crt /etc/ssl/certs/

# Add required modules for SSL (these are disabled by default)
RUN ln -s /etc/apache2/mods-available/socache_shmcb.* /etc/apache2/mods-enabled
RUN ln -s /etc/apache2/mods-available/ssl.* /etc/apache2/mods-enabled

# Update the reference for the certificate file so it uses the .crt extension instead of .pem
RUN sed -i.bak s/snakeoil.pem/snakeoil.crt/ /etc/apache2/sites-available/default-ssl.conf
RUN ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled
