<?php
class ModelExtensionModuleBitrix24 extends Model
{
    private $b24Url = "https://ortan.bitrix24.ru";      // укажите URL своего Битрикс24
    private $b24UserID = "1";                           // ID пользователя, от имени которого будем добавлять лид
    private $b24WebHook = "925sooo5y1i5z3d3";           // код вебхука, который мы только что получили

    public function push_order($order_id)
    {
        $this->load->model('checkout/order');
        $order_info = $this->model_checkout_order->getOrder($order_id);
        $queryURL = $this->b24Url . "/rest/" . $this->b24UserID ."/" . $this->b24WebHook. "/";

        $telephone = trim($order_info['telephone']);
        $telephone = preg_replace('/[^0-9+]/isu', '', $telephone);

        //Контакт
        $contactFilter = [
            "filter" => ["PHONE" => $telephone],
            "select" => [ "ID", "NAME", "LAST_NAME"]
        ];
        $aContact = $this->query($queryURL . 'crm.contact.list.json',$contactFilter);

        if (!empty($aContact[0]['ID'])){
            $contact_id = $aContact[0]['ID'];
        } else {
            $contactUrl = $queryURL . 'crm.contact.add.json';
            $contactData = [
                "fields" => [
                    "NAME" => $order_info['firstname'],
                    "LAST_NAME" => $order_info['lastname'],
                    "PHONE" => [
                        "n1" => [
                            "VALUE" => $telephone,
                            "VALUE_TYPE" => "WEB"
                        ],
                    ],
                    "EMAIL" => [
                        "n1" => [
                            "VALUE" => $order_info['email'],
                            "VALUE_TYPE" => "WEB"
                        ],
                    ],
                ],
                'params' => array("REGISTER_SONET_EVENT" => "Y")    // Y = произвести регистрацию события добавления лида в живой ленте. Дополнительно будет отправлено уведомление ответственному за лид.
            ];

            $contact_id = $this->query($contactUrl, $contactData);
        }
        if (!$contact_id) $contact_id = 0;


        //Сделка
        $address = $this->get_address($order_info);

        $comment = $order_info['comment'];

        $info = '';
        $infoProd = '';
        $infoProd2 = ''; //для поля "для рассылок". без ссылки на товар в админке
        $aProducts = $this->get_products($order_info);

        $aProductRows = [];
        foreach ($aProducts as $product) {
            $name = trim($product['model'] . ' ' . trim($product['name']));
            if ((float)$product['special'] > 0){
                $name .= '(скидка)';
            }

            $razmer = '';
            $options = '';
            if (!empty($product['option'])){
                foreach($product['option'] as $option){
                    $options .= ($options ? ', ' : '') . $option['name'] . ':' . $option['value'];
                    if ($option['option_id'] == 11) { //Размер
                        $razmer = $option['bitrix_id'];
                    }
                }
            }
            if ($options) {
                $name .= '('.$options.')';
            }
            $prod = $product['quantity'] . ' шт. - ' . $product['rub_price'] . ' - <a href="' . $product['href'] . '">' . $name . '</a>' . ' - <a href="' . $product['location'] . '">Поставщик</a>';
            $prod2 = $product['quantity'] . ' шт. - ' . $product['rub_price']  . $name ;
            $infoProd .= ($infoProd ? '<br>' : '') . $prod;
            $infoProd2 .= ($infoProd2 ? '
			 ' : '') . $prod2;

            if (!$product['bitrix_id']){
                $product['bitrix_id'] = $this->export_product($product['product_id']);
            }
            $productRow = [
                "PRODUCT_ID" => $product['bitrix_id'],
                "PRODUCT_NAME" => $name,
                "PRICE" => $product['rub_price'],
                "QUANTITY" => $product['quantity']
            ];
/*
            if ($razmer){
                $productRow['PROPERTY_221'] = $razmer;
                $productRow['PROPERTY_219'] = '313';
            }
*/
            $aProductRows[] = $productRow;

        }
        if ($infoProd) {
            $info .= '<b>Товары</b><br> ' . $infoProd;
        }

        $infoShipping = '';
        $aShipping = $this->get_shipping($order_info);
        foreach ($aShipping as $shipping) {
            $shippingText = $shipping['title'] . ': ' . $shipping['text'];
            $infoShipping .= ($infoShipping ? '<br>' : '') . $shippingText;
            //Добавляем доставку в товары на Битрикс
            $aProductRows[] = ["PRODUCT_ID" => '33721', "PRICE" => $shipping['price'], "QUANTITY" => 1];
        }
        if ($infoShipping) {
            $info .= '<br><br> <b>Доставка</b><br> '.$infoShipping;
        }


        $isPayed = $this->is_order_payed($order_info['order_status_id']);

        $total = $this->rub($order_info['total'], $order_info['currency_code']);

        $dealUrl = $queryURL . 'crm.lead.add.json';
        $dealData = [
            "fields" => [
                "TITLE" => "Заказ ".$order_info['order_id']." c ortan.ru",
                "CONTACT_ID" => $contact_id,
                "OPENED" => "Y",
                "DATE_CREATE" => date('c',  strtotime($order_info['date_added'])),
                "CURRENCY_ID" => "RUB",
                "OPPORTUNITY" => $total,
                "COMMENTS" => $info,
                //"SOURCE_ID" => 'Интернет-магазин', //Сделка
                "SOURCE_ID" => 'STORE', //Интернет-магазин

                //Дополнительные поля ЛИД
                "UF_CRM_1661267244578" => $order_id,
                "UF_CRM_1661267509629" => $address,
                "UF_CRM_1661267716779" => $comment,
                "UF_CRM_1661267846592" => $isPayed,
                "UF_CRM_1666187862716" => $infoProd2,

                //Дополнительные поля СДЕЛКА
                "UF_CRM_1650633976280" => $order_id,
                "UF_CRM_1650639723115" => $address,
                "UF_CRM_1650970812517" => $comment,
                "UF_CRM_1651739729349" => $isPayed,
            ],
            'params' => [
                "REGISTER_SONET_EVENT" => "Y"    // Y = произвести регистрацию события добавления лида в живой ленте. Дополнительно будет отправлено уведомление ответственному за сделку.
            ]
        ];

        $dealData = $this->set_utm($dealData);

        $res = $this->query($dealUrl, $dealData);
        if (!empty($res)){
            $this->model_checkout_order->setBitrixDealId($order_id, $res);

            //сохраняем товары в заказ
            $productsUrl = $queryURL . 'crm.lead.productrows.set.json';
            $productsData = [
                'id' => $res,
                'rows' => $aProductRows
            ];

            $this->query($productsUrl, $productsData);

        }

        return $res;
    }

    public function update_order_status($order_id)
    {
        $res = false;
        if (!empty($order_id)) {
            $this->load->model('checkout/order');
            $order_info = $this->model_checkout_order->getOrder($order_id);
            $dealUrl = $this->query_url('crm.lead.update.json');
            if (!empty($order_info['bitrix24_deal_id'])) {
                $dealData = [
                    "id" => $order_info['bitrix24_deal_id'],
                    "fields" => [
                        "UF_CRM_1661267846592" => true, //Лид
                        "UF_CRM_1651739729349" => true, //Сделка
                    ],
                ];
                $res = $this->query($dealUrl, $dealData);
            }
        }
        return $res;
    }

    public function push_call($name, $email, $phone, $comment, $title)
    {
        $queryURL = $this->b24Url . "/rest/" . $this->b24UserID ."/" . $this->b24WebHook. "/";

        $telephone = trim($phone);
        $telephone = preg_replace('/[^0-9+]/isu', '', $telephone);

        //Контакт
        $contactFilter = [
            "filter" => ["PHONE" => $telephone],
            "select" => [ "ID", "NAME", "LAST_NAME"]
        ];
        $aContact = $this->query($queryURL . 'crm.contact.list.json',$contactFilter);

        if (!empty($aContact[0]['ID'])){
            $contact_id = $aContact[0]['ID'];
        } else {
            $contactUrl = $queryURL . 'crm.contact.add.json';
            $contactData = [
                "fields" => [
                    "NAME" => $name,
                    "PHONE" => [
                        "n1" => [
                            "VALUE" => $telephone,
                            "VALUE_TYPE" => "WEB"
                        ],
                    ],
                    "EMAIL" => [
                        "n1" => [
                            "VALUE" => $email,
                            "VALUE_TYPE" => "WEB"
                        ],
                    ],

                ],
                'params' => array("REGISTER_SONET_EVENT" => "Y")    // Y = произвести регистрацию события добавления лида в живой ленте. Дополнительно будет отправлено уведомление ответственному за лид.
            ];


            $contact_id = $this->query($contactUrl, $contactData);
        }
        if (!$contact_id) $contact_id = 0;


        //Сделка
        $dealUrl = $queryURL . 'crm.lead.add.json';
        $dealData = [
            "fields" => [
                "TITLE" => $title,
                "CONTACT_ID" => $contact_id,
                "OPENED" => "Y",
                "DATE_CREATE" => date('c',  time()),
                "COMMENTS" => $comment,
       ],
            'params' => [
                "REGISTER_SONET_EVENT" => "Y"    // Y = произвести регистрацию события добавления лида в живой ленте. Дополнительно будет отправлено уведомление ответственному за сделку.
            ]
        ];
        $dealData = $this->set_utm($dealData);

        $res = $this->query($dealUrl, $dealData);

        return $res;
    }

    public function export_product($product_id){
        $customer_group = 1;
        $q = "SELECT p.*, pd.*,
            (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special
            FROM " . DB_PREFIX . "product p
            LEFT JOIN " . DB_PREFIX . "product_description pd ON p.product_id=pd.product_id AND pd.language_id='1' 
            WHERE p.product_id='".(int)$product_id."'";
        $query = $this->db->query($q);
        $aProduct = $query->row;
        $bitrixId = $aProduct['bitrix_id'];

        //Бренд
        $brandName = $this->productOptionValueName($aProduct['product_id'], 14);

        //Омолгация
        //$omolgName = $this->productOptionValue($aProduct['product_id'], 40);

        //Цвет
        $colourName = $this->productOptionValueName($aProduct['product_id'], 13);

        //Размер
        //$aSize = $this->productOptionValueName($aProduct['product_id'], 11);

        //Склад
        $store = $this->getProductStore($aProduct['store']);

        //Категория
        $catBitrixId = 0;
        $aCatNames = [];
        $q = "SELECT cd.name, c.category_id, c.bitrix_id, c.parent_id, ua.keyword  FROM " . DB_PREFIX . "product_to_category p2c 
            LEFT JOIN " . DB_PREFIX . "category c ON c.category_id=p2c.category_id
            LEFT JOIN " . DB_PREFIX . "category_description cd ON cd.category_id=p2c.category_id
            LEFT JOIN " . DB_PREFIX . "url_alias ua ON ua.query=CONCAT('category_id=', c.category_id)
            WHERE p2c.product_id = '" . (int)$aProduct['product_id'] . "' AND p2c.main_category='1' AND c.category_id > 0 LIMIT 1";
        $qCats = $this->db->query($q);
        if(empty($qCats->rows)){
            $q = "SELECT cd.name, c.category_id, c.bitrix_id, c.parent_id, ua.keyword  FROM " . DB_PREFIX . "product_to_category p2c 
                LEFT JOIN " . DB_PREFIX . "category c ON c.category_id=p2c.category_id
                LEFT JOIN " . DB_PREFIX . "category_description cd ON cd.category_id=p2c.category_id
                LEFT JOIN " . DB_PREFIX . "url_alias ua ON ua.query=CONCAT('category_id=', c.category_id)
                WHERE p2c.product_id = '" . (int)$aProduct['product_id'] . "' AND c.category_id > 0 LIMIT 1";
            $qCats = $this->db->query($q);
        }
        foreach($qCats->rows as $aCat){
            $catBitrixId = (empty($catBitrixId) and !empty($aCat['bitrix_id'])) ? $aCat['bitrix_id'] : 0;
            array_unshift($aCatNames, $aCat);
        }

        $cnt = 0;
        while($aCatNames[0] && $aCatNames[0]['parent_id']){
            ++$cnt;
            if ($cnt > 6) break;
            $q = "SELECT cd.name, c.category_id, c.bitrix_id, c.parent_id, ua.keyword FROM " . DB_PREFIX . "category c 
                LEFT JOIN " . DB_PREFIX . "category_description cd ON cd.category_id=c.category_id
                LEFT JOIN " . DB_PREFIX . "url_alias ua ON ua.query=CONCAT('category_id=', c.category_id)
                WHERE c.category_id = '" . $aCatNames[0]['parent_id'] . "' LIMIT 1";
            $qCats = $this->db->query($q);
            foreach($qCats->rows as $aCat){
                array_unshift($aCatNames, $aCat);
            }
        }

        if ($aProduct['image']) {
            $pathImg = DIR_IMAGE . $aProduct['image'];
            $typeImg = pathinfo($pathImg, PATHINFO_EXTENSION);
            $dataImg = file_get_contents($pathImg);
            $base64 = base64_encode($dataImg);
            $imgFilename = 'product-'.$aProduct['product_id'] . '.' . $typeImg;
            $aImg = ['fileData'=> [$imgFilename, $base64]];
        } else {
            $aImg = false;
        }

        $links = [];

        foreach($aCatNames as $aCat){
            $links[] = $aCat['keyword'];
        }

        $links[] = $aProduct['seo_keyword'];
        $link = trim(implode("/", $links), "/");
        $link = "https://ortan.ru/" . $link. "/";

        $name = trim($aProduct['model'] . ' ' . trim($aProduct['name']));

        $price = $aProduct['rub_price'];
        if ((float)$aProduct['special']) {
            $price = $aProduct['special'];
            $name .= ' (скидка)';
        }

        $aData = [
            'NAME' => $name,
            'DATE_CREATED' => date('Y-m-d H:i:s'),
            'DESCRIPTION' => htmlspecialchars_decode($aProduct['description']),
            'DESCRIPTION_TYPE' => 'html',
            'MEASURE' => 'шт.',
            'PRICE' => $price,
            'SECTION_ID' => $catBitrixId,

            'PROPERTY_191' => $aProduct['product_id'],
            'PROPERTY_111' => $aProduct['model'],
            'PROPERTY_115' => $colourName,
            'PROPERTY_193' => $brandName,
            'PROPERTY_199' => $link,
            'PROPERTY_201' => $store,
/*
                'PREVIEW_PICTURE' => $thumb,

                'SIZE' => $sizeName,
                'SIZES' => $sizes,

                'category1' => isset($categories[0]) && !empty($categories[0]) ? $categories[0]['name'] : '',
                'category2' => isset($categories[1]) && !empty($categories[1]) ? $categories[1]['name'] : '',
                'category3' => isset($categories[2]) && !empty($categories[2]) ? $categories[2]['name'] : '',

                'omolgType' => $omolgName,
*/
        ];
        if (!empty($aImg) and empty($aProduct['bitrix_id'])){
            $data['DETAIL_PICTURE'] = $aImg;
        }

        if (!$aProduct['bitrix_id']) {
            $productUrl = $this->query_url('crm.product.add.json');
            $productData = [
                'fields' => $aData
            ];
            $bitrixId = $this->query($productUrl, $productData);
        } else {
            $productUrl = $this->query_url('crm.product.update.json');
            $productData = [
                'id' => $bitrixId,
                'fields' => $aData
            ];
            $this->query($productUrl, $productData);
        }

        $bitrixId = !empty($aProduct['bitrix_id']) ? $aProduct['bitrix_id'] : $bitrixId;
        $q = "UPDATE " . DB_PREFIX . "product
            SET bitrix_id='" . (int)$bitrixId . "', bitrix_uploaded='" . date('Y-m-d H:i:s') . "' 
            WHERE product_id='" . (int)$aProduct['product_id'] . "'";
        $this->db->query($q);

        return $bitrixId;
    }

    public function export_category($bitrixId, $data){
        $res = 0;
        if (empty($bitrixId)) {
            $productUrl = $this->query_url('crm.productsection.add.json');
            $productData = [
                'fields' => [
                    'NAME'=> $data['cd_name'],
                    'SECTION_ID' => $data['pa_bitrix_id']
                ]
            ];
            $res = $this->query($productUrl, $productData);
        } else {
            $productUrl = $this->query_url('crm.productsection.update.json');
            $productData = [
                'id' => $bitrixId,
                'fields' => [
                    'NAME'=> $data['cd_name'],
                    'SECTION_ID' => $data['pa_bitrix_id']
                ]
            ];
            $this->query($productUrl, $productData);
            $res = $bitrixId;
        }
        return $res;
    }

    public function get_properties(){
        $productUrl = $this->query_url('crm.deal.property.list.json');
        $res = $this->query($productUrl,[]);
        return $res;
    }

    public function get_property($id){
        $productUrl = $this->query_url('crm.product.property.get.json');
        $res = $this->query($productUrl,['id' => $id]);
        return $res;
    }

    public function update_property_values($id, $aOptionValues)
    {
        //сохраняем ID в SORT
        $aValues = [];
        $i = 0;
        foreach ($aOptionValues as $aOptionValue){
            $optionValueId = $aOptionValue['option_value_id'];
            $bitrixValueId = isset($aOptionValue['bitrix_id']) ? $aOptionValue['bitrix_id'] : 0;

            if (!$bitrixValueId) {
                $i++;
                $bitrixValueId = 'new' . $i;
            }

            $aValues[$bitrixValueId] = [
                'ID' => $bitrixValueId,
                'VALUE' => $aOptionValue['name'],
                'SORT' => $optionValueId,
            ];
        }

        $aData = [
            'id' => $id,
            'fields' => [
                'VALUES' => $aValues
            ]
        ];
        $propertyUpdateUrl = $this->query_url('crm.product.property.update.json');
        //$propertyUpdateUrl = $this->query_url('sale.property.update.json');
        $res = $this->query($propertyUpdateUrl, $aData);

        //обновляем bitrix_id в опциях и sort_order в битрикс
        $aVals = [];
        $aProperty = $this->get_property($id);
        $aPropertyValues = !empty($aProperty['VALUES']) ? $aProperty['VALUES'] : [];
        foreach ($aPropertyValues as $aPropertyVal) {
            $aVals[$aPropertyVal['SORT']] = $aPropertyVal['ID'];
        }

        $aValues = [];
        foreach ($aOptionValues as $aOptionValue){
            $optionValueId = $aOptionValue['option_value_id'];
            $bitrixValueId = isset($aOptionValue['bitrix_id']) ? $aOptionValue['bitrix_id'] : 0;

            if (!$bitrixValueId) {
                $bitrixValueId = isset($aVals[$optionValueId]) ? $aVals[$optionValueId] : 0;
                $q = "UPDATE " . DB_PREFIX . "option_value SET bitrix_id='" . (int)$bitrixValueId . "' WHERE option_value_id='" . (int)$optionValueId . "'";
                $this->db->query($q);
            }

            $aValues[$bitrixValueId] = [
                'ID' => $bitrixValueId,
                'VALUE' => $aOptionValue['name'],
                'SORT' => $aOptionValue['sort_order'],
            ];
        }

        $aData = [
            'id' => $id,
            'fields' => [
                'VALUES' => $aValues
            ]
        ];
        $propertyUpdateUrl = $this->query_url('crm.product.property.update.json');
        //$propertyUpdateUrl = $this->query_url('sale.property.update.json');
        $res = $this->query($propertyUpdateUrl, $aData);

        return $res;
    }

    private function query_url($url = ''):string
    {
        return $this->b24Url . "/rest/" . $this->b24UserID ."/" . $this->b24WebHook. "/" . $url;
    }
    // отправляем запрос в Б24 и обрабатываем ответ

    private function query($url, $data){
        $qData =  http_build_query($data);

        $curl = curl_init();
        curl_setopt_array($curl, [
            CURLOPT_SSL_VERIFYPEER => 0,
            CURLOPT_POST => 1,
            CURLOPT_HEADER => 0,
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_URL => $url,
            CURLOPT_POSTFIELDS => $qData,
        ]);
        $result = curl_exec($curl);
        curl_close($curl);
        $result = json_decode($result, 1);
        $res = '';
        if (!array_key_exists('error', $result)) {
            if (!empty($result['result'])){
                $res = $result['result'];
            }
        }

        return $res;
    }

    private function get_address($order_info):string
    {
        $address = '';

        if(!empty($this->session->data['cdek']['pvzinfo'])) {
            $address = 'ПВЗ: ' . $this->session->data['cdek']['pvzinfo'];
        } else {
            $comment = $order_info['comment'];
            if (strpos($comment, '[CDEK]') !== false) {
                preg_match('/CDEK](.*)\[\/CDEK/ui', $comment, $aMatch);
                $address = !empty($aMatch[0][1]) ? $aMatch[0][1] : '';
            }
        }

        if (!$address) {
            $format = 'Курьером: {country}, {zone}, {city}, {address_1} {address_2}';

            $find = array(
                '{firstname}',
                '{lastname}',
                '{company}',
                '{address_1}',
                '{address_2}',
                '{city}',
                '{postcode}',
                '{zone}',
                '{zone_code}',
                '{country}'
            );

            $replace = array(
                'firstname' => $order_info['shipping_firstname'],
                'lastname' => $order_info['shipping_lastname'],
                'company' => $order_info['shipping_company'],
                'address_1' => $order_info['shipping_address_1'],
                'address_2' => $order_info['shipping_address_2'],
                'city' => $order_info['shipping_city'],
                'postcode' => $order_info['shipping_postcode'],
                'zone' => $order_info['shipping_zone'],
                'zone_code' => $order_info['shipping_zone_code'],
                'country' => $order_info['shipping_country']
            );

            $address = trim(str_replace($find, $replace, $format));
        }

        return $address;
    }

    private function get_products($order_info):array
    {
        $order_id = $order_info['order_id'];

        $aProducts = [];

        $customer_group = 1;
        $order_product_query = $this->db->query("SELECT op.*, ov.bitrix_id ov_bitrix_id,
            (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special,
            p.bitrix_id, p.location FROM " . DB_PREFIX . "order_product op
            LEFT JOIN " . DB_PREFIX . "product p ON p.product_id=op.product_id
            LEFT JOIN " . DB_PREFIX . "order_option oo ON op.order_product_id=oo.order_product_id
            LEFT JOIN " . DB_PREFIX . "product_option_value pov ON pov.product_option_value_id=oo.product_option_value_id
            LEFT JOIN " . DB_PREFIX . "option_value ov ON ov.option_value_id=pov.option_value_id
            WHERE op.order_id = '" . (int)$order_id . "'");
        foreach ($order_product_query->rows as $product) {
            $option_data = array();

            $order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$product['order_product_id'] . "'");

            foreach ($order_option_query->rows as $option) {
                $value = $option['value'];
                $option_data[] = array(
                    'option_id'  => $option['option_id'],
                    'bitrix_id'  => $option['ov_bitrix_id'],
                    'name'  => $option['name'],
                    'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
                );
            }


            $price = (float)$product['special'] ? $product['special'] : $product['price'];

            $aProducts[] = [
                'product_id' => $product['product_id'],
                'bitrix_id'  => $product['bitrix_id'],
                'name'       => $product['name'],
                'location'       => $product['location'],
                'href'       => HTTPS_SERVER . 'admin/index.php?route=catalog/product/edit&product_id=' . $product['product_id'],
                'model'      => $product['model'],
                'option'     => $option_data,
                'quantity'   => $product['quantity'],
                'rub_price'  => $price,
                'special'    => $product['special'],
                'price'      => $this->currency->format($product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value']),
                'total'      => $this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value'])
            ];
        }
        return $aProducts;
    }

    private function get_totals($order_info):array
    {
        $order_id = $order_info['order_id'];

        $totals = [];

        $order_total_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_id . "' ORDER BY sort_order ASC");

        foreach ($order_total_query->rows as $total) {
            if(!(float)$total['value']) continue;
            $totals[] = array(
                'title' => $total['title'],
                'text'  => $this->currency->format($total['value'], $order_info['currency_code'], $order_info['currency_value']),
            );
        }

        return $totals;
    }

    private function get_shipping($order_info):array
    {
        $order_id = $order_info['order_id'];

        $totals = [];

        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_id . "' AND code = 'shipping'");

        foreach ($query->rows as $total) {
            if(!(float)$total['value']) continue;
            $totals[] = array(
                'title' => $total['title'],
                'text'  => $this->currency->format($total['value'], $order_info['currency_code'], $order_info['currency_value']),
                'price'  => $this->rub($total['value'], $order_info['currency_value'])
            );
        }

        return $totals;
    }

    private function is_order_payed($order_status_id):bool
    {
        $isPayed = false;
        if (in_array((int)$order_status_id, [2])){
            $isPayed = true;
        }
        return $isPayed;
    }

    private function set_utm($data):array
    {
        foreach (['utm_source', 'utm_medium', 'utm_campaign', 'utm_content', 'utm_term'] as $utmName) {
            if(isset($_COOKIE[$utmName])) {
                $fieldName = strtoupper($utmName);
                $data["fields"][$fieldName] = $_COOKIE[$utmName];
            }
        }
        return $data;
    }

    private function rub($amount, $currency){
        $decimal_place = $this->currencies[$currency]['decimal_place'];
        $val = round($amount, (int)$decimal_place);

        return $val;
    }

    private function productOptionValue($product_id, $option_id){
        $aRes = [
            'option_value_id' => 0,
            'bitrix_id' => 0,
            'name' => ''
        ];

        $q = "SELECT ov.option_value_id, ov.bitrix_id, ovd.name FROM " . DB_PREFIX . "product_option_value pov
            LEFT JOIN " . DB_PREFIX . "option_value ov ON ov.option_value_id=pov.option_value_id AND ov.option_id='". (int)$option_id ."' 
            LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON ovd.option_value_id=pov.option_value_id AND ovd.option_id='". (int)$option_id ."' AND ovd.language_id='1' 
            WHERE pov.product_id='" . (int)$product_id . "' AND pov.option_id='". (int)$option_id ."'";
        $qRes = $this->db->query($q);
        if (!empty($qRes->row)) {
            $aRes = $qRes->row;
        }

        return $aRes;
    }

    private function productOptionValueName($product_id, $option_id){
        $q = "SELECT ovd.name FROM " . DB_PREFIX . "product_option_value pov
            LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON ovd.option_value_id=pov.option_value_id AND ovd.option_id='". (int)$option_id ."' AND ovd.language_id='1' 
            WHERE pov.product_id='" . (int)$product_id . "' AND pov.option_id='". (int)$option_id ."'";
        $qRes = $this->db->query($q);
        $aRes = !empty($qRes->row) ? $qRes->row : [];

        return !empty($aRes['name']) ? $aRes['name'] : '';
    }

    public function getProductStore($store) {
        $stores = [
            1 => 'Россия',
            2 => 'Беларусь',
            3 => 'Китай'
        ];
        if(isset($stores[$store])){
            return $stores[$store];
        } else {
            return 'Россия';
        }
    }

}