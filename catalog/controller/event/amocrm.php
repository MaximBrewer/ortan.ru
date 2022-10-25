<?php

use AmoCRM\Client\AmoCRMApiClient;
use AmoCRM\Exceptions\AmoCRMMissedTokenException;
use League\OAuth2\Client\Token\AccessToken;
use AmoCRM\Exceptions\AmoCRMApiException;
use AmoCRM\Models\LeadModel;
use AmoCRM\Models\ContactModel;
use AmoCRM\Client\AmoCRMApiRequest;
use AmoCRM\Collections\ContactsCollection;
use AmoCRM\Filters\ContactsFilter;
use Dotenv\Dotenv;

class ControllerEventAmocrm extends Controller
{
    public function addOrder($route, $input_data, $order_id)
    {
        $dotenv = Dotenv::createImmutable(DIR_ROOT_PATH);
        $dotenv->load();

        $clientId = $_ENV['AMO_ID'];
        $clientSecret = $_ENV['AMO_SECRET'];
        $redirectUri = 'https://ortan.ru/index.php?route=common/parse/redirect';
        $apiClient = new AmoCRMApiClient($clientId, $clientSecret, $redirectUri);
        $apiClient->setAccountBaseDomain('infoortanru.amocrm.ru');
        $accessTokenArray = json_decode(file_get_contents($_SERVER['DOCUMENT_ROOT'] . '/.htamocrm'), true);

        $accessToken = new AccessToken($accessTokenArray);
        $apiClient->setAccessToken($accessToken)
            ->onAccessTokenRefresh(
                function (AccessToken $accessToken, string $baseDomain) {
                    file_put_contents($_SERVER['DOCUMENT_ROOT'] . '/.htamocrm', json_encode(($accessToken)));
                }
            );

        if (time() > $accessTokenArray['expires']) {
            try {
                $accessToken = $apiClient->getOAuthClient()->getAccessTokenByRefreshToken($accessToken);
            } catch (AmoCRMApiException $e) {
                $log = $e->getLastRequestInfo() . ', ';
                $log .= $e->getErrorCode() . ', ';
                $log .= $e->getTitle() . ', ';
                $log .= $e->getMessage() . ', ';
                $log .= $e->getDescription() . PHP_EOL;
                file_put_contents(DIR_LOGS . "amocrm.log", $log, FILE_APPEND);
                return;
            }
        }

        $this->load->model('checkout/order');
        $order = $this->model_checkout_order->getOrder($order_id);

        try {
            $contactsService = $apiClient->contacts();
            $leadsService = $apiClient->leads();

            $contact = [
                'id' => $order['order_id'],
                'first_name' => $order['firstname'],
                'last_name' => $order['lastname'],
                'custom_fields_values' => [
                    [
                        "field_code" => "EMAIL",
                        'values' => [["enum_code" => "WORK", "value" => $order['email']]]
                    ], [
                        "field_code" => "PHONE",
                        'values' => [["enum_code" => "WORK", "value" => $order['telephone']]]
                    ]
                ]
            ];

            $oldContact = null;
            $filter = new ContactsFilter();
            $filter->setNames([$order['firstname'] . ' ' . $order['lastname']]);
            try {
                $contactModels = $contactsService->get($filter);
            } catch (AmoCRMApiException $e) {
                $contactModels = [];
            }
            foreach ($contactModels as $model) {
                $arrModel  = $model->toArray();
                foreach ($arrModel['custom_fields_values'] as $cfv) {
                    $arrModel[strtolower($cfv['field_code'])] = $cfv['values'][0]['value'];
                }
                if (
                    ($arrModel['last_name'] == $order['lastname']
                        && $arrModel['first_name'] == $order['firstname']) ||
                    ($arrModel['last_name'] == $order['firstname']
                        && $arrModel['first_name'] == $order['lastname'])
                    && $arrModel['phone'] == $order['telephone']
                    && $arrModel['email'] == $order['email']
                ) {
                    $oldContact = $model;
                    break;
                }
            }

            $contactModel = ContactModel::fromArray($contact);
            $contactModel = $oldContact ? $oldContact : $contactsService->addOne($contactModel);

            // $lead = [
            //     'id' => '', // int required
            //     'name' => '',
            //     'price' => '', // int
            //     'responsible_user_id' => '', // int
            //     'group_id' => '', // int
            //     'status_id' => '', // int
            //     'pipeline_id' => '', // int
            //     'loss_reason_id' => '', // int
            //     'source_id' => '', // int
            //     'custom_fields_values' => [],
            //     'created_by' => '', // int
            //     'updated_by' => '', // int
            //     'created_at' => '',
            //     'updated_at' => '',
            //     'closed_at' => '', // int
            //     'closest_task_at' => '', // int
            //     'is_deleted' => '', // boolean
            //     'score' => '',
            //     'account_id' => '', // int
            //     'is_price_modified_by_robot' => '', // boolean
            // ];



            $lead = [
                "id" => (int)$order['order_id'],
                "name" => "Заказ №" . $order['order_id'],
                "price" => (int)($order['total'] * $order['currency_value']),
                AmoCRMApiRequest::EMBEDDED => [
                    LeadModel::CONTACTS => []
                ]
            ];

            $settingLeads = [
                // ['amo_columns' =>  , 'shop_columns' => ]
            ];

            foreach ($settingLeads as $key => $value) {
                $lead['custom_fields_values'][] =     [
                    'field_id' => (int)$value['amo_columns'],
                    'values' => [
                        ["value" => $order[$value['shop_columns']]]
                    ]
                ];
            }

            // if (isset($setting['order_status'][$order['order_status_id']]) && $setting['order_status'][$order['order_status_id']] != "") {
            //     $sert = explode("|", $setting['order_status'][$order['order_status_id']]);
            //     $lead['custom_fields_values'][] =     [
            //         'field_id' => (int)$sert[0],
            //         'values' => [
            //             ["enum_id" => (int)$sert[1]]
            //         ]
            //     ];
            // }


            // if (!empty($lead[AmoCRMApiRequest::EMBEDDED]['tags'])) {
            //     $tagsCollection = new TagsCollection();
            //     $tagsCollection = $tagsCollection->fromArray($lead[AmoCRMApiRequest::EMBEDDED]['tags']);
            //     $leadModel->setTags($tagsCollection);
            // }

            // if (!empty($lead[AmoCRMApiRequest::EMBEDDED][self::LOSS_REASON][0])) {
            //     $lossReason = LossReasonModel::fromArray($lead[AmoCRMApiRequest::EMBEDDED][self::LOSS_REASON][0]);
            //     $leadModel->setLossReason($lossReason);
            // }

            // if (!empty($lead[AmoCRMApiRequest::EMBEDDED][EntityTypesInterface::COMPANIES][0])) {
            //     $company = CompanyModel::fromArray($lead[AmoCRMApiRequest::EMBEDDED][EntityTypesInterface::COMPANIES][0]);
            //     $leadModel->setCompany($company);
            // }

            // if (!empty($lead[AmoCRMApiRequest::EMBEDDED][self::CATALOG_ELEMENTS])) {
            //     $catalogElementsCollection = new CatalogElementsCollection();
            //     $catalogElementsCollection = $catalogElementsCollection->fromArray(
            //         $lead[AmoCRMApiRequest::EMBEDDED][self::CATALOG_ELEMENTS]
            //     );
            //     $leadModel->setCatalogElementsLinks($catalogElementsCollection);
            // }

            $leadModel = LeadModel::fromArray($lead);
            $contactsCollection = new ContactsCollection();
            $contactsCollection->add($contactModel);
            $leadModel->setContacts($contactsCollection);
            $leadsService->addOneComplex($leadModel);

            // die;
            // include_once __DIR__ . '/token_actions.php';
            // include_once __DIR__ . '/error_printer.php';


            // // Товар к Сделки
            // $product_amo = $this->model_setting_amocrm->curl_post('/api/v2/products_settings');
            // $link_add = [];
            // if (isset($product_amo['is_enabled']) && $product_amo['is_enabled']) {
            //     $getOrderProducts = $this->model_checkout_order->getOrderProducts(1305);
            //     $catalog_id = $product_amo['catalog_id'];
            //     $catalog_elements['add'] = [];
            //     foreach ($getOrderProducts as $key => $value) {
            //         if (isset($setting['other']['status']) && $setting['other']['status'] == 1) {
            //             $options = [];
            //             foreach ($this->model_checkout_order->getOrderOptions($value['order_id'], $value['order_product_id']) as $key_option => $value_option) {
            //                 $options[] = "{$value_option['name']}: {$value_option['value']}";
            //             }
            //             if (count($options) >= 1) {
            //                 $value['name'] = "{$value['name']}(" . implode(" | ", $options) . ")";
            //             }
            //         }
            //         $catalog_elements['add'][] = [
            //             'catalog_id' => $catalog_id,
            //             'name' => $value['name'],
            //             'request_id' => $value['quantity'],
            //             'custom_fields' => [
            //                 [
            //                     'code' => 'SKU',
            //                     'values' => [
            //                         ['value' => $value['model']],
            //                     ]
            //                 ],
            //                 [
            //                     'code' => 'PRICE',
            //                     'values' => [
            //                         ['value' => (string)number_format($value['price'], 0)],
            //                     ]
            //                 ],
            //                 [
            //                     'code' => 'DESCRIPTION',
            //                     'values' => [
            //                         ['value' => ''],
            //                     ]
            //                 ],
            //                 [
            //                     'code' => 'EXTERNAL_ID',
            //                     'values' => [
            //                         ['value' => $value['product_id']],
            //                     ]
            //                 ]
            //             ]
            //         ];
            //     }
            //     $product_add = $this->model_setting_amocrm->curl_post('/api/v2/catalog_elements', $catalog_elements);
            //     foreach ($product_add[AmoCRMApiRequest::EMBEDDED]['items'] as $key => $value) {
            //         $link_add[] = [
            //             'to_entity_id' => $value['id'],
            //             "to_entity_type" => "catalog_elements",
            //             'metadata' => [
            //                 // 'quantity'=> (int)$q[$value['custom_fields'][3]['values'][0]['value']],
            //                 'quantity' => $value['request_id'],
            //                 'catalog_id' => $catalog_id,
            //             ]
            //         ];
            //     }
            // }
            // if (isset($setting['task']['status']) && $setting['task']['status'] == 1) {
            //     $task = [];
            //     $task[0]['text'] = $setting['task']['text'];
            //     $task[0]['entity_type'] = 'leads';
            //     if ($setting['task']['responsible_user_id'] != "") {
            //         $task[0]['responsible_user_id'] = $setting['task']['responsible_user_id'];
            //     }
            //     $task[0]['entity_id'] = $leads_add[0]['id'];
            //     $task[0]['complete_till'] = time() + (60 * (int)$setting['task']['time']);
            //     $task_amo = $this->model_setting_amocrm->curl_post('/api/v4/tasks', $task);
            // }
            // if (count($link_add) >= 1) {
            //     $this->model_setting_amocrm->curl_post("/api/v4/leads/{$leads_add[0]['id']}/link", $link_add);
            // }
            // return true;

        } catch (AmoCRMApiException $e) {
            $log = $e->getLastRequestInfo() . ', ';
            $log .= $e->getErrorCode() . ', ';
            $log .= $e->getTitle() . ', ';
            $log .= $e->getMessage() . ', ';
            $log .= $e->getDescription() . PHP_EOL;
            file_put_contents(DIR_LOGS . "amocrm.log", $log, FILE_APPEND);
            // return $this->response->redirect($this->url->link('information/contact/success'));
        }
    }
}
