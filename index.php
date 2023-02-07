<?php

include_once('./la.php'); //YarCHe
\la::start('vendors');
$startApp = microtime(true);
require_once(__DIR__ . '/vendor/autoload.php');
\la::stop('vendors');
// Version
define('VERSION', '2.3.0.2.4');

// Configuration
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();
if (is_file('config.php')) {
	require_once('config.php');
}

ini_set('session.gc_maxlifetime', 52 * 7 * 24 * 3600);
ini_set('session.cookie_lifetime', 52 * 7 * 24 * 3600);


// Install
if (!defined('DIR_APPLICATION')) {
	header('Location: install/index.php');
	exit;
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');

start('catalog');

\la::stop();
