<?php
class ModelSettingAmocrm extends Model
{
	public function addModule($code, $data)
	{
		if ($data_update = $this->getModule($code)) {
			foreach ($data as $key => $value) {
				$data_update[$key] = $value;
			}
			$this->db->query("DELETE FROM oc_module WHERE code='" . $this->db->escape($code) . "'");
			$this->db->query("INSERT INTO `" . DB_PREFIX . "module` SET `name` = '" . $this->db->escape($data['name']) . "', `code` = '" . $this->db->escape($code) . "', `setting` = '" . $this->db->escape(json_encode($data_update)) . "'");
		} else {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "module` SET `name` = '" . $this->db->escape($data['name']) . "', `code` = '" . $this->db->escape($code) . "', `setting` = '" . $this->db->escape(json_encode($data)) . "'");
		}
		return $this->db->getLastId();
	}
	public function getModule($code)
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "module WHERE code = '" . $this->db->escape($code) . "'");
		if ($query->row) {
			$data = json_decode($query->row['setting'], true);
			$data['client_secret'] = 'cyBpWyP4DvqvNDt84zYMoymQ3rziSojMg6YcaGLY71JBQJQeARt02W9q7PL7PFbC';
			return $data;
		} else {
			return false;
		}
	}

	public function access_token()
	{
		$data = $this->getModule('amocrm');
		/** Соберем данные для запроса */
		$url = new Url(HTTP_SERVER, $this->config->get('config_secure') ? HTTP_SERVER : HTTPS_SERVER);

		if (!isset($data['client_secret'])) {
			return false;
		}
		$data = [
			'client_id' => trim($data['client_id']),
			'client_secret' => trim($data['client_secret']),
			'grant_type' => 'authorization_code',
			'code' => trim($data['code']),
			'redirect_uri' => $url->link('extension/module/amocrm'),
		];
		$response = $this->curl_post('/oauth2/access_token', $data, false);
		$response['name'] = 'amocrm';
		return $this->addModule('amocrm', $response);
	}
	protected function refresh_token()
	{
		$data = $this->getModule('amocrm');
		$url = new Url(HTTP_SERVER, $this->config->get('config_secure') ? HTTP_SERVER : HTTPS_SERVER);
		$data = [
			'client_id' => trim($data['client_id']),
			'client_secret' => trim($data['client_secret']),
			'grant_type' => 'refresh_token',
			'refresh_token' => trim($data['refresh_token']),
			'redirect_uri' => $url->link('extension/module/amocrm'),
		];
		$response = $this->curl_post('/oauth2/access_token', $data, false);
		die;
		$response['name'] = 'amocrm';
		$this->addModule('amocrm', $response);
		return $response;
	}
	public function curl_post($method, $post = false, $token = true)
	{
		$data = $this->getModule('amocrm');
		$link = 'https://' . $data['referer'] . $method;
		$curl = curl_init(); //Сохраняем дескриптор сеанса cURL
		$headers = [
			'Content-Type:application/json'
		];
		if (!$data['access_token']) $data['access_token'] = 'def50200774253c4175b75a1be8a6f8bcd11af5b4b895a765ab263302413889927f3de57c7fcfe4750671d41b6e31b0e1e5d795c969d43dcca038fbde8d8f8c14f261315f3853fd26300c3af156e22f0a46d13253db5d4d540d57d78191197d14b2fa643df62cc2189bda75c675929a099e1e52863901393cdde72eed30640106890381a8df0c077981a24309b510abcbfebec234efaa6c3d095eaadbc61a21358acb44de0f1a069517aeedb532fc3aa24ffd46c08ddb51627cc587bc0fbf42d4f2cd23fa016c92ce49ed20a2a6e446d882b98740d030ca62ecb35f54c61018247234e1424fe710bc4c02910e0a19caee556c5a58565dcf41fbfac0dc4163462dcf432ee387f39c6fd1f71bf169ab26ab3aafca1006f48805a6265b9c183a0e97d25557e961f7d309c4e71a6a1384309a68526755e3a5825bb38ad01a32260b0b27e470fce2ac6dfe6a6496448c51049a2e8ba48cf53a792b7436dd45c5ed9d4d69ea2b781a652073e71cae55e7c7642c0dc2312f896204bbbb037a68d2eca25e27065a15154d68b435284b53cd8de6122d717a83a9af2dca0fa33f59e414dcdd131bbf9cdede5e816bc0d9183543b881e265b604a2eb49b9afd882232dfdbc27edcf691a4b62aeece6c6281ef994bd20a06f8ec9fbfca33b4c9c806e52833e5e184479992';
		if ($token) {
			$headers[] = 'Authorization: Bearer ' . $data['access_token'];
		}
		var_dump($headers);

		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_USERAGENT, 'amoCRM-oAuth-client/1.0');
		curl_setopt($curl, CURLOPT_URL, $link);
		curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($curl, CURLOPT_HEADER, false);
		if ($post) {
			curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
			curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($post));
		}
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 1);
		curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2);
		$out = json_decode(curl_exec($curl), true);
		$code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		$code = (int)$code;
		var_dump($out);
		// if (isset($out['response']['error_code'])) {
		// 	if ($out['response']['error_code'] == '110') {
		// 		$data_refresh = $this->refresh_token();
		// 		if (isset($data_refresh['expires_in'])) {
		// 			var_dump($data_refresh);
		// 			return $this->curl_post($method, $post);
		// 		}
		// 	}
		// }
		var_dump($code);
		try {
			if ($code < 200 || $code > 204) {
				throw new Exception(isset($errors[$code]) ? $errors[$code] : 'Undefined error', $code);
			}
		} catch (\Exception $e) {
			var_dump($e->getMessage());
			return false;
		}
		return $out;
	}
	public function addOrder($orders)
	{
		$this->load->model('checkout/order');
		$setting = $this->getModule('amocrm');
		$order = $this->model_checkout_order->getOrder((int)$orders);
		$leads = [
			"name" => "Заказ №" . $order['order_id'],
			"price" => (int)$order['total'],
			'_embedded' => [
				'contacts' => []
			]
		];
		$leads['_embedded']['contacts'][0]['first_name'] = $order['firstname'];
		$leads['_embedded']['contacts'][0]['last_name'] = $order['lastname'];
		foreach ($setting['contacts'] as $key => $value) {
			$leads['_embedded']['contacts'][0]['custom_fields_values'][] = 	[
				'field_id' => (int)$value['amo_columns'],
				'values' => [
					["value" => $order[$value['shop_columns']]]
				]
			];
		}
		foreach ($setting['leads'] as $key => $value) {
			$leads['custom_fields_values'][] = 	[
				'field_id' => (int)$value['amo_columns'],
				'values' => [
					["value" => $order[$value['shop_columns']]]
				]
			];
		}
		$leads['_embedded']['contacts'][0]['custom_fields_values'][] = [
			"field_code" => "EMAIL",
			'values' => [["enum_code" => "WORK", "value" => $order['email']]]
		];
		$leads['_embedded']['contacts'][0]['custom_fields_values'][] = [
			"field_code" => "PHONE",
			'values' => [["enum_code" => "WORK", "value" => $order['telephone']]]
		];


		if (isset($setting['order_status'][$order['order_status_id']]) && $setting['order_status'][$order['order_status_id']] != "") {
			$sert = explode("|", $setting['order_status'][$order['order_status_id']]);


			$leads['custom_fields_values'][] = 	[
				'field_id' => (int)$sert[0],
				'values' => [
					["enum_id" => (int)$sert[1]]
				]
			];
		}
		$leads_add = $this->curl_post('/api/v4/leads/complex', [$leads]);
		if (!isset($leads_add[0]['id'])) {
			return false;
		}
		// Товар к Сделки
		$product_amo = $this->curl_post('/api/v2/products_settings');
		$link_add = [];
		if (isset($product_amo['is_enabled']) && $product_amo['is_enabled']) {
			$getOrderProducts = $this->model_checkout_order->getOrderProducts((int)$orders);
			$catalog_id = $product_amo['catalog_id'];
			$catalog_elements['add'] = [];
			foreach ($getOrderProducts as $key => $value) {
				if (isset($setting['other']['status']) && $setting['other']['status'] == 1) {
					$options = [];
					foreach ($this->model_checkout_order->getOrderOptions($value['order_id'], $value['order_product_id']) as $key_option => $value_option) {
						$options[] = "{$value_option['name']}: {$value_option['value']}";
					}
					if (count($options) >= 1) {
						$value['name'] = "{$value['name']}(" . implode(" | ", $options) . ")";
					}
				}
				$catalog_elements['add'][] = [
					'catalog_id' => $catalog_id,
					'name' => $value['name'],
					'request_id' => $value['quantity'],
					'custom_fields' => [
						[
							'code' => 'SKU',
							'values' => [
								['value' => $value['model']],
							]
						],
						[
							'code' => 'PRICE',
							'values' => [
								['value' => (string)number_format($value['price'], 0)],
							]
						],
						[
							'code' => 'DESCRIPTION',
							'values' => [
								['value' => ''],
							]
						],
						[
							'code' => 'EXTERNAL_ID',
							'values' => [
								['value' => $value['product_id']],
							]
						]
					]
				];
			}
			$product_add = $this->curl_post('/api/v2/catalog_elements', $catalog_elements);
			foreach ($product_add['_embedded']['items'] as $key => $value) {
				$link_add[] = [
					'to_entity_id' => $value['id'],
					"to_entity_type" => "catalog_elements",
					'metadata' => [
						// 'quantity'=> (int)$q[$value['custom_fields'][3]['values'][0]['value']],
						'quantity' => $value['request_id'],
						'catalog_id' => $catalog_id,
					]
				];
			}
		}
		if (isset($setting['task']['status']) && $setting['task']['status'] == 1) {
			$task = [];
			$task[0]['text'] = $setting['task']['text'];
			$task[0]['entity_type'] = 'leads';
			if ($setting['task']['responsible_user_id'] != "") {
				$task[0]['responsible_user_id'] = $setting['task']['responsible_user_id'];
			}
			$task[0]['entity_id'] = $leads_add[0]['id'];
			$task[0]['complete_till'] = time() + (60 * (int)$setting['task']['time']);
			$task_amo = $this->curl_post('/api/v4/tasks', $task);
		}
		if (count($link_add) >= 1) {
			$this->curl_post("/api/v4/leads/{$leads_add[0]['id']}/link", $link_add);
		}
		return true;
	}
	public function catalog_elements($catalog_elements)
	{
		return $this->curl_post('/api/v2/catalog_elements', $catalog_elements);
	}
	public function LinkAdd($leads_id, $link_add)
	{
		return $this->curl_post("/api/v4/leads/$leads_id/link", $link_add);
	}
	public function getProductsSettings()
	{
		return $this->curl_post('/api/v2/products_settings');
	}
	public function addLeadsComplex($leads)
	{
		return $this->curl_post('/api/v4/leads/complex', [$leads]);
	}
}
