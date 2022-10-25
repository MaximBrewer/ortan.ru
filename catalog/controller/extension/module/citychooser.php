<?php
class ControllerExtensionModuleCityChooser extends Controller
{
    public function index($setting)
    {
        global $cityArray;

        $this->load->language('extension/module/citychooser');
        $this->load->model('extension/module/citychooser/city');

        $results = $this->model_extension_module_citychooser_city->getBaseCities();

        $data['city'] = $cityArray;


        if ($results) {
            foreach ($results as $result) {
                $data['cities'][] = ['city_id' => $result['city_id'], 'city_code' => $result['code'], 'city' => $result['city'], 'address' => $result['address'], 'geocode' => ['geo_lat' => $result['geo_lat'], 'geo_lon' => $result['geo_lon']]];
            }
            $this->config->set('locationn', $data['cities']);
        }

        $data['action'] = $this->url->link('extension/module/citychooser/set_city', 'city_code='.CITY_CODE, isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1')));
        if (!isset($this->request->get['route'])) {
            $data['redirect'] = $this->url->link('common/home');
        } else {
            $url_data = $this->request->get;

            unset($url_data['_route_']);

            $route = $url_data['route'];

            unset($url_data['route']);

            $url = '';

            if ($url_data) {
                $url = '&' . urldecode(http_build_query($url_data, '', '&'));
            }

            $data['redirect'] = $this->url->link($route, $url, isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1')));
        }

        return $this->load->view('extension/module/citychooser', $data);
    }

    private function str_replace_once($search, $replace, $text)
    {
        $pos = strpos($text, $search);
        return $pos !== false ? substr_replace($text, $replace, $pos, strlen($search)) : $text;
    }

    public function set_city()
    {
        $url = $this->request->post['redirect'];
        $values = parse_url($url);
        
        if (defined('CITY_CODE')) {
            if (strstr($values['path'], CITY_CODE . '/'))
                $path = $this->str_replace_once(CITY_CODE . '/', '', $values['path']);
            else
                $path = $this->str_replace_once(CITY_CODE, '', $values['path']);
        } elseif ($values['path'] === '/') {
            $path = '';
        } else {
            $path = $values['path'];
        }

        if ($path == '/index.php') {
            if ($values['query']) {
                $path = '/index.php?' . $values['query'];
            } else {
                $path = str_replace('/index.php', '', $path);
            }
        }
		setcookie('city_code', $this->request->post['set_city_code'], time() + 60 * 60 * 24 * 30, '/', $this->request->server['HTTP_HOST']);
        if (isset($this->request->post['redirect'])) {
            $skp = false;
            global $excludesUrls;
            foreach ($excludesUrls as $exclude) 
                if (strpos($path, $exclude) === 0) $skp = true;

            $path = $skp ? $path : ($this->request->post['set_city_code'] == 'msk' ? '' : '/' . $this->request->post['set_city_code']) . $path;

            $this->response->redirect($values['scheme'] . '://' . $values['host'] . ($values['port'] != 80 && $values['port'] != 443 ? ':' . $values['port'] : '') . $path);
        } else {
            $this->response->redirect($this->url->link('common/home'));
        }
    }



    public function autocomplete()
    {
        $json = array();

        if (isset($this->request->get['filter_city'])) {
            $this->load->model('extension/module/citychooser/city');

            if (isset($this->request->get['filter_city'])) {
                $filter_city = $this->request->get['filter_city'];
            } else {
                $filter_city = '';
            }

            if (isset($this->request->get['limit'])) {
                $limit = $this->request->get['limit'];
            } else {
                $limit = $this->config->get('config_limit_autocomplete');
            }

            $filter_data = array(
                'filter_city'  => $filter_city,
                'start'        => 0,
                'limit'        => $limit
            );

            $results = $this->model_extension_module_citychooser_city->getCities($filter_data);

            foreach ($results as $result) {

                $json[] = array(
                    'city_code' => $result['city_code'],
                    'city'       => strip_tags(html_entity_decode($result['city'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}
