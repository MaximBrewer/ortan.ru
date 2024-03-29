<?php
require_once(dirname(__DIR__) . '/vendor/autoload.php');
// Version
define('VERSION', '2.3.0.2.4');
define('IS_ADMIN', true);


// Configuration
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../');
$dotenv->load();
if (is_file('config.php')) {
	require_once('config.php');
}
include_once('../la.php'); //YarCHe

// Install
if (!defined('DIR_APPLICATION')) {
	header('Location: ../install/index.php');
	exit;
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');

start('admin');