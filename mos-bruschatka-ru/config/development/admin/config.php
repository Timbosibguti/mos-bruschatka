<?php
// HTTP
define('HTTP_SERVER', 'http://mos-bruschatka.doecker/admin/');
define('HTTP_CATALOG', 'http://mos-bruschatka.docker/');
// HTTPS
define('HTTPS_SERVER', 'https://mos-bruschatka.docker/admin/');
define('HTTPS_CATALOG', 'https://mos-bruschatka.docker/');
// DIR
define('DIR_APPLICATION', '/var/www/public/admin/');
define('DIR_SYSTEM', '/var/www/public/system/');
define('DIR_IMAGE', '/var/www/assets/image/');
define('DIR_LANGUAGE', DIR_APPLICATION . 'language/');
define('DIR_TEMPLATE', DIR_APPLICATION . 'view/template/');
define('DIR_CONFIG', DIR_SYSTEM . 'config/');
define('DIR_CACHE', DIR_SYSTEM . 'storage/cache/');
define('DIR_DOWNLOAD', DIR_SYSTEM . 'storage/download/');
define('DIR_LOGS', DIR_SYSTEM . 'storage/logs/');
define('DIR_MODIFICATION', DIR_SYSTEM . 'storage/modification/');
define('DIR_UPLOAD', DIR_SYSTEM . 'storage/upload/');
define('DIR_CATALOG', '/var/www/public/catalog/');

// DB
define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'mysql');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', 'qwerty');
define('DB_DATABASE', 'host1753147_bruschatka');
define('DB_PORT', '3306');
define('DB_PREFIX', 'oc_');
