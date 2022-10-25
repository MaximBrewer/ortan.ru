<?php
class ControllerProductOneclick extends Controller
{
	private $error = array();

	public function index()
	{

		$data['uniqid'] = $this->request->get['uniqid'];
		$data['product_id'] = $this->request->get['product_id'];
		$product_id = $data['product_id'];

		$this->load->language('information/contact');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$data['logged'] = $this->customer->isLogged();

			if ($data['logged']) {
				$this->load->model('account/customer');
				$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
			}

			$this->load->language('extension/module/buyoneclick');

			$boc_title = 'Покупка в один клик';

			if ($data['logged']) {
				if (isset($this->request->post['name']) && $this->request->post['name'] != '') {
					$fullname = $this->request->post['name'];
					$datas = preg_split('/\s+/', $fullname);
					if (count($datas) > 1) {
						$firstname = $datas[0];
						$lastname = $datas[1];
					} else {
						$firstname = $datas[0];
						$lastname = '(' . $boc_title . ')';
					}
				} else {
					$firstname = $customer_info['firstname'];
					$lastname = $customer_info['lastname'];
				}

				if (isset($this->request->post['email']) && $this->request->post['email'] != '') {
					$email = $this->request->post['email'];
				} else {
					$email = $customer_info['email'];
				}
				if (isset($this->request->post['phone'])) {
					$phone = $this->request->post['phone'];
				} else {
					$phone = $customer_info['telephone'];
				}
				if (isset($customer_info['fax'])) {
					$fax = $customer_info['fax'];
				} else {
					$fax = '';
				}

				// Customer ID
				if (isset($customer_info['customer_id'])) {
					$customer_id = $customer_info['customer_id'];
				} else {
					$customer_id = '';
				}

				// Customer Group
				if (isset($customer_info['customer_group_id']) && $customer_info['customer_group_id'] != '') {
					$customer_group_id = $customer_info['customer_group_id'];
				} else {
					$customer_group_id = $this->config->get('config_customer_group_id');
				}
			} else {
				if (isset($this->request->post['name']) && $this->request->post['name'] != '') {
					$fullname = $this->request->post['name'];
					$datas = preg_split('/\s+/', $fullname);
					if (count($datas) > 1) {
						$firstname = $datas[0];
						$lastname = $datas[1];
					} else {
						$firstname = $datas[0];
						$lastname = '(' . $boc_title . ')';
					}
				} else {
					$firstname = $boc_title;
					$lastname = $boc_title;
				}

				if (isset($this->request->post['email']) && $this->request->post['email'] != '') {
					$email = $this->request->post['email'];
				} else {
					$email = $data['uniqid'] . '@ortan.ru';
				}
				if (isset($this->request->post['phone'])) {
					$phone = $this->request->post['phone'];
				} else {
					$phone = '';
				}
				$fax = '';

				// Customer ID
				$customer_id = '';

				$customer_group_id = $this->config->get('config_customer_group_id');

				$this->session->data['guest']['customer_group_id'] = $customer_group_id;
				$this->session->data['guest']['firstname'] = $firstname;
				$this->session->data['guest']['lastname'] = $lastname;
				$this->session->data['guest']['email'] = $email;
				$this->session->data['guest']['telephone'] = $phone;
				$this->session->data['guest']['fax'] = '';
				$this->session->data['shipping_method'] = ['code' => 'pickup', 'cost' => 0, 'tax_class_id' => 0];
			}

			if (isset($this->request->post['enquiry'])) {
				$comment = $this->request->post['enquiry'];
			} else {
				$comment = '';
			}

			$this->load->model('catalog/product');
			$product_info = $this->model_catalog_product->getProduct($product_id);
			if ($product_info) {

				$product_quantity = $product_info['minimum'];

				$product_option = array();
				$options = $this->model_catalog_product->getProductOptions($product_id);
				foreach ($options as $option) {
					foreach ($this->request->post['option'] as $getOptionId => $getOption) {
						if ($option['product_option_id'] == $getOptionId) {
							foreach ($option['product_option_value'] as $product_option_value) {
								if ($product_option_value['product_option_value_id'] == $getOption) {
									$product_option[] = [
										'product_option_id'       => $getOptionId,
										'product_option_value_id' => $getOption,
										'option_id'               => $option['option_id'],
										'option_value_id'         => $product_option_value['option_value_id'],
										'name'                    => $option['name'],
										'value'                   => $product_option_value['name'],
										'type'                    => $option['type'],
										'quantity'                => $product_option_value['quantity'],
										'subtract'                => $product_option_value['subtract'],
										'price'                   => $product_option_value['price'],
										'price_prefix'            => $product_option_value['price_prefix'],
										'points'                  => $product_option_value['points'],
										'points_prefix'           => $product_option_value['points_prefix'],
										'weight'                  => $product_option_value['weight'],
										'weight_prefix'           => $product_option_value['weight_prefix'],
										'value_price_value' => $product_option_value['price'],
										'value_price_prefix' => $product_option_value['price_prefix'],
									];
								}
							}
						}
					}
				}

				// Display prices
				$boc_price = (float)$product_info['price'];
				if ((float)$product_info['special']) {
					$boc_price = (float)$product_info['special'];
				}

				$discounts = $this->model_catalog_product->getProductDiscounts($product_id);
				if ($discounts) {
					foreach ($discounts as $discount) {
						if ($discount['quantity'] <= $product_quantity) {
							$boc_price = (float)$discount['price'];
						}
					}
				}

				// Calculate total
				if (!$product_option) {
					$boc_unit_price = $boc_price;
					$boc_total = $boc_price * $product_quantity;
					$boc_unit_tax = $this->tax->getTax($boc_price, $product_info['tax_class_id']);
				} else {
					$option_total = 0;
					foreach ($product_option as $option) {
						if ($option['value_price_prefix'] == '+') {
							$option_total += (float)$option['value_price_value'];
						} else if ($option['value_price_prefix'] == '-') {
							$option_total -= (float)$option['value_price_value'];
						}
					}
					$boc_unit_price = $boc_price + $option_total;
					$boc_total = ($boc_price + $option_total) * $product_quantity;
					$boc_unit_tax = $this->tax->getTax(($boc_price + $option_total), $product_info['tax_class_id']);
				}
				$boc_tax_total = $boc_unit_tax * $product_quantity;
				$boc_order_total = $boc_total + $boc_tax_total;

				// $order_data['products'] = array();
				$order_data['products'][] = array(
					'product_id' => $product_info['product_id'],
					'name'       => $product_info['name'],
					'model'      => $product_info['model'],
					'option'     => $product_option,
					'download'   => '',
					'quantity'   => $product_quantity,
					'subtract'   => $product_info['subtract'],
					'price'      => $boc_unit_price,
					'total'      => $boc_total,
					'tax'        => $boc_unit_tax,
					'reward'     => $product_info['reward']
				);

				$order_data['totals'] = array();

				$this->load->language('checkout/checkout');
				$order_data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
				$order_data['store_id'] = $this->config->get('config_store_id');
				$order_data['store_name'] = $this->config->get('config_name');
				if ($order_data['store_id']) {
					$order_data['store_url'] = $this->config->get('config_url');
				} else {
					$order_data['store_url'] = HTTP_SERVER;
				}

				$order_data['customer_id'] = $customer_id;
				$order_data['customer_group_id'] = $customer_group_id;
				$order_data['firstname'] = $firstname;
				$order_data['lastname'] = $lastname;
				$order_data['email'] = $email;
				$order_data['telephone'] = $phone;
				$order_data['fax'] = $fax;
				$order_data['custom_field'] = [
					1 => 'Москва',
					2 => 'Москва',
				];
				$order_data['payment_firstname'] = $firstname;
				$order_data['payment_lastname'] = $lastname;
				$order_data['payment_company'] = '';
				$order_data['payment_address_1'] = $boc_title;
				$order_data['payment_address_2'] = '';
				$order_data['payment_city'] = $boc_title;
				$order_data['payment_postcode'] = '';
				$order_data['payment_zone'] = $boc_title;
				$order_data['payment_zone_id'] = $this->config->get('config_zone_id');
				$order_data['payment_country'] = $boc_title;
				$order_data['payment_country_id'] = $this->config->get('config_country_id');
				$order_data['payment_address_format'] = '';
				$order_data['payment_custom_field'] = [
					1 => 'Москва',
					2 => 'Москва',
				];
				$order_data['payment_method'] = 'Тинькофф Банк';
				$order_data['payment_code'] = 'tinkoff';
				$order_data['shipping_firstname'] = $firstname;
				$order_data['shipping_lastname'] = $lastname;
				$order_data['shipping_company'] = '';
				$order_data['shipping_address_1'] = $boc_title;;
				$order_data['shipping_address_2'] = '';
				$order_data['shipping_city'] = $boc_title;;
				$order_data['shipping_postcode'] = '';
				$order_data['shipping_zone'] = $boc_title;
				$order_data['shipping_zone_id'] = $this->config->get('config_zone_id');
				$order_data['shipping_country'] = $boc_title;
				$order_data['shipping_country_id'] = $this->config->get('config_country_id');
				$order_data['shipping_address_format'] = '';
				$order_data['shipping_custom_field'] = [
					1 => 'Москва',
					2 => 'Москва',
				];
				$order_data['shipping_method'] = 'pickup';
				$order_data['shipping_code'] = 'pickup.pickup';
				$order_data['comment'] = $comment;
				$order_data['total'] = $boc_order_total;
				$order_data['affiliate_id'] = 0;
				$order_data['commission'] = 0;
				$order_data['marketing_id'] = 0;
				$order_data['tracking'] = '';
				$order_data['language_id'] = $this->config->get('config_language_id');
				$order_data['currency_id'] = $this->currency->getId($this->session->data['currency']);
				$order_data['currency_code'] = $this->session->data['currency'];
				$order_data['currency_value'] = $this->currency->getValue($this->session->data['currency']);
				$order_data['ip'] = $this->request->server['REMOTE_ADDR'];
				if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
					$order_data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
				} elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
					$order_data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
				} else {
					$order_data['forwarded_ip'] = '';
				}
				if (isset($this->request->server['HTTP_USER_AGENT'])) {
					$order_data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
				} else {
					$order_data['user_agent'] = '';
				}
				if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
					$order_data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
				} else {
					$order_data['accept_language'] = '';
				}
				$this->load->model('checkout/order');
				$data['order_id'] = $this->model_checkout_order->addOrder($order_data);

				if ($data['order_id']) {
					$this->model_checkout_order->addOrderHistory($data['order_id'], $this->config->get('config_order_status_id'), '', true);
					return $this->response->redirect($this->url->link('information/contact/success'));
				}
			}
		}

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_enquiry'] = $this->language->get('entry_enquiry');

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		if (isset($this->error['enquiry'])) {
			$data['error_enquiry'] = $this->error['enquiry'];
		} else {
			$data['error_enquiry'] = '';
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}

		if (isset($this->error['phone'])) {
			$data['error_phone'] = $this->error['phone'];
		} else {
			$data['error_phone'] = '';
		}

		if (isset($this->error['agree'])) {
			$data['error_agree'] = $this->error['agree'];
		} else {
			$data['error_agree'] = '';
		}

		$data['button_submit'] = $this->language->get('button_submit');

		$data['action'] = $this->url->link('product/oneclick', ['uniqid' => $data['uniqid'], 'product_id' => $data['product_id']], true);

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} else {
			$data['name'] = $this->customer->getFirstName();
		}

		if (isset($this->request->post['enquiry'])) {
			$data['enquiry'] = $this->request->post['enquiry'];
		} else {
			$data['enquiry'] = '';
		}

		if (isset($this->request->post['agree'])) {
			$data['agree'] = $this->request->post['agree'];
		} else {
			$data['agree'] = true;
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} else {
			$data['email'] = '';
		}

		if (isset($this->request->post['phone'])) {
			$data['phone'] = $this->request->post['phone'];
		} else {
			$data['phone'] = '';
		}

		// Captcha
		if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('contact', (array)$this->config->get('config_captcha_page'))) {
			$data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'), $this->error);
		} else {
			$data['captcha'] = '';
		}

		$this->response->setOutput($this->load->view('product/oneclick_form', $data));
	}

	protected function validate()
	{
		// if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 32)) {
		// 	$this->error['name'] = $this->language->get('error_name');
		// }
		if ($this->request->post['email']) {
			if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match($this->config->get('config_mail_regexp'), $this->request->post['email'])) {
				$this->error['email'] = $this->language->get('error_email');
			}
		}

		if (!$this->request->post['agree']) {
			$this->error['agree'] = 'Необходимо согласие';
		}

		if ((utf8_strlen($this->request->post['phone']) < 3) || (utf8_strlen($this->request->post['phone']) > 32)) {
			$this->error['phone'] = 'Телефон необходим';
		}

		// if ((utf8_strlen($this->request->post['enquiry']) < 10) || (utf8_strlen($this->request->post['enquiry']) > 3000)) {
		// 	$this->error['enquiry'] = $this->language->get('error_enquiry');
		// }

		// Captcha
		if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('contact', (array)$this->config->get('config_captcha_page'))) {
			$captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

			if ($captcha) {
				$this->error['captcha'] = $captcha;
			}
		}

		return !$this->error;
	}

	public function success()
	{
		return $this->response->setOutput($this->load->view('information/contact_success'));
	}
}
