# Ensure Apache service is running
service { 'apache2':
  ensure => 'running',
}

# Fix the issue causing 500 error by modifying Apache configuration
file { '/etc/apache2/sites-available/000-default.conf':
  ensure  => file,
  content => '
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # Add the following lines to fix the issue
        <Directory /var/www/html>
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
        </Directory>
</VirtualHost>
',
  notify  => Service['apache2'],
}
