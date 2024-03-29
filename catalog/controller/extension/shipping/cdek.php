<?php
class ControllerExtensionShippingCdek extends Controller {

	public function dev() {
		if(!isset($this->request->get['show'])) {
			echo '<pre>'.print_r($this->session->data['cdek'],1).'</pre>';
			exit;
		}

		switch ($this->request->get['show']) {
			case 'all':
				echo '<pre>'.print_r($this->session->data,1).'</pre>';
				break;
			
			default:
				echo '<pre>'.print_r($this->session->data[$this->request->get['show']],1).'</pre>';
				break;
		}
		
	}
	public function del() {
		if(isset($this->request->get['key'])) {
			unset($this->session->data['cdek'][$this->request->get['key']]);
		} else {
			unset($this->session->data['cdek']);
		}
		
	}

	public function __construct($registry) {
		parent::__construct($registry);
		
		if(!isset($this->session->data['cdek'])) {
			$this->session->data['cdek'] = array();
		}
	}

	public function getPvzList() {
		if(!isset($this->request->post['tariff_type']) || !$this->request->post['tariff_type']) {
			$this->jsonRespone(false, 'Не получен тип тарифа');
		}

		$tariff_type = $this->request->post['tariff_type'];

		if(!isset($this->session->data['cdek']) || !isset($this->session->data['cdek']['pvzlist']) || !$this->session->data['cdek']['pvzlist']) {
			$json['message'] = 'Нет списка пвз';
			$this->jsonRespone(false, 'Нет списка пвз');
		}	

		if ($tariff_type == 'PVZ') {
			$this->jsonRespone(true, 'Список пунктов выдачи', $this->session->data['cdek']['pvzlist']);
		} elseif ($tariff_type == 'POSTOMAT') {
			$this->jsonRespone(true, 'Список пунктов выдачи', $this->session->data['cdek']['postomatlist']);
		} else {
			$this->jsonRespone(true, 'Список пунктов выдачи', array());
		}
	}

	public function selectPvz() {
		$json = array();
		$json['status'] = false;
		$json['message'] = 'Неизвестная ошибка';
		$json['data'] = array();

		if(!isset($this->request->post['pvz_code']) || !$this->request->post['pvz_code']) {
			$this->jsonRespone(false, 'Не получен код пвз');
		}

		$pvz_code = $this->request->post['pvz_code'];

		$tariff = '';
		if(isset($this->request->post['tariff'])) {
			$tariff = $this->request->post['tariff'];
		}

		$this->session->data['cdek']['tariff'] = $tariff;

		$pvz_code = $this->request->post['pvz_code'];

		if(!isset($this->session->data['cdek']) || !isset($this->session->data['cdek']['pvzlist']) || !$this->session->data['cdek']['pvzlist']) {
			$this->jsonRespone(false, 'Нет списка пвз');
		}	

		$this->session->data['cdek']['pvz'] = $pvz_code;

		$pvz_info = '';
		$pvz_address = '';
		if (!empty($this->session->data['cdek']['pvzlist'])) {
			foreach ($this->session->data['cdek']['pvzlist'] as $pvz) {
				if($pvz['Code'] == $pvz_code) {
					$pvz_info = $pvz['Address'].' Телефон: '.$pvz['Phone'];
					$pvz_address = $pvz['Address'];
				}
			}
		}
		if (!empty($this->session->data['cdek']['postomatlist'])) {
			foreach ($this->session->data['cdek']['postomatlist'] as $pvz) {
				if($pvz['Code'] == $pvz_code) {
					$pvz_info = $pvz['Address'].' Телефон: '.$pvz['Phone'];
					$pvz_address = $pvz['Address'];
				}
			}
		}

		$this->session->data['cdek']['pvzaddress'] = $pvz_address;
		$this->session->data['cdek']['pvzinfo'] = $pvz_info;

		// if(isset($this->session->data['order_id'])) {
		// 	$this->load->model('checkout/order');
		// 	$this->model_checkout_order->rememberCdek((int)$this->session->data['order_id']);
		// }

		$this->jsonRespone(true, 'Пвз выбран', array('address' => $pvz_address));
	}

	private function jsonRespone($status, $message, $data = array()) {
		$json = array();
		$json['status'] = $status;
		$json['message'] = $message;
		$json['data'] = $data;

		echo json_encode($json);
		exit;
	}

	public function checkTariffPvz() {
		$tariff = '';
		if(!isset($this->request->post['tariff']) || !$this->request->post['tariff']) {
			$this->jsonRespone(true, 'Тариф не выбран');
		}

		$tariff = $this->request->post['tariff'];
		if(stripos($tariff, 'MRG') !== false) 
		{
			if(!isset($this->session->data['cdek'])) {
				$this->jsonRespone(false, 'Для выбранного тарифа нужно выбрать пвз');
			}

			if(!isset($this->session->data['cdek']['pvz']) || !$this->session->data['cdek']['pvz']) {
				$this->jsonRespone(false, 'Для выбранного тарифа нужно выбрать пвз');
			}
		}

		$this->jsonRespone(true, 'Ок', array('tariff'=>$tariff));
	}

	public function renderTpl($data) {

		$tpl = '';

		$data['selected_pvz'] = array();
		if(isset($this->session->data['cdek'])) 
		{
			if(isset($this->session->data['cdek']['tariff']) && $this->session->data['cdek']['tariff']) 
			{
				if(isset($this->session->data['cdek']['pvz']) && $this->session->data['cdek']['pvz'] && isset($this->session->data['cdek']['pvzaddress']) && $this->session->data['cdek']['pvzaddress']) 
				{
					$data['selected_pvz'][$this->session->data['cdek']['tariff']] = $this->session->data['cdek']['pvzaddress'];
				}
			}
		}

		return $this->load->view('extension/shipping/sdek', $data);
	}


	public function regions() {
		$page = isset($this->request->get['page']) ? (int)$this->request->get['page'] : 1;
		$region_name = isset($this->request->get['term']) ? $this->request->get['term'] : "";

		$this->load->model('extension/shipping/cdek');
		$regions = $this->model_extension_shipping_cdek->getRegions($region_name, $page);

		$json = [];
		foreach ($regions['rows'] as $region) {
			$json[] = ["id" =>  $region['regionName'],"text" =>  $region['regionName']];
		}
		echo json_encode([
			"results" => $json,
			"pagination" => [
				"page" => $page,
				"more" => $regions['more']
			]
		]);
		exit;
	}

	public function cities() {
		$page = isset($this->request->get['page']) ? (int)$this->request->get['page'] : 1;
		$region_name = isset($this->request->get['region']) ? $this->request->get['region'] : "";
		$city_name = isset($this->request->get['term']) ? $this->request->get['term'] : "";

		$this->load->model('extension/shipping/cdek');
		$regions = $this->model_extension_shipping_cdek->getCities($region_name, $city_name, $page);

		$json = [];
		foreach ($regions['rows'] as $region) {
			$json[] = ["id" =>  $region['cityName'],"region_id" =>  $region['regionName'],"text" =>  $region['name']];
		}
		echo json_encode([
			"results" => $json,
			"pagination" => [
				"page" => $page,
				"more" => $regions['more']
			]
		]);
		exit;
	}
}
?>