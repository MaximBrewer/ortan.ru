<?php
$_SERVER['SERVER_PORT'] = 443;
$_GET['route'] = 'common/sitemap/create';
$_REQUEST['route'] = 'common/sitemap/create';


require_once(__DIR__ . '/vendor/autoload.php');
// Version
define('VERSION', '2.3.0.2.4');
// Configuration
if (is_file(dirname(__FILE__) . '/config.php')) {
	require_once(dirname(__FILE__) . '/config.php');
}

// Install
if (!defined('DIR_APPLICATION')) {
	header('Location: install/index.php');
	exit;
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');

start('catalog');
