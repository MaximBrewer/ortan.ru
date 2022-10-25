<?php

include('TinkoffMerchantAPI.php');

class ModelExtensionPaymentTinkoff extends Model
{
    public function getMethod($address, $total)
    {
        $this->language->load('extension/payment/tinkoff');
        return array(
            'code'       => 'tinkoff',
            'terms'      => "",
            'title'      => $this->language->get('text_title'),
            'sort_order' => $this->config->get('sagepay_us_sort_order')
        );
    }

    /**
     * After calling initPayment()
     */
    const STATUS_NEW = 'NEW';

    /**
     * After calling cancelPayment()
     * Not Implemented here
     */
    const STATUS_CANCELED = 'CANCELED';

    /**
     * Intermediate status (transaction is in process)
     */
    const STATUS_PREAUTHORIZING = 'PREAUTHORIZING';

    /**
     * After showing payment form to the customer
     */
    const STATUS_FORMSHOWED = 'FORMSHOWED';

    /**
     * Intermediate status (transaction is in process)
     */
    const STATUS_AUTHORIZING = 'AUTHORIZING';

    /**
     * Intermediate status (transaction is in process)
     * Customer went to 3DS
     */
    const STATUS_THREEDSCHECKING = 'THREEDSCHECKING';

    /**
     * Payment rejected on 3DS
     */
    const STATUS_REJECTED = 'REJECTED';

    /**
     * Payment compete, money holded
     */
    const STATUS_AUTHORIZED = 'AUTHORIZED';

    /**
     * After calling reversePayment
     * Charge money back to customer
     * Not Implemented here
     */
    const STATUS_REVERSING = 'REVERSING';

    /**
     * Money charged back, transaction cmplete
     */
    const STATUS_REVERSED = 'REVERSED';

    /**
     * After calling confirmePayment()
     * Confirm money wright-off
     * Not Implemented here
     */
    const STATUS_CONFIRMING = 'CONFIRMING';

    /**
     * Money written off
     */
    const STATUS_CONFIRMED = 'CONFIRMED';

    /**
     * After calling refundPayment()
     * Retrive money back to customer
     * Not Implemented here
     */
    const STATUS_REFUNDING = 'REFUNDING';

    /**
     * Money is back on the customer account
     */
    const STATUS_REFUNDED = 'REFUNDED';

    const STATUS_UNKNOWN = 'UNKNOWN';

    /**
     * Terminal id, bank give it to you
     * @var int
     */
    private $terminalId;

    public $taxation;

    public $payment_language;

    /**
     * Secret key, bank give it to you
     * @var string
     */
    private $secret;

    /**
     * @var string
     */
    private $emailCompany;

    /**
     * @var string
     */
    private $paymentMethod;

    /**
     * @var string
     */
    private $paymentObject;

    /**
     * Read API documentation
     * @var string
     */
    private $paymentUrl;

    /**
     * Current payment status
     * @var string
     */
    private $paymentStatus;

    /**
     * Payment id in bank system
     * @var int
     */
    private $paymentId;

    /**
     * Валята заказа (643 - рубли)
     * @var int
     */
    private $currency = 643;

    protected static $vats = [
        20     => 'vat20',
        18     => 'vat18',
        10     => 'vat10',
        0      => 'vat0',
        'none' => 'none',
    ];

    protected static $defaultVat = '';

    public function __construct($registry)
    {
        parent::__construct($registry);
        $this->emailCompany = $this->config->get('tinkoff_email_company');
        $this->paymentMethod = $this->config->get('tinkoff_payment_method');
        $this->paymentObject = $this->config->get('tinkoff_payment_object');
        $this->terminalId = $this->config->get('tinkoff_terminal_key');
        $this->secret = $this->config->get('tinkoff_secret_key');
        $this->taxation = $this->config->get('tinkoff_taxation');
        $this->enabled_taxation = $this->config->get('tinkoff_enabled_taxation');
        $this->currency = $this->config->get('currency');
        $this->payment_language = $this->config->get('tinkoff_payment_language');
        self::$defaultVat = self::$vats['none'];
    }

    function getTaxClassNameById($tax_class_id)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "tax_class WHERE tax_class_id = '" . (int)$tax_class_id . "'");

        return $query->row;
    }

    /**
     * Return payment link for user redirection and params for it
     *
     * @param array $params
     * @return array
     * @throws TinkoffException
     */
    public function initPayment(array $params)
    {
        $customerEmail = $this->customer->getEmail();
        $userEmail = $customerEmail ? $customerEmail : $this->cart->session->data['guest']['email'];

        $requestParams = array(
            'TerminalKey' => $this->terminalId,
            'Amount' => round($params['amount']),
            'OrderId' => $params['orderId'],
            'DATA' => array(
                'Email' => $userEmail,
                'Connection_type' => 'opencart2.3',
            ),
        );

        if ($this->enabled_taxation) {
            if ($userEmail) {
                $requestParams['Receipt'] = $this->getReceipt($params, $userEmail);
            } else {
                throw new TinkoffException(sprintf('Не был указан email. Электронный чек не может быть отправлен. Укажите email.'));
            }
        }

        if ($this->payment_language == 'en') {
            $requestParams['Language'] = 'en';
        }

        $tinkoffModel = new TinkoffMerchantAPI($this->terminalId, $this->secret);
        
        $request = $tinkoffModel->buildQuery('Init', $requestParams);
        $this->logs($requestParams, $request);
        $result = json_decode($request);

        if ($result->ErrorCode == 8) {
            die($result->Details);
        }

        $this->isRequestSuccess($result->Success);
        $this->paymentStatus = $result->Status;
        $this->paymentId = $result->PaymentId;
        $this->saveOrder($result->OrderId);

        return array(
            'url'    => $result->PaymentURL,
            'params' => array(),
        );
    }


    /**
     * Return payment link for user redirection and params for it
     *
     * @param array $params
     * @return array
     * @throws TinkoffException
     */
    public function initEmailPayment(array $params)
    {
        $customerEmail = $params['email'];
        $userEmail = $customerEmail;

        $requestParams = array(
            'TerminalKey' => $this->terminalId,
            'Amount' => round($params['amount']),
            'OrderId' => $params['orderId'],
            'DATA' => array(
                'Email' => $userEmail,
                'Connection_type' => 'opencart2.3',
            ),
        );

        if ($this->enabled_taxation) {
            if ($userEmail) {
                $requestParams['Receipt'] = $this->getMailReceipt($params, $userEmail);
            } else {
                throw new TinkoffException(sprintf('Не был указан email. Электронный чек не может быть отправлен. Укажите email.'));
            }
        }

        if ($this->payment_language == 'en') {
            $requestParams['Language'] = 'en';
        }

        $tinkoffModel = new TinkoffMerchantAPI($this->terminalId, $this->secret);
        
        $request = $tinkoffModel->buildQuery('Init', $requestParams);
        $this->logs($requestParams, $request);
        $result = json_decode($request);

        if ($result->ErrorCode == 8) {
            die($result->Details);
        }

        $this->isRequestSuccess($result->Success);
        $this->paymentStatus = $result->Status;
        $this->paymentId = $result->PaymentId;
        $this->saveOrder($result->OrderId);

        return array(
            'url'    => $result->PaymentURL,
            'params' => array(),
        );
    }

    function logs($requestParams, $request)
    {
        // log send
        $log = '[' . date('D M d H:i:s Y', time()) . '] ';
        $log .= json_encode($requestParams, JSON_UNESCAPED_UNICODE);
        $log .= "\n";
        file_put_contents(dirname(__FILE__) . "/tinkoff.log", $log, FILE_APPEND);

        $log = '[' . date('D M d H:i:s Y', time()) . '] ';
        $log .= $request;
        $log .= "\n";
        file_put_contents(dirname(__FILE__) . "/tinkoff.log", $log, FILE_APPEND);
    }

    /**
     * @param array $params
     * @param $email
     * @return array
     */
    function getReceipt(array $params, $email)
    {
        $receiptItems = array();
        $errorTaxMessage = 'Не удается оплатить заказ. Обратитесь к администратору для проверки настроек налога';
        $session = $this->cart->session->data;
        $prices = $this->getNormalizePrices($params['amount'], $this->cart->getProducts(), $this->hasShipping() ? $session['shipping_method'] : null);

        //add products data and vat to $receiptItems
        foreach ($this->cart->getProducts() as $product) {
            $vat = $this->getVat($product['price'], $product['tax_class_id']);
            $productPrices = $prices['products'];
            $id = $product['product_id'];

            $receiptItems[] = array(
                'Name' => mb_substr($product['name'], 0, 64),
                'Price' => round($productPrices[$id]),
                'Quantity' => $product['quantity'],
                'Amount' => round($productPrices[$id] * $product['quantity']),
                'Tax' => $vat,
                'PaymentMethod' => trim($this->paymentMethod),
                'PaymentObject' => trim($this->paymentObject),
            );
        }

        if (isset($this->session->data['vouchers'])) {
            $voucherPrices = $prices['vouchers'];
            foreach ($this->session->data['vouchers'] as $voucher_key => $voucher) {
                $receiptItems[] = array(
                    'Name' => mb_substr($voucher['description'], 0, 64),
                    'Price' => round($voucherPrices[$voucher_key]),
                    'Quantity' => 1,
                    'Amount' => round($voucherPrices[$voucher_key]),
                    'Tax' => 'none'
                );
            }
        }

        //add shipping vat to $receiptItems
        if ($this->hasShipping()) {
            $this->logs($session['shipping_method'], 'ship_test');
            $shippingVat = $this->getVat($session['shipping_method']['cost'], $session['shipping_method']['tax_class_id']);

            if ($prices['shipping']) {
                $receiptItems[] = array(
                    'Name' => mb_substr($session['shipping_method']['title'], 0, 64),
                    'Price' => round($prices['shipping']),
                    'Quantity' => 1,
                    'Amount' => round($prices['shipping']),
                    'Tax' => $shippingVat,
                    'PaymentMethod' => trim($this->paymentMethod),
                    'PaymentObject' => 'service',
                );
            }
        }

        if (!$this->taxation) {
            die($errorTaxMessage);
        }
        $emailCompany = mb_substr($this->emailCompany, 0, 64);
        if (!$emailCompany){
            $emailCompany = null;
        }
        $requestParams = array(
            "EmailCompany" => $emailCompany,
            "Email"    => $email,
            "Taxation" => $this->taxation,
            'Items'    => $receiptItems,
        );

        return $requestParams;
    }

    /**
     * @param array $params
     * @param $email
     * @return array
      */
    function getMailReceipt(array $params, $email)
    {
        $receiptItems = array();
        $errorTaxMessage = 'Не удается оплатить заказ. Обратитесь к администратору для проверки настроек налога';

        //add products data and vat to $receiptItems
        foreach ($params['products'] as $product) {
            $vat = $this->getVat($product['price'], false);
            $receiptItems[] = array(
                'Name' => mb_substr($product['name'], 0, 64),
                'Price' => round($product['price']),
                'Quantity' => $product['quantity'],
                'Amount' => round($product['total']),
                'Tax' => $vat,
                'PaymentMethod' => trim($this->paymentMethod),
                'PaymentObject' => trim($this->paymentObject),
            );
        }

        //add shipping vat to $receiptItems
        if ($params['order']['shipping_cost']) {
            $shippingVat = $this->getVat($params['order']['shipping_cost'], false);

            if ($params['order']['shipping_cost']) {
                $receiptItems[] = array(
                    'Name' => mb_substr($params['order']['shipping_method'], 0, 64),
                    'Price' => round($params['order']['shipping_cost']),
                    'Quantity' => 1,
                    'Amount' => round($params['order']['shipping_cost']),
                    'Tax' => $shippingVat,
                    'PaymentMethod' => trim($this->paymentMethod),
                    'PaymentObject' => 'service',
                );
            }
        }

        if (!$this->taxation) {
            die($errorTaxMessage);
        }
        $emailCompany = mb_substr($this->emailCompany, 0, 64);
        if (!$emailCompany){
            $emailCompany = null;
        }
        $requestParams = array(
            "EmailCompany" => $emailCompany,
            "Email"    => $email,
            "Taxation" => $this->taxation,
            'Items'    => $receiptItems,
        );

        return $requestParams;
    }

    /**
     * существует ли небесплатная доставка у заказа
     * @return bool
     */
    function hasShipping()
    {
        return $this->cart->hasShipping()
            && isset($this->cart->session->data['shipping_method'])
            && $this->cart->session->data['shipping_method']
            && $this->cart->session->data['shipping_method']['cost'];
    }

    /**
     * @param $amount
     * @param $products
     * @param $shipping
     * @return array
     */
    function getNormalizePrices($amount, $products, $shipping)
    {
        $prices = array();
        $realAmount = round($this->getRealAmount() * 100);
        $k = ($realAmount != $amount) ? $amount / $realAmount : 1;
        $newRealAmount = 0;

        foreach ($products as $product) {
            $id = $product['product_id'];
            $price = $this->getRoundTaxPrice(round($product['price']), $product['tax_class_id'], $k);
            $prices['products'][$id] = $price;
            $newRealAmount += round($price * $product['quantity']);
        }

        if (isset($this->session->data['vouchers'])) {
            foreach ($this->session->data['vouchers'] as $voucher_key => $voucher) {
                $id = $voucher_key;
                $voucherPrice = $voucher['amount'] * 100;
                $prices['vouchers'][$id] = $voucherPrice;
                $newRealAmount += $voucherPrice;
            }
        }

        $shippingPrice = $this->getRoundTaxPrice($shipping['cost'], $shipping['tax_class_id'], $k);
        $newRealAmount = $newRealAmount + $shippingPrice;
        $diff = $amount - $newRealAmount;

        if (abs($diff) >= 0.1) {
            $shippingPrice = $shippingPrice + $diff;
        }

        $prices['shipping'] = $shippingPrice;

        return $prices;
    }

    /**
     * цена с ндс в копейках
     * @param $price
     * @param $taxClassId
     * normalize coefficient @param $k
     * @return float
     */
    function getRoundTaxPrice($price, $taxClassId, $k)
    {
        //сумма в копейках
        return round($this->getVatPrice($price, $taxClassId) * $k * 100);
    }

    /**
     * сумма позиций в цеке (всех товаров и доставки)
     * @return int
     */
    function getRealAmount()
    {
        $realAmount = 0;

        foreach ($this->cart->getProducts() as $product) {
            $price = $this->getVatPrice($product['price'], $product['tax_class_id']);
            $realAmount += round($price * $product['quantity']);
        }
        if (isset($this->session->data['vouchers'])) {
            foreach ($this->session->data['vouchers'] as $voucher) {
                $price = $voucher['amount'];
                $realAmount += $price;
            }
        }

        if ($this->hasShipping()) {
            $shippingData = $this->cart->session->data['shipping_method'];
            $shippingPrice = $this->getVatPrice($shippingData['cost'], $shippingData['tax_class_id']);
            $realAmount += $shippingPrice;
        }

        return $realAmount;
    }

    /**
     * цену с учетом ндс
     * @param $price
     * @param $vat
     * @return mixed
     */
    public function getVatPrice($price, $vat)
    {
        return $this->cart->tax->calculate($price, $vat, true);
    }

    /**
     * ндс формата отправки в ТКС
     * @param $price
     * @param $taxClassId
     * @return bool|string
     */
    public function getVat($price, $taxClassId)
    {
        if (!$taxClassId) {
            return self::$defaultVat;
        } else {
            $taxClassRates = $this->tax->getRates($price, $taxClassId);

            if (count($taxClassRates) > 1) {
                return self::$defaultVat;
            }

            $rate = array_shift($taxClassRates);

            if ($rate['type'] != 'P') {
                return self::$defaultVat;
            }

            return isset(self::$vats[(int)$rate['rate']]) ? self::$vats[(int)$rate['rate']] : self::$defaultVat;
        }
    }

    /**
     * Check if order is complete and money paid
     *
     * @return bool
     * @throws TinkoffException
     */
    public function isOrderPaid()
    {
        $this->checkStatus();

        return in_array($this->paymentStatus, array(self::STATUS_CONFIRMED, self::STATUS_AUTHORIZED));
    }

    /**
     * Checks if oreder is failed
     *
     * @return bool
     */
    public function isOrderFailed()
    {
        return in_array($this->paymentStatus, array(self::STATUS_CANCELED, self::STATUS_REJECTED, self::STATUS_REVERSED));
    }

    public function saveOrder($orderId)
    {
        $date = new \DateTime();

        $currentDate = $date->format('Y-m-d h:i:s');

        $orders = $this->db->query("
          SELECT `id`
          FROM " . DB_PREFIX . "tinkoff_payments
          WHERE `order_id` = '" . (int)$orderId . "'");

        if ($orders->num_rows > 0) {
            $this->db->query("
			    UPDATE " . DB_PREFIX . "tinkoff_payments
			    SET payment_id = '" . $this->paymentId . "',
				    updated = '" . $currentDate . "',
				    status = '" . $this->paymentStatus . "'
			    WHERE order_id = " . (int)$orderId
            );

            return true;
        }

        $this->db->query("
            INSERT INTO `" . DB_PREFIX . "tinkoff_payments`
            SET order_id = '" . (int)$orderId . "',
			    payment_id = '" . $this->paymentId . "',
			    created = '" . $currentDate . "',
				updated = '" . $currentDate . "',
				status = '" . $this->paymentStatus . "'
        ");

        return true;
    }

    /**
     * Check is status variable is set
     *
     * @throws TinkoffException
     */
    private function checkStatus()
    {
        if (is_null($this->paymentStatus)) {
            throw new TinkoffException(sprintf('Статус заказа не определён. Чтобы запросить статус вызовите метод getStatus'));
        }

    }

    /**
     * Check bank response format
     *
     * @param $string
     * @return bool
     */
    private function isJson($string)
    {
        json_decode($string);

        return (json_last_error() == JSON_ERROR_NONE);
    }

    /**
     * Generates request signature
     *
     * @param array $params
     * @return string
     */
    private function generateToken(array $params)
    {
        $token = '';
        $args['Password'] = $this->_secretKey;
        ksort($args);

        foreach ($args as $arg) {
            $token .= $arg;
        }

        $token = hash('sha256', $token);

        return $token;
    }

    /**
     * Checks request success
     *
     * @param $success
     * @throws TinkoffException
     */
    private function isRequestSuccess($success)
    {
        if ($success == false) {
            die(sprintf('Запрос к платежному сервису был отправлен некорректно'));
        }
    }
}

/**
 * Class TinkoffException
 */
class TinkoffException extends Exception
{

}
