<?php

class ControllerExtensionPaymentTinkoff extends Controller
{
    public function index()
    {
        $this->load->model('extension/payment/tinkoff');
        $this->language->load('extension/payment/tinkoff');
        $order = $this->model_checkout_order->getOrder($this->session->data['order_id']);
        $data['payment'] = $this->model_extension_payment_tinkoff->initPayment(array(
            'amount' => $this->currency->format($order['total'], $order['currency_code'], $order['currency_value'], false) * 100,
            'orderId' => $this->session->data['order_id'],
        ));
        $data['payButton'] = $this->language->get('pay_button');

        return $this->load->view('extension/payment/tinkoff_checkout', $data);
    }

    public function callback()
    {
        $request = json_decode(file_get_contents("php://input"));
        $request->Success = $request->Success ? 'true' : 'false';
        $this->log->write('Tinkoff callback GET: ' . print_r($this->request->get, true));
        $this->log->write('Tinkoff callback INPUT: ' . print_r($request, true));

        file_put_contents(dirname(DIR_ROOT_PATH) . '/tinkoff.log', 'Tinkoff callback GET: ' . print_r($this->request->get, true), FILE_APPEND);
        file_put_contents(dirname(DIR_ROOT_PATH) . '/tinkoff.log', 'Tinkoff callback INPUT: ' . print_r($request, true), FILE_APPEND);
        foreach ($request as $key => $item) {
            $this->request->post[$key] = $item;
        }

        $password = $this->db->query("select * from  " . DB_PREFIX . "setting where `key`='tinkoff_secret_key' ");
        $this->request->post['Password'] = $password->row['value'];
        $sorted = $this->request->post;
        ksort($sorted);
        $this->log->write('Tinkoff callback sorted: ' . print_r($sorted, true));
        file_put_contents(dirname(DIR_ROOT_PATH) . '/tinkoff.log', 'Tinkoff callback sorted: ' . print_r($sorted, true), FILE_APPEND);

        $original_token = $sorted['Token'];
        unset($sorted['Token']);
        $values = implode('', array_values($sorted));
        $token = hash('sha256', $values);

        $this->log->write('Tinkoff callback $token == $original_token: ' . print_r($$token == $original_token, true));
        file_put_contents(dirname(DIR_ROOT_PATH) . '/tinkoff.log', 'Tinkoff callback $token == $original_token: ' . print_r($$token == $original_token, true), FILE_APPEND);
        if ($token == $original_token) {
            $order = $this->db->query("select * from  `" . DB_PREFIX . "order` where order_id=" . (int)$sorted['OrderId']);
            $status['authorized'] = $this->db->query("select * from  " . DB_PREFIX . "setting where `key`='tinkoff_order_status_authorized' ")->row['value'];
            $status['completed'] = $this->db->query("select * from  " . DB_PREFIX . "setting where `key`='tinkoff_order_status_completed' ")->row['value'];
            $status['canceled'] = $this->db->query("select * from  " . DB_PREFIX . "setting where `key`='tinkoff_order_status_canceled' ")->row['value'];
            $status['rejected'] = $this->db->query("select * from  " . DB_PREFIX . "setting where `key`='tinkoff_order_status_rejected' ")->row['value'];
            $status['refunded'] = $this->db->query("select * from  " . DB_PREFIX . "setting where `key`='tinkoff_order_status_refunded' ")->row['value'];

            $this->log->write('Tinkoff sorted order status: ' . print_r([$sorted, $order->row, $status], true));
            file_put_contents(dirname(DIR_ROOT_PATH) . '/tinkoff.log', 'Tinkoff sorted order status: ' . print_r([$sorted, $order->row, $status], true), FILE_APPEND);
            if ($sorted['Status'] == 'AUTHORIZED' && $order->row['order_status_id'] == $status['completed']) {
                die('OK');
            }

            switch ($sorted['Status']) {
                case 'AUTHORIZED':
                    $order_status = $status['authorized'];
                    break;
                case 'CONFIRMED':
                    $order_status = $status['completed'];
                    break;
                case 'CANCELED':
                    $order_status = $status['canceled'];
                    break;
                case 'REJECTED':
                    $order_status = $status['rejected'];
                    break;
                case 'REVERSED':
                    $order_status = $status['canceled'];
                    break;
                case 'REFUNDED':
                    $order_status = $status['refunded'];
                    break;
            }

            $this->log->write('Tinkoff $order_status: ' . print_r($order_status, true));
            if (isset($order_status)) {
                $this->log->write('Tinkoff if: ' . print_r((string)$sorted['Status'] == 'CONFIRMED', true));
                if ((string)$sorted['Status'] == 'CONFIRMED') {
                    try {
                        $this->load->model('checkout/order');
                        $this->log->write('Tinkoff addHistory: ' . print_r([(int)$sorted['OrderId'], $order_status], true));
                        file_put_contents(dirname(DIR_ROOT_PATH) . '/tinkoff.log', 'Tinkoff addHistory: ' . print_r([(int)$sorted['OrderId'], $order_status], true), FILE_APPEND);
                        $this->model_checkout_order->addOrderHistory((int)$sorted['OrderId'], $order_status);

                        $this->load->model('extension/module/bitrix24');
                        $this->model_extension_module_bitrix24->update_order_status($sorted['OrderId']);
                    } catch (\Throwable $e) {
                        $this->log->write('Tinkoff addHistory: ' . print_r($e->getMessage(), true), true);
                    }
                }
                die('OK');
            }
        }

        die('NOTOK');
    }

    public function failure()
    {
        if (isset($this->session->data['order_id'])) {
            $this->cart->clear();
            unset($this->session->data['shipping_method']);
            unset($this->session->data['shipping_methods']);
            unset($this->session->data['payment_method']);
            unset($this->session->data['payment_methods']);
            unset($this->session->data['guest']);
            unset($this->session->data['comment']);
            unset($this->session->data['order_id']);
            unset($this->session->data['coupon']);
            unset($this->session->data['reward']);
            unset($this->session->data['voucher']);
            unset($this->session->data['vouchers']);
            unset($this->session->data['totals']);
        }

        $this->language->load('checkout/failure');
        $this->document->setTitle($this->language->get('heading_title'));

        $data['heading_title'] = $this->language->get('heading_title');
        $data['text_message'] = sprintf($this->language->get('text_message'), $this->url->link('information/contact'));
        $data['button_continue'] = $this->language->get('button_continue');
        $data['continue'] = $this->url->link('common/home');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');

        return $this->response->setOutput($this->load->view('extension/payment/tinkoff_failure.tpl', $data));
    }

    public function success()
    {
        if (isset($this->session->data['order_id'])) {
            $this->load->model('account/activity');

            if ($this->customer->isLogged()) {
                $activity_data = array(
                    'customer_id' => $this->customer->getId(),
                    'name' => $this->customer->getFirstName() . ' ' . $this->customer->getLastName(),
                    'order_id' => $this->session->data['order_id']
                );

                $this->model_account_activity->addActivity('order_account', $activity_data);
            } else {
                $activity_data = array(
                    'name' => $this->session->data['guest']['firstname'] . ' ' . $this->session->data['guest']['lastname'],
                    'order_id' => $this->session->data['order_id']
                );

                $this->model_account_activity->addActivity('order_guest', $activity_data);
            }

            $this->cart->clear();
            unset($this->session->data['shipping_method']);
            unset($this->session->data['shipping_methods']);
            unset($this->session->data['payment_method']);
            unset($this->session->data['payment_methods']);
            unset($this->session->data['guest']);
            unset($this->session->data['comment']);
            unset($this->session->data['order_id']);
            unset($this->session->data['coupon']);
            unset($this->session->data['reward']);
            unset($this->session->data['voucher']);
            unset($this->session->data['vouchers']);
            unset($this->session->data['totals']);
        }

        $this->language->load('checkout/success');
        $this->document->setTitle($this->language->get('heading_title'));
        $data['heading_title'] = $this->language->get('heading_title');

        if ($this->customer->isLogged()) {
            $data['text_message'] =
                sprintf(
                    $this->language->get('text_customer'),
                    $this->url->link('account/account', '', 'SSL'),
                    $this->url->link('account/order', '', 'SSL'),
                    $this->url->link('account/download', '', 'SSL'),
                    $this->url->link('information/contact')
                );
        } else {
            $data['text_message'] = sprintf($this->language->get('text_guest'), $this->url->link('information/contact'));
        }

        $data['button_continue'] = $this->language->get('button_continue');
        $data['continue'] = $this->url->link('common/home');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');

        return $this->response->setOutput($this->load->view('extension/payment/tinkoff_failure.tpl', $data));
    }
}
