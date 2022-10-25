<?php
class ControllerCheckoutCheckout extends Controller
{
	public function info()
	{
		$this->response->setOutput($this->index(true));
	}

	public function index($jsonOutput = false)
	{
		if (isset($this->session->data['step'])) {
			$data['step'] = $this->session->data['step'];
		} else {
			$data['step'] = 0;
		}

		$this->document->addScript('//api-maps.yandex.ru/2.1/?lang=ru_RU&ns=cdekymap');

		if (isset($this->session->data['shipping_address'])) {
			$this->session->data['shipping_address']['zone_id'] = '';
			$this->session->data['shipping_address']['zone_code'] = '';
		}

		if (isset($this->session->data['shipping_address'])) {
			$this->session->data['payment_address'] = $this->session->data['shipping_address'];
		}

		if (isset($this->session->data['error'])) {
			$data['error_warning'] = $this->session->data['error'];
			unset($this->session->data['error']);
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['error2'])) {
			$data['error_warning2'] = $this->session->data['error2'];
			unset($this->session->data['error2']);
		} else {
			$data['error_warning2'] = '';
		}


		if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
			$data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
		} else {
			$data['attention'] = '';
		}

		if (isset($this->request->post['fio'])) {
			if($this->request->post['fio']) $this->cart->setFIO($this->request->post['fio']);
			$data['step'] = 1;
			$fio = explode(" ", preg_replace('/\s+/', ' ', $this->request->post['fio']));
			$this->session->data['firstname'] = $fio[0];
			$this->session->data['lastname'] = isset($fio[1]) ? $fio[1] : "";
		}

		if (isset($this->request->post['telephone'])) {
			if($this->request->post['telephone']) $this->cart->setPhone($this->request->post['telephone']);
			$data['step'] = 1;
			$this->session->data['telephone'] = $this->request->post['telephone'];
		}

		if (isset($this->request->post['email'])) {
			if($this->request->post['email']) $this->cart->setEmail($this->request->post['email']);
			$data['step'] = 1;
			$this->session->data['email'] = $this->request->post['email'];
		}

		$this->session->data['zone_id'] = '';

		if (isset($this->request->post['city'])) {

			unset($this->session->data["cdek"]["pvz"]);
			unset($this->session->data["cdek"]["pvzaddress"]);
			unset($this->session->data["cdek"]["pvzinfo"]);

			$this->session->data['city'] = $this->request->post['city'];

			if (isset($this->session->data['shipping_address'])) {
				$this->session->data['shipping_address']['city'] = $this->session->data['city'] ? $this->session->data['city'] : ($this->session->data['shipping_address']['city'] ?? "");
				$this->session->data['shipping_address']['custom_field'][1] = $this->session->data['city'] ? $this->session->data['city'] : ($this->session->data['shipping_address']['custom_field'][1] ?? "");
			}

			if (isset($this->session->data['payment_address'])) {
				$this->session->data['payment_address']['city'] = $this->session->data['city'] ? $this->session->data['city'] : ($this->session->data['payment_address']['city'] ?? "");
				$this->session->data['payment_address']['custom_field'][1] = $this->session->data['city'] ? $this->session->data['city'] : ($this->session->data['payment_address']['custom_field'][1] ?? "");
			}
		}
		if (isset($this->request->post['zone'])) {
			$this->session->data['zone'] = $this->request->post['zone'];

			if (isset($this->session->data['shipping_address'])) {
				$this->session->data['shipping_address']['zone'] = $this->session->data['zone'] ? $this->session->data['zone'] : ($this->session->data['shipping_address']['zone'] ?? "");
				$this->session->data['shipping_address']['custom_field'][2] = $this->session->data['zone'] ? $this->session->data['zone'] : ($this->session->data['shipping_address']['custom_field'][2] ?? "");
			}

			if (isset($this->session->data['payment_method'])) {
				$this->session->data['payment_address']['zone'] = $this->session->data['zone'] ? $this->session->data['zone'] : ($this->session->data['payment_address']['zone'] ?? "");
				$this->session->data['payment_address']['custom_field'][2] = $this->session->data['zone'] ? $this->session->data['zone'] : ($this->session->data['payment_address']['custom_field'][2] ?? "");
			}
		}
		if (isset($this->request->post['address'])) {
			$this->session->data['address'] = $this->request->post['address'];
		}


		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home'),
			'text' => $this->language->get('text_home')
		);

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('checkout/cart'),
			'text' => $this->language->get('heading_title')
		);


		if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {

			$this->load->language('checkout/checkout');

			$this->document->setTitle($this->language->get('heading_title'));

			$this->document->addScript('/catalog/view/javascript/jquery/datetimepicker/moment.js');
			$this->document->addScript('/catalog/view/javascript/jquery/datetimepicker/locale/' . $this->session->data['language'] . '.js');
			$this->document->addScript('/catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
			$this->document->addStyle('/catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

			// Required by klarna
			if ($this->config->get('klarna_account') || $this->config->get('klarna_invoice')) {
				$this->document->addScript('http://cdn.klarna.com/public/kitt/toc/v1.0/js/klarna.terms.min.js');
			}

			$data['breadcrumbs'] = array();

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_home'),
				'href' => $this->url->link('common/home')
			);

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_cart'),
				'href' => $this->url->link('checkout/checkout')
			);

			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_checkout_option'] = sprintf($this->language->get('text_checkout_option'), 1);
			$data['text_checkout_account'] = sprintf($this->language->get('text_checkout_account'), 2);
			$data['text_checkout_payment_address'] = sprintf($this->language->get('text_checkout_payment_address'), 2);
			$data['text_checkout_shipping_address'] = sprintf($this->language->get('text_checkout_shipping_address'), 3);
			$data['text_checkout_shipping_method'] = sprintf($this->language->get('text_checkout_shipping_method'), 4);

			if ($this->cart->hasShipping()) {
				$data['text_checkout_payment_method'] = sprintf($this->language->get('text_checkout_payment_method'), 5);
				$data['text_checkout_confirm'] = sprintf($this->language->get('text_checkout_confirm'), 6);
			} else {
				$data['text_checkout_payment_method'] = sprintf($this->language->get('text_checkout_payment_method'), 3);
				$data['text_checkout_confirm'] = sprintf($this->language->get('text_checkout_confirm'), 4);
			}



			if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
				$data['error_warning'] = $this->language->get('error_stock');
			} elseif (isset($this->session->data['error'])) {
				$data['error_warning'] = $this->session->data['error'];

				unset($this->session->data['error']);
			}

			if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
				$data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
			} else {
				$data['attention'] = '';
			}

			if (isset($this->session->data['success'])) {
				$data['success'] = $this->session->data['success'];

				unset($this->session->data['success']);
			} else {
				$data['success'] = '';
			}

			$data['action'] = $this->url->link('checkout/confirm', '', true);

			if ($this->config->get('config_cart_weight')) {
				$data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
			} else {
				$data['weight'] = '';
			}

			$this->load->model('tool/image');
			$this->load->model('tool/upload');

			$data['products'] = array();

			$products = $this->cart->getProducts();

			foreach ($products as $product) {
				$product_total = 0;

				foreach ($products as $product_2) {
					if ($product_2['product_id'] == $product['product_id']) {
						$product_total += $product_2['quantity'];
					}
				}

				if ($product['minimum'] > $product_total) {
					$data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
				}

				if ($product['image']) {
					$image = $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_cart_width'), $this->config->get($this->config->get('config_theme') . '_image_cart_height'));
				} else {
					$image = '';
				}

				$option_data = array();

				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

						if ($upload_info) {
							$value = $upload_info['name'];
						} else {
							$value = '';
						}
					}

					$option_data[] = array(
						'name'  => $option['name'],
						'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
					);
				}

				// Display prices
				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$unit_price = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));

					$price = $this->currency->format($unit_price, $this->session->data['currency']);
					$total = $this->currency->format($unit_price * $product['quantity'], $this->session->data['currency']);
				} else {
					$price = false;
					$total = false;
				}

				$recurring = '';

				if ($product['recurring']) {
					$frequencies = array(
						'day'        => $this->language->get('text_day'),
						'week'       => $this->language->get('text_week'),
						'semi_month' => $this->language->get('text_semi_month'),
						'month'      => $this->language->get('text_month'),
						'year'       => $this->language->get('text_year'),
					);

					if ($product['recurring']['trial']) {
						$recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
					}

					if ($product['recurring']['duration']) {
						$recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					} else {
						$recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					}
				}

				$data['products'][] = array(
					'cart_id'   => $product['cart_id'],
					'thumb'     => $image,
					'name'      => $product['name'],
					'model'     => $product['model'],
					'option'    => $option_data,
					'minimum' => $product['minimum'],
					'recurring' => $recurring,
					'quantity'  => $product['quantity'],
					'stock'     => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
					'reward'    => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
					'price'     => $price,
					'total'     => $total,
					'href'      => $this->url->link('product/product', 'product_id=' . $product['product_id'])
				);
			}

			// Gift Voucher
			$data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $key => $voucher) {
					$data['vouchers'][] = array(
						'key'         => $key,
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'], $this->session->data['currency']),
						'remove'      => $this->url->link('checkout/cart', 'remove=' . $key)
					);
				}
			}

			// Totals
			$this->load->model('extension/extension');

			$totals = array();
			$taxes = $this->cart->getTaxes();
			$total = 0;

			// Because __call can not keep var references so we put them into an array. 			
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);

			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$sort_order = array();

				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('extension/total/' . $result['code']);

						// We have to put the totals in an array so that they pass by reference.
						$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
					}
				}

				$sort_order = array();

				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $totals);
			}

			$data['totals'] = array();

			foreach ($totals as $total) {
				$data['totals'][] = array(
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value'], $this->session->data['currency'])
				);
			}

			$data['continue'] = $this->url->link('common/home');

			$data['checkout'] = $this->url->link('checkout/checkout', '', true);

			$this->load->model('extension/extension');

			$data['modules'] = array();

			$files = glob(DIR_APPLICATION . '/controller/extension/total/*.php');

			if ($files) {
				foreach ($files as $file) {
					$result = $this->load->controller('extension/total/' . basename($file, '.php'));

					if ($result) {
						$data['modules'][] = $result;
					}
				}
			}

			$data['logged'] = $this->customer->isLogged();


			$data['zone_id'] = '';

			if (isset($this->session->data['city'])) {
				$data['city'] = $this->session->data['city'];
			} else {
				$data['city'] = '';
			}

			if (isset($this->session->data['zone'])) {
				$data['zone'] = $this->session->data['zone'];
			} else {
				$data['zone'] = '';
			}

			if (isset($this->session->data['address'])) {
				$data['address'] = $this->session->data['address'];
			} else {
				$data['address'] = '';
			}

			if (isset($this->session->data['firstname'])) {
				$data['firstname'] = $this->session->data['firstname'];
			} else {
				$data['firstname'] = '';
			}

			if (isset($this->session->data['lastname'])) {
				$data['lastname'] = $this->session->data['lastname'];
			} else {
				$data['lastname'] = '';
			}

			if (isset($this->session->data['email'])) {
				$data['email'] = $this->session->data['email'];
			} else {
				$data['email'] = '';
			}

			if (isset($this->session->data['telephone'])) {
				$data['telephone'] = $this->session->data['telephone'];
			} else {
				$data['telephone'] = '';
			}

			if (isset($this->session->data['comment'])) {
				$data['comment'] = $this->session->data['comment'];
			} else {
				$data['comment'] = '';
			}

			if ($data['logged']) {
				$this->load->model('account/address');
				$results = $this->model_account_address->getAddresses();
				$this->customer->getAddressId();
				$data['email'] = $data['firstname'] ? $data['email'] : $this->customer->getEmail();
				$data['telephone'] = $data['firstname'] ? $data['telephone'] : $this->customer->getTelephone();
				foreach ($results as $result) {
					if ($this->customer->getAddressId() == $result['address_id']) {

						$adr = $this->model_account_address->getAddress($result['address_id']);
						$data['zone'] = $data['zone'] ? $data['zone'] : $adr['custom_field'][2];
						$data['city'] = $data['city'] ? $data['city'] : $adr['custom_field'][1];
						$data['address'] = $data['address'] ? $data['address'] : $result['address_1'];
						$data['firstname'] = $data['firstname'] ? $data['firstname'] : $result['firstname'];
						$data['lastname'] = $data['lastname'] ? $data['lastname'] : $result['lastname'];
						break;
					}
				}
			} else {
				if (!isset($this->session->data['guest'])) $this->session->data['guest'] = [];
				$this->session->data['guest']['customer_id'] = 0;
				$this->session->data['guest']['customer_group_id'] = 1;
				$this->session->data['guest']['firstname'] = isset($this->session->data['firstname'])  ? $this->session->data['firstname'] : "";
				$this->session->data['guest']['lastname'] =  isset($this->session->data['lastname'])  ? $this->session->data['lastname'] : "";
				$this->session->data['guest']['email'] =  isset($this->session->data['email'])  ? $this->session->data['email'] : "";
				$this->session->data['guest']['telephone'] =  isset($this->session->data['telephone'])  ? $this->session->data['telephone'] : "";
				$this->session->data['guest']['fax'] = "";
				$this->session->data['guest']['custom_field'] = [];
			}

			if (isset($data['firstname'])) {
				$this->session->data['shipping_address']['firstname'] = $this->session->data['payment_address']['firstname'] = $data['firstname'];
			}
			if (isset($data['lastname'])) {
				$this->session->data['shipping_address']['lastname'] = $this->session->data['payment_address']['lastname'] = $data['lastname'];
			}

			$this->session->data['shipping_address']['zone_id'] = $this->session->data['payment_address']['zone_id'] = '';

			if (isset($this->session->data['city'])) {
				$this->session->data['shipping_address']['city'] = $this->session->data['payment_address']['city'] = $this->session->data['city'];
			}
			if (isset($this->session->data['zone'])) {
				$this->session->data['shipping_address']['zone'] = $this->session->data['payment_address']['zone'] = $this->session->data['zone'];
			}
			if (isset($this->session->data['address'])) {
				$this->session->data['shipping_address']['address_1'] = $this->session->data['payment_address']['address_1'] = $this->session->data['address'];
			}
			if (!isset($this->session->data['shipping_address']['company'])) {
				$this->session->data['shipping_address']['company'] = $this->session->data['payment_address']['company'] = '';
			}
			if (!isset($this->session->data['shipping_address']['address_format'])) {
				$this->session->data['shipping_address']['address_format'] = $this->session->data['payment_address']['address_format'] = '';
			}
			if (!isset($this->session->data['shipping_address']['country'])) {
				$this->session->data['shipping_address']['country'] = $this->session->data['payment_address']['country'] = 'Россия';
			}
			if (!isset($this->session->data['shipping_address']['address_2'])) {
				$this->session->data['shipping_address']['address_2'] = $this->session->data['payment_address']['address_2'] = '';
			}
			if (!isset($this->session->data['shipping_address']['postcode'])) {
				$this->session->data['shipping_address']['postcode'] = $this->session->data['payment_address']['postcode'] = '';
			}
			if (isset($this->session->data['firstname'])) {
				$this->session->data['shipping_address']['firstname'] = $this->session->data['payment_address']['firstname'] = $this->session->data['firstname'];
			}
			if (isset($this->session->data['lastname'])) {
				$this->session->data['shipping_address']['lastname'] = $this->session->data['payment_address']['lastname'] = $this->session->data['lastname'];
			}
			if (isset($this->session->data['shipping_address'])) {
				$this->session->data['shipping_address']['country_id'] = $this->config->get('config_country_id');
			}
			if (isset($this->session->data['payment_address'])) {
				$this->session->data['payment_address']['country_id'] = $this->config->get('config_country_id');
			}

			if (isset($this->session->data['account'])) {
				$data['account'] = $this->session->data['account'];
			} else {
				$data['account'] = '';
			}

			if (isset($this->request->post['silent'])) {
				$this->response->addHeader('Content-Type: application/json');
				return $this->response->setOutput(json_encode([]));
			}

			$data['shipping_required'] = $this->cart->hasShipping();

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if ($data['step']) {
				if (!isset($data['firstname']) || !$data['firstname']) {
					$data['error_warning'] = 'Имя необходимо';
					$data['step'] = 0;
				} elseif (!isset($data['telephone']) || !$data['telephone']) {
					$data['error_warning'] = 'Телефон необходим';
					$data['step'] = 0;
				} elseif (!isset($data['email']) || !$data['email']) {
					$data['error_warning'] = 'Email необходим';
					$data['step'] = 0;
				}
			}

			if ($data['firstname'] && $data['telephone'] && $data['email']) {
				$data['step'] = 1;
			}

			if ($jsonOutput) return  $this->load->view('checkout/part_cart', $data);


			if (isset($data['firstname']) && $data['firstname']) {
				$this->cart->setFIO((isset($data['lastname']) && $data['lastname'] ? $data['lastname'] . " " : "") . $data['firstname']);
			}

			if (isset($data['telephone']) && $data['telephone']) {
				$this->cart->setPhone($data['telephone']);
			}

			if (isset($data['email']) && $data['email']) {
				$this->cart->setEmail($data['email']);
			}


			$this->response->setOutput($this->load->view('checkout/checkout', $data));
		} else {

			$this->load->language('checkout/cart');

			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_error'] = $this->language->get('text_empty');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			unset($this->session->data['success']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	public function editAjax()
	{
		$this->load->language('checkout/cart');

		$json = array();

		// Update
		if (!empty($this->request->post['quantity']) && !empty($this->request->post['key'])) {
			$this->cart->update($this->request->post['key'], $this->request->post['quantity']);
			$json['success'] = true;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}



	public function remove()
	{
		$this->load->language('checkout/cart');

		$json = array();

		// Remove
		if (isset($this->request->post['key'])) {
			$this->cart->remove($this->request->post['key']);

			unset($this->session->data['vouchers'][$this->request->post['key']]);

			$json['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			// Totals
			$this->load->model('extension/extension');

			$totals = array();
			$taxes = $this->cart->getTaxes();
			$total = 0;

			// Because __call can not keep var references so we put them into an array. 			
			$total_data = array(
				'totals' => &$totals,
				'taxes'  => &$taxes,
				'total'  => &$total
			);

			// Display prices
			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$sort_order = array();

				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('extension/total/' . $result['code']);

						// We have to put the totals in an array so that they pass by reference.
						$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
					}
				}

				$sort_order = array();

				foreach ($totals as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $totals);
			}

			$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total, $this->session->data['currency']));
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function country()
	{
		$json = array();

		$this->load->model('localisation/country');

		$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);

		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']
			);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function customfield()
	{
		$json = array();

		$this->load->model('account/custom_field');

		// Customer Group
		if (isset($this->request->get['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->get['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $this->request->get['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);

		foreach ($custom_fields as $custom_field) {
			$json[] = array(
				'custom_field_id' => $custom_field['custom_field_id'],
				'required'        => $custom_field['required']
			);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
