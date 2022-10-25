<?php
class ControllerStartupCheckcarts extends Controller
{
	public function index()
	{
		$cs = $this->cart->findMissing();

		foreach ($cs as $c) {
			$data = ["phone" => "", "email" => "", "fio" => ""];
			$carts = $this->cart->getCartsBySessionId($c['session_id']);
			$sum = 0;
			$text = '';
            $infoProd = '';
            foreach ($carts as $key => $cart) {
				if (!$key)
					$text = "Телефон: " . $cart['phone'] . PHP_EOL;
				$this->load->model('catalog/product');
				$product = $this->model_catalog_product->getProduct($cart['product_id']);
				$text .= $product['name'] . ' - ' . $cart['quantity'] .  ' - ' . $product['price'] . '₽' . PHP_EOL;
				$data['phone'] = $cart['phone'] ? $cart['phone'] : $data['phone'];
				$data['email'] = $cart['email'] ? $cart['email'] : $data['email'];
				$data['fio'] = $cart['fio'] ? $cart['fio'] : $data['fio'];
				$sum += $product['price'];
				$product['price'] = $this->currency->format($product['price'], "RUB");
				$product['quantity'] = $cart['quantity'];

				$product['options'] = "<ul>";
				$product_options_data = $this->model_catalog_product->getProductOptions($cart['product_id']);

                $tOptions = '';
				if ($cart['option'] && $options = json_decode($cart['option'], true)) {
					foreach ($options as $k => $v) {
						foreach ($product_options_data as $product_option_data) {
							foreach ($product_option_data['product_option_value'] as $product_option_value) {
								if ($product_option_data['product_option_id'] == $k && $product_option_value['product_option_value_id'] == $v) {
									$product['options'] .=  "<li>" . $product_option_data['name'] . ": " . $product_option_value['name'] . "</li>";
                                    $tOptions .= ($tOptions ? ', ' : '') . $product_option_data['name'] . ':' . $product_option_value['name'];
								}
							}
						}
					}
				}
				$product['options'] .= "</ul>";
				$data['products'][] = $product;
				$this->cart->nullPhone($cart['cart_id']);


                $name = $product['name'];
                if ($tOptions) {
                    $name .= '('.$tOptions.')';
                }
                $product['href'] = HTTPS_SERVER . 'admin/index.php?route=catalog/product/edit&product_id=' . $product['product_id'];
                $prod = $product['quantity'] . ' шт. - ' . $product['price'] . ' - <a href="' . $product['href'] . '">' . $name . '</a> / арт.' . $product['model'] ;
                $infoProd .= ($infoProd ? '<br>' : '') . $prod;

			}
			$data['sum'] = $this->currency->format($sum, "RUB");

            $html = $this->load->view('mail/misscart', $data);

            $this->load->model('extension/module/bitrix24');
            $this->model_extension_module_bitrix24->push_call($data['fio'], $data['email'], $data['phone'], $infoProd, "Брошенная корзина");


			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender(html_entity_decode('Ortan', ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(html_entity_decode('Ortan - брошенная корзина', ENT_QUOTES, 'UTF-8'));
			$mail->setHtml($html);
			$mail->setText($text);
			$mail->send();

			// Send to additional alert emails
			$emails = explode(',', $this->config->get('config_alert_email'));

			if (!empty($emails)) {
                foreach ($emails as $email) {
                    if ($email && preg_match($this->config->get('config_mail_regexp'), $email)) {
                        $mail->setTo($email);
                        $mail->send();
                    }
                }
            }
		}
		return;
	}
}
