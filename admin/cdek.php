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

            $this->load->model('extension/module/cdek_integrator');
            // $this->load->language('extension/module/cdek_integrator');
    
            ini_set('max_execution_time', 900);
    
            $countries = array(
                'RU', 'AM', 'BY', 'KZ', 'KG', 'UA', 'UZ'
            );
    
            $this->model_extension_module_cdek_integrator->deleteCities();
    
            foreach ($countries as $country) {
    
                
                for ($i = 0; ; $i++) {
    
                    $url = 'https://integration.cdek.ru/v1/location/cities/json?size=1000&countryCode=' . $country . '&page=' . $i;  
                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_URL, $url);
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                    curl_setopt($ch, CURLOPT_HEADER, FALSE);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
                    curl_setopt($ch, CURLOPT_TIMEOUT, 50);
                    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 50);
                                
                    $out = curl_exec($ch);
    
                    $out = json_decode($out, true);
    
                    $data = array();
                    
                    foreach ($out as $value) {
                        if (!empty($value['cityCode'])) {
                            if (!empty($value['region'])) {
                                $name = $value['cityName'] . ', ' . $value['region'];
                                $region = $value['region'];
                            } else {
                                $name = $value['cityName'];
                                $region = '';
                            }
                            if (!in_array($value['cityCode'], $check_unique)) {
                                $data[] = array(
                                    'id' => $value['cityCode'],
                                    'name' => $name,
                                    'cityName' => $value['cityName'],
                                    'regionName' => $region,
                                );
                                
                                $check_unique[] = $value['cityCode'];
                            }
                        }
                    }
    
                    if (count($out) < 900) {
                        break;
                    }
    
                    $this->model_extension_module_cdek_integrator->addCities($data, $country);
                }
            }
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
