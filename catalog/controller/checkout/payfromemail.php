<?php
class ControllerCheckoutPayfromemail extends Controller
{
    public function index()
    {
        $form = $this->load->controller('extension/payment/paykeeper/generateEmailPaymentForm', $this->request->get['order_id']);
        echo $form;
    }

    // public function tink()
    // {
    //     $this->load->model('checkout/order');
    //     $this->load->model('extension/payment/tinkoff');
    //     $this->language->load('extension/payment/tinkoff');
    //     $order = $this->model_checkout_order->getOrder($this->request->get['order_id']);

    //     $order['shipping_cost'] = $this->currency->format($order['total'], $order['currency_code'], $order['currency_value'], false) * 100;

    //     $orderProducts = $this->model_checkout_order->getOrderProducts($this->request->get['order_id']);
    //     $items = [];
    //     foreach ($orderProducts as $item) {
    //         $product_price = $this->currency->format($item['price'], $order['currency_code'], $order['currency_value'], false) * 100;
    //         $total_price = $this->currency->format($item['total'], $order['currency_code'], $order['currency_value'], false) * 100;
    //         $items[] = [
    //             'name' => $item['name'],
    //             'price' => $product_price,
    //             'quantity' => $item['quantity'],
    //             'total' => $total_price,
    //         ];
    //         $order['shipping_cost'] -= $total_price;
    //     }
    //     $data['payment'] = $this->model_extension_payment_tinkoff->initEmailPayment(array(
    //         'amount' => $this->currency->format($order['total'], $order['currency_code'], $order['currency_value'], false) * 100,
    //         'orderId' => $this->request->get['order_id'],
    //         'email' => $order['email'],
    //         'order' => $order,
    //         'products' => $items,
    //     ));
    //     $data['payButton'] = $this->language->get('pay_button');
    //     $output = '<!DOCTYPE html><html lang="ru"><head></head><body><div style="opacity:0;">';
    //     $output .= $this->load->view('extension/payment/tinkoff_checkout', $data);
    //     $output .= '<script>document.addEventListener("DOMContentLoaded", function(){document.getElementById(\'form-tinkoff\').submit()})</script>';
    //     $output .= '</div></body></html>';
    //     $this->response->setOutput($output);
    // }

    // public function tinkoff()
    // {
    //     $this->load->model('checkout/order');

    //     $order_info = $this->model_checkout_order->getOrder($this->request->get['order_id']);

    //     if ($this->config->get('robokassa_test')) {

    //         $password_1 = $this->config->get('robokassa_test_password_1');
    //         $password_2 = $this->config->get('robokassa_test_password_2');
    //         $data['payment_url'] = 'https://merchant.roboxchange.com/Index.aspx';
    //     } else {

    //         $password_1 = $this->config->get('robokassa_password_1');
    //         $password_2 = $this->config->get('robokassa_password_2');
    //         $data['payment_url'] = 'https://auth.robokassa.ru/Merchant/Index.aspx';
    //     }

    //     $data['robokassa_login'] = $this->config->get('robokassa_login');

    //     $data['robokassa_fiscal'] = $this->config->get('robokassa_fiscal');

    //     $data['inv_id'] = $this->request->get['order_id'];

    //     $data['order_desc'] = 'Покупка в ' . $this->config->get('config_name');

    //     if ($order_info['currency_code'] != $this->config->get('robokassa_country') && $order_info['currency_code'] != 'RUB') {
    //         $data['out_summ_currency'] = $order_info['currency_code'];
    //     }

    //     $data['out_summ'] = (float) $this->currency->format($order_info['total'], $order_info['currency_code'], false, false);

    //     $customer_language_id = $this->config->get('config_language_id');
    //     $languages_map = $this->config->get('robokassa_languages_map');

    //     $language = isset($languages_map[$customer_language_id]) ? $languages_map[$customer_language_id] : 'ru';

    //     $data['culture'] = $language;


    //     if (isset($data['out_summ_currency'])) {
    //         $data['crc'] = md5($data['robokassa_login'] . ":" . $data['out_summ'] . ":" . $data['inv_id'] . ":" . $data['out_summ_currency'] . ":" . $password_1 . ":Shp_item=1" . ":Shp_label=official_opencart");
    //     } else {
    //         $data['crc'] = md5($data['robokassa_login'] . ":" . $data['out_summ'] . ":" . $data['inv_id'] . ":" . $password_1 . ":Shp_item=1" . ":Shp_label=official_opencart");
    //     }

    //     if ($this->config->get('robokassa_test')) {
    //         $data['robokassa_test'] = '1';
    //     } else {
    //         $data['robokassa_test'] = '0';
    //     }

    //     if ($this->config->get('robokassa_status_iframe')) {
    //         $data['robokassa_status_iframe'] = 1;
    //     } else {
    //         $data['robokassa_status_iframe'] = 0;
    //     }
    //     $output = '<!DOCTYPE html><html lang="ru"><head></head><body><div style="opacity:0;">';
    //     $output .= $this->load->view('extension/payment/robokassa', $data);
    //     $output .= '<script>document.addEventListener("DOMContentLoaded", function(){document.getElementById(\'form-robokassa\').submit()})</script>';
    //     $output .= '</div></body></html>';
    //     $this->response->setOutput($output);
    // }

    // public function robokassa()
    // {
    //     $this->load->model('checkout/order');

    //     $order_info = $this->model_checkout_order->getOrder($this->request->get['order_id']);

    //     if ($this->config->get('robokassa_test')) {

    //         $password_1 = $this->config->get('robokassa_test_password_1');
    //         $password_2 = $this->config->get('robokassa_test_password_2');
    //         $data['payment_url'] = 'https://merchant.roboxchange.com/Index.aspx';
    //     } else {

    //         $password_1 = $this->config->get('robokassa_password_1');
    //         $password_2 = $this->config->get('robokassa_password_2');
    //         $data['payment_url'] = 'https://auth.robokassa.ru/Merchant/Index.aspx';
    //     }

    //     $data['robokassa_login'] = $this->config->get('robokassa_login');

    //     $data['robokassa_fiscal'] = $this->config->get('robokassa_fiscal');

    //     $data['inv_id'] = $this->request->get['order_id'];

    //     $data['order_desc'] = 'Покупка в ' . $this->config->get('config_name');

    //     if ($order_info['currency_code'] != $this->config->get('robokassa_country') && $order_info['currency_code'] != 'RUB') {
    //         $data['out_summ_currency'] = $order_info['currency_code'];
    //     }

    //     $data['out_summ'] = (float) $this->currency->format($order_info['total'], $order_info['currency_code'], false, false);

    //     $customer_language_id = $this->config->get('config_language_id');
    //     $languages_map = $this->config->get('robokassa_languages_map');

    //     $language = isset($languages_map[$customer_language_id]) ? $languages_map[$customer_language_id] : 'ru';

    //     $data['culture'] = $language;


    //     if (isset($data['out_summ_currency'])) {
    //         $data['crc'] = md5($data['robokassa_login'] . ":" . $data['out_summ'] . ":" . $data['inv_id'] . ":" . $data['out_summ_currency'] . ":" . $password_1 . ":Shp_item=1" . ":Shp_label=official_opencart");
    //     } else {
    //         $data['crc'] = md5($data['robokassa_login'] . ":" . $data['out_summ'] . ":" . $data['inv_id'] . ":" . $password_1 . ":Shp_item=1" . ":Shp_label=official_opencart");
    //     }

    //     if ($this->config->get('robokassa_test')) {
    //         $data['robokassa_test'] = '1';
    //     } else {
    //         $data['robokassa_test'] = '0';
    //     }

    //     if ($this->config->get('robokassa_status_iframe')) {
    //         $data['robokassa_status_iframe'] = 1;
    //     } else {
    //         $data['robokassa_status_iframe'] = 0;
    //     }
    //     $output = '<!DOCTYPE html><html lang="ru"><head></head><body><div style="opacity:0;">';
    //     $output .= $this->load->view('extension/payment/robokassa', $data);
    //     $output .= '<script>document.addEventListener("DOMContentLoaded", function(){document.getElementById(\'form-robokassa\').submit()})</script>';
    //     $output .= '</div></body></html>';
    //     $this->response->setOutput($output);
    // }
}
