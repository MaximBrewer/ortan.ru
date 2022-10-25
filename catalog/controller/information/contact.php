<?php

use AmoCRM\Client\AmoCRMApiClient;
use AmoCRM\Exceptions\AmoCRMMissedTokenException;
use Dotenv\Dotenv;
use League\OAuth2\Client\Token\AccessToken;
use AmoCRM\Exceptions\AmoCRMApiException;
use AmoCRM\Models\LeadModel;
use AmoCRM\Models\ContactModel;
use AmoCRM\Client\AmoCRMApiRequest;
use AmoCRM\Collections\ContactsCollection;
use AmoCRM\Filters\ContactsFilter;


class ControllerInformationContact extends Controller
{
	private $error = array();
	private $errorSkip = array();

	public function index()
	{
		$this->load->language('information/contact');

		$this->document->setTitle($this->language->get('heading_title'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			if (!empty($this->errorSkip)) {
				return $this->response->redirect($this->url->link('information/contact/success'));
			}

            $name = !empty($this->request->post['name']) ? $this->request->post['name'] : '';
            $email = !empty($this->request->post['email']) ? $this->request->post['email'] : '';
            $phone = !empty($this->request->post['phone']) ? $this->request->post['phone'] : '';
            $enquiry = !empty($this->request->post['enquiry']) ? $this->request->post['enquiry'] : '';
            $form_title = !empty($name) ? 'Вопрос с сайта' : 'Заказ звонка с сайта';
            $this->load->model('extension/module/bitrix24');
            $this->model_extension_module_bitrix24->push_call($name, $email, $phone, $enquiry, $form_title);

			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$message = " ";
			$message .= isset($this->request->post['name']) && $this->request->post['name'] ? 'Имя: ' . $this->request->post['name'] . PHP_EOL : "";
			$message .= isset($this->request->post['email']) && $this->request->post['email']  ? 'E-mail: ' . $this->request->post['email'] . PHP_EOL : "";
			$message .= isset($this->request->post['phone']) && $this->request->post['phone']  ? 'Телефон: ' . $this->request->post['phone'] . PHP_EOL : "";
			$message .= isset($this->request->post['enquiry']) && $this->request->post['enquiry']  ? 'Сообщение: ' . $this->request->post['enquiry'] . PHP_EOL : "";

			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_email'));
			if (isset($this->request->post['email']) && $this->request->post['email']) $mail->setReplyTo($this->request->post['email']);
			$mail->setSender(html_entity_decode(isset($this->request->post['name']) && $this->request->post['name'] ? $this->request->post['name'] :  $this->request->post['phone'], ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(html_entity_decode(sprintf($this->language->get('email_subject')), ENT_QUOTES, 'UTF-8'));
			$mail->setText($message);
			try {
				$mail->send();
			} catch (\Exception $e) {
				$log = $e->getMessage() . PHP_EOL;
				file_put_contents(DIR_LOGS . "sendmail.log", $log, FILE_APPEND);
				return $this->response->redirect($this->url->link('information/contact/success'));
			}

			$name = isset($this->request->post['name']) && $this->request->post['name'] ? $this->request->post['name'] : $this->request->post['phone'];
			$email = isset($this->request->post['email']) ? $this->request->post['email'] : '';
			//$phone = $this->request->post['phone'];

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
					return $this->response->redirect($this->url->link('information/contact/success'));
				}
			}

			try {
				$contactsService = $apiClient->contacts();
				$leadsService = $apiClient->leads();
			} catch (AmoCRMApiException $e) {
				$log = $e->getLastRequestInfo() . ', ';
				$log .= $e->getErrorCode() . ', ';
				$log .= $e->getTitle() . ', ';
				$log .= $e->getMessage() . ', ';
				$log .= $e->getDescription() . PHP_EOL;
				file_put_contents(DIR_LOGS . "amocrm.log", $log, FILE_APPEND);
				return $this->response->redirect($this->url->link('information/contact/success'));
			}



			$contact = [
				'id' => microtime(),
				'first_name' => $name,
				'custom_fields_values' => [
					[
						"field_code" => "EMAIL",
						'values' => [["enum_code" => "WORK", "value" => $email]]
					], [
						"field_code" => "PHONE",
						'values' => [["enum_code" => "WORK", "value" => $phone]]
					]
				]
			];

			$oldContact = null;
			$filter = new ContactsFilter();
			$filter->setNames([$name]);
			try {
				$contactModels = $contactsService->get($filter);
			} catch (AmoCRMApiException $e) {
				$log = $e->getLastRequestInfo() . ', ';
				$log .= $e->getErrorCode() . ', ';
				$log .= $e->getTitle() . ', ';
				$log .= $e->getDescription() . PHP_EOL;
				file_put_contents(DIR_LOGS . "amocrm.log", $log, FILE_APPEND);
				$contactModels = [];
			}
			foreach ($contactModels as $model) {
				$arrModel  = $model->toArray();
				foreach ($arrModel['custom_fields_values'] as $cfv) {
					$arrModel[strtolower($cfv['field_code'])] = $cfv['values'][0]['value'];
				}
				if (
					($arrModel['last_name'] == $name ||
						$arrModel['first_name'] == $name)
					&& $arrModel['phone'] == $phone
					&& $arrModel['email'] == $email
				) {
					$oldContact = $model;
					break;
				}
			}


			$contactModel = ContactModel::fromArray($contact);

			try {
				$contactModel = $oldContact ? $oldContact : $contactsService->addOne($contactModel);
			} catch (AmoCRMApiException $e) {
				$log = $e->getLastRequestInfo() . ', ';
				$log .= $e->getErrorCode() . ', ';
				$log .= $e->getTitle() . ', ';
				$log .= $e->getDescription() . PHP_EOL;
				file_put_contents(DIR_LOGS . "amocrm.log", $log, FILE_APPEND);
			}


			$lead = [
				"id" => microtime(),
				"name" => "Заявка с формы обратной связи"
			];
			$leadModel = LeadModel::fromArray($lead);
			$contactsCollection = new ContactsCollection();
			$contactsCollection->add($contactModel);
			$leadModel->setContacts($contactsCollection);

			try {
				$leadsService->addOneComplex($leadModel);
			} catch (AmoCRMApiException $e) {
				$log = $e->getLastRequestInfo() . ', ';
				$log .= $e->getErrorCode() . ', ';
				$log .= $e->getTitle() . ', ';
				$log .= $e->getDescription() . PHP_EOL;
				file_put_contents(DIR_LOGS . "amocrm.log", $log, FILE_APPEND);
			}

			$this->response->redirect($this->url->link('information/contact/success'));
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('information/contact')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_location'] = $this->language->get('text_location');
		$data['text_store'] = $this->language->get('text_store');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_address'] = $this->language->get('text_address');
		$data['text_telephone'] = $this->language->get('text_telephone');
		$data['text_fax'] = $this->language->get('text_fax');
		$data['text_open'] = $this->language->get('text_open');
		$data['text_comment'] = $this->language->get('text_comment');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_enquiry'] = $this->language->get('entry_enquiry');

		$data['button_map'] = $this->language->get('button_map');

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}



		if (isset($this->error['enquiry'])) {
			$data['error_enquiry'] = $this->error['enquiry'];
		} else {
			$data['error_enquiry'] = '';
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

		$data['action'] = $this->url->link('information/contact', '', true);

		$this->load->model('tool/image');

		if ($this->config->get('config_image')) {
			$data['image'] = $this->model_tool_image->resize($this->config->get('config_image'), $this->config->get($this->config->get('config_theme') . '_image_location_width'), $this->config->get($this->config->get('config_theme') . '_image_location_height'));
		} else {
			$data['image'] = false;
		}

		$data['store'] = $this->config->get('config_name');
		$data['address'] = nl2br($this->config->get('config_address'));
		$data['geocode'] = $this->config->get('config_geocode');
		$data['geocode_hl'] = $this->config->get('config_language');
		$data['telephone'] = $this->config->get('config_telephone');
		$data['fax'] = $this->config->get('config_fax');
		$data['open'] = nl2br($this->config->get('config_open'));
		$data['comment'] = $this->config->get('config_comment');

		$data['locations'] = array();

		$this->load->model('localisation/location');

		//        $this->config->get('config_location');

		$data['locc'] = $this->config->get('locationn');
		foreach ((array)$this->config->get('config_location') as $location_id) {
			$location_info = $this->model_localisation_location->getLocation($location_id['city_id']);

			if ($location_info) {
				$image = false;

				$data['locations'][] = array(
					'location_id' => $location_info['location_id'],
					'name'        => $location_info['name'],
					'address'     => nl2br($location_info['address']),
					'geocode'     => $location_info['geocode'],
					'telephone'   => $location_info['telephone'],
					'fax'         => $location_info['fax'],
					'image'       => $image,
					'open'        => nl2br($location_info['open']),
					'comment'     => $location_info['comment']
				);
			}
		}

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} else {
			$data['name'] = $this->customer->getFirstName();
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} else {
			$data['email'] = $this->customer->getEmail();
		}

		if (isset($this->request->post['enquiry'])) {
			$data['enquiry'] = $this->request->post['enquiry'];
		} else {
			$data['enquiry'] = '';
		}

		if (isset($this->request->post['agree'])) {
			$data['agree'] = $this->request->post['agree'];
		} else {
			$data['agree'] = '';
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

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (isset($this->request->post['ajax'])) {
			return $this->response->setOutput($this->load->view('information/contact_form', $data));
		}

		$data['config'] = $this->model_setting_setting->getSetting('config');

		$this->response->setOutput($this->load->view('information/contact', $data));
	}

	protected function validate()
	{

		if(!isset($this->request->post['ajax'])) $this->errorSkip['name'] = 'Имя некорректно';

		// if (isset($this->request->post['name']) && $this->request->post['name']) {
		// 	$name = trim($this->request->post['name']);
		// 	if (preg_match("/[0-9]+/u", $name)) {
		// 		$this->error['name'] = 'Имя некорректно';
		// 	} elseif (preg_match("/^[a-zA-Z]+[a-zA-Z\s\.]*$/u", $name)) {
		// 		// echo "eng" . PHP_EOL;
		// 		if (preg_match("/^[A-Z]+[A-Z\s]*$/u", $name)) {
		// 			// echo "eng upper" . PHP_EOL;
		// 		} elseif (preg_match("/^[a-z]+[a-z\s]*$/u", $name)) {
		// 			// echo "eng lower" . PHP_EOL;
		// 		} elseif (preg_match("/^[A-Z]+[a-z]+$/u", $name)) {
		// 			// echo "eng camelcase one" . PHP_EOL;
		// 		} elseif (preg_match("/^[A-Z]+[a-z]+\s+[A-Z]+[a-z]+$/u", $name)) {
		// 			// echo "eng camelcase two" . PHP_EOL;
		// 		} elseif (preg_match("/^[A-Z]+[a-z]+\s+[A-Z]+[a-z]+\s+[A-Z]+[a-z]+$/u", $name)) {
		// 			// echo "eng camelcase three" . PHP_EOL;
		// 		} elseif (preg_match("/^[A-Z]+[a-z]+\s+[A-Z]\.\s*[A-Z]*\.*$/u", $name)) {
		// 			// echo "eng camelcase fio" . PHP_EOL;
		// 		} elseif (preg_match("/^[A-Z]+\s+[A-Z]\.\s*[A-Z]*\.*$/u", $name)) {
		// 			// echo "eng upper fio" . PHP_EOL;
		// 		} elseif (preg_match("/^[a-z]+\s+[a-z]\.\s*[a-z]*\.*$/u", $name)) {
		// 			// echo "eng lower fio" . PHP_EOL;
		// 		} else {
		// 			$this->errorSkip['name'] = 'Имя некорректно';
		// 		}
		// 	} elseif (preg_match("/^[а-яА-ЯёЁ]+[а-яА-ЯёЁ\s\.]*$/u", $name)) {
		// 		// echo "rus" . PHP_EOL;
		// 		if (preg_match("/^[А-ЯЁ]+[А-ЯЁ\s]*$/u", $name)) {
		// 			// echo "rus upper" . PHP_EOL;
		// 		} elseif (preg_match("/^[а-яё]+[а-яё\s]*$/u", $name)) {
		// 			// echo "rus lower" . PHP_EOL;
		// 		} elseif (preg_match("/^[А-ЯЁ]+[а-яё]+$/u", $name)) {
		// 			// echo "rus camelcase one" . PHP_EOL;
		// 		} elseif (preg_match("/^[А-ЯЁ]+[а-яё]+\s+[А-ЯЁ]+[а-яё]+$/u", $name)) {
		// 			// echo "rus camelcase two" . PHP_EOL;
		// 		} elseif (preg_match("/^[А-ЯЁ]+[а-яё]+\s+[А-ЯЁ]+[а-яё]+\s+[А-ЯЁ]+[а-яё]+$/u", $name)) {
		// 			// echo "rus camelcase three" . PHP_EOL;
		// 		} elseif (preg_match("/^[А-ЯЁ]+[а-яё]+\s+[А-ЯЁ]\.\s*[А-ЯЁ]*\.*$/u", $name)) {
		// 			// echo "rus camelcase fio" . PHP_EOL;
		// 		} elseif (preg_match("/^[А-ЯЁ]+\s+[А-ЯЁ]\.\s*[А-ЯЁ]*\.*$/u", $name)) {
		// 			// echo "rus upper fio" . PHP_EOL;
		// 		} elseif (preg_match("/^[а-яё]+\s+[а-яё]\.\s*[а-яё]*\.*$/u", $name)) {
		// 			// echo "rus lower fio" . PHP_EOL;
		// 		} else {
		// 			$this->error['name'] = 'Имя некорректно';
		// 		}
		// 	}
		// }

		if (!$this->request->post['agree']) {
			$this->error['agree'] = 'Необходимо согласие';
		}
		if (strlen($this->request->post['phone']) < 10) {
			$this->error['phone'] = 'Пожалуйста введите корректный номер телефона';
		}

		// if (!preg_match($this->config->get('config_mail_regexp'), $this->request->post['email'])) {
		// 	$this->error['email'] = $this->language->get('error_email');
		// }

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

		$this->load->language('information/contact');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('information/contact')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_message'] = $this->language->get('text_success');

		$data['button_continue'] = $this->language->get('button_continue');

		$data['continue'] = $this->url->link('common/home');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('common/success', $data));
	}
}
