<?php
$_SERVER['SERVER_PORT'] = 443;
require_once(dirname(__DIR__) . '/vendor/autoload.php');
try {

    define('VERSION', '2.3.0.2.4');

    // Configuration
    if (is_file(dirname(__FILE__) . '/config.php')) {
        require_once(dirname(__FILE__) . '/config.php');
    }

    // Startup
    require_once(DIR_SYSTEM . 'startup.php');

    class i extends Controller
    {
        public function start()
        {
            $this->config->set('config_language_id', 1);
            $this->load->model('catalog/ocfilter');
            $this->model_catalog_ocfilter->copyFilters([
                "copy_type" => "checkbox",
                "copy_status" => 1,
                "copy_attribute" => 0,
                "copy_filter" => 0,
                "copy_option" => 1,
                "copy_truncate" => 1,
                "copy_category" => 1,
            ]);
        }
    }

    $registry = new Registry();

    $loader = new Loader($registry);
    $registry->set('load', $loader);

    $config = new Config();
    $registry->set('config', $config);

    $event = new Event($registry);
    $registry->set('event', $event);

    $db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PORT);
    $registry->set('db', $db);

    $registry->set('cache', new \Cache\File());

    $i = new i($registry);
    echo ($i->start());
} catch (Exception $e) {
}
