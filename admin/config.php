<?php
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../');
$dotenv->load();

// HTTP
define('HTTP_SERVER', $_ENV['HTTP_SERVER'] .'admin/');
define('HTTP_CATALOG', $_ENV['HTTP_SERVER']);

// HTTPS
define('HTTPS_SERVER', $_ENV['HTTPS_SERVER'] .'admin/');
define('HTTPS_CATALOG', $_ENV['HTTPS_SERVER']);

// DIR
define('DIR_ROOT_PATH', dirname(__DIR__));

define('DIR_APPLICATION', DIR_ROOT_PATH . '/admin/');
define('DIR_SYSTEM', DIR_ROOT_PATH . '/system/');
define('DIR_IMAGE', DIR_ROOT_PATH . '/image/');
define('DIR_LANGUAGE', DIR_ROOT_PATH . '/admin/language/');
define('DIR_TEMPLATE', DIR_ROOT_PATH . '/admin/view/template/');
define('DIR_CONFIG', DIR_ROOT_PATH . '/system/config/');
define('DIR_CACHE', DIR_ROOT_PATH . '/system/storage/cache/');
define('DIR_DOWNLOAD', DIR_ROOT_PATH . '/system/storage/download/');
define('DIR_LOGS', DIR_ROOT_PATH . '/system/storage/logs/');
define('DIR_MODIFICATION', DIR_ROOT_PATH . '/system/storage/modification/');
define('DIR_UPLOAD', DIR_ROOT_PATH . '/system/storage/upload/');
define('DIR_CATALOG', DIR_ROOT_PATH . '/catalog/');

// DB
define('DB_DRIVER', $_ENV['DB_DRIVER']);
define('DB_HOSTNAME', $_ENV['DB_HOSTNAME']);
define('DB_USERNAME', $_ENV['DB_USERNAME']);
define('DB_PASSWORD', $_ENV['DB_PASSWORD']);
define('DB_DATABASE', $_ENV['DB_DATABASE']);
define('DB_PORT', $_ENV['DB_PORT']);
define('DB_PREFIX', $_ENV['DB_PREFIX']);

// Redis
define('CACHE_HOSTNAME', $_ENV['CACHE_HOSTNAME']);
define('CACHE_PORT', $_ENV['CACHE_PORT']);
define('CACHE_PREFIX', 'oc_');

// OpenCartForum API
define('OPENCARTFORUM_SERVER', 'https://opencartforum.com/');

define('CATEGORY_BESTSELLER', $_ENV['CATEGORY_BESTSELLER']);
define('CATEGORY_NOVELTY', $_ENV['CATEGORY_NOVELTY']);
define('CATEGORY_DISCOUNTS', $_ENV['CATEGORY_DISCOUNTS']);