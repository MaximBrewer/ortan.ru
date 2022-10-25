<?php

class ControllerExtensionModuleAmocrm extends Controller {
	private $error = array();

	public function install() {
		$this->load->model('extension/event');
		// $this->model_extension_event->addEvent('amocrm_checkout_addorder', 'catalog/model/checkout/order/addOrder/after', 'event/amocrm/addOrder');
	}
	public function uninstall() {
		$this->load->model('extension/event');
		// $this->model_extension_event->deleteEvent('amocrm_checkout_addorder');
		// $this->model_extension_event->deleteEvent('extension_amocrm_checkout_adorder');
		
	}

	public function index() {
		$this->load->language('extension/module/amocrm');


		$data['heading_title'] = $this->language->get('heading_title');
		$data['entry_code'] = $this->language->get('entry_code');
		$data['entry_client_id'] = $this->language->get('entry_client_id');
		$data['entry_referer'] = $this->language->get('entry_referer');
		// Text
		$data['text_extension'] = $this->language->get('text_extension');
		$data['text_success'] = $this->language->get('text_success');
		$data['text_edit'] = $this->language->get('text_edit');
		
		// Entry
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_client_secret'] = $this->language->get('entry_client_secret');
		$data['entry_shop_columns'] = $this->language->get('entry_shop_columns');
		$data['entry_amo_columns'] = $this->language->get('entry_amo_columns');
		$data['entry_amo_leads'] = $this->language->get('entry_amo_leads');
		$data['entry_amo_contacts'] = $this->language->get('entry_amo_contacts');
		$data['entry_amo_task'] = $this->language->get('entry_amo_task');
		$data['entry_amo_list'] = $this->language->get('entry_amo_list');
		$data['entry_name_s'] = $this->language->get('entry_name_s');
		$data['entry_amo_columns'] = $this->language->get('entry_amo_columns');
		$data['entry_amo_task_text'] = $this->language->get('entry_amo_task_text');
		$data['entry_amo_task_create'] = $this->language->get('entry_amo_task_create');
		$data['entry_amo_task_on'] = $this->language->get('entry_amo_task_on');
		$data['entry_amo_task_off'] = $this->language->get('entry_amo_task_off');
		$data['entry_amo_setting_other'] = $this->language->get('entry_amo_setting_other');
		$data['entry_amo_other_options'] = $this->language->get('entry_amo_other_options');
		$data['entry_amo_task_time'] = $this->language->get('entry_amo_task_time');
		$data['entry_amo_setting'] = $this->language->get('entry_amo_setting');
		$data['entry_amo_task_user_id'] = $this->language->get('entry_amo_task_user_id');
		$data['error_permission'] = $this->language->get('error_permission');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module');
		$this->load->model('extension/module/amocrm');

		$this->load->model('extension/module');

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}else{
			$module_info = false;
		}

		if(isset($module_info['order_status'])){
			$data['order_shop_status'] = $module_info['order_status'];
		}else{
			$data['order_shop_status'] = [];
		}
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('amocrm', $this->request->post);
			} else {
				$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
				$module_info['leads'] = [];
				$module_info['contacts'] = []; 
				$module_info['other'] = []; 
				$module_info['task'] = []; 
				$module_info['order_status'] = []; 
				foreach ($this->request->post as $key => $value) {
					$module_info[$key] = $value;
				}
				$this->model_extension_module->editModule($this->request->get['module_id'], $module_info);
			}
			$this->session->data['success'] = $this->language->get('text_success');
			$this->response->redirect($this->url->link('marketplace/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}
		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('marketplace/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);
		if (!isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/module/amocrm', 'token=' . $this->session->data['token'], true)
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/module/amocrm', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true)
			);
		}
		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('extension/module/amocrm', 'token=' . $this->session->data['token'], true);
		} else {
			$data['action'] = $this->url->link('extension/module/amocrm', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true);
		}
		$data['cancel'] = $this->url->link('marketplace/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}
		if (isset($this->request->post['code'])) {
			$data['code'] = $this->request->post['code'];
		} elseif (!empty($module_info)) {
			$data['code'] = $module_info['code'];
		} else {
			$data['code'] = '';
		}
		if (isset($this->request->post['client_id'])) {
			$data['client_id'] = $this->request->post['client_id'];
		} elseif (!empty($module_info)) {
			$data['client_id'] = $module_info['client_id'];
		} else {
			$data['client_id'] = '';
		}
		if (isset($this->request->post['referer'])) {
			$data['referer'] = $this->request->post['referer'];
		} elseif (!empty($module_info)) {
			$data['referer'] = $module_info['referer'];
		} else {
			$data['referer'] = '';
		}
		if (isset($module_info['client_secret'])) {
			$data['client_secret'] = $module_info['client_secret'];
		} else {
			$data['client_secret'] = '';
		}
		$data['leads_rows_shops'] = [];
		foreach ($this->model_extension_module_amocrm->getColumsOrder() as $key => $value) {
			$data['leads_rows_shops'][$value['COLUMN_NAME']] = $value['COLUMN_NAME'];
		}
		if(isset($module_info['contacts'])){
			$data['contacts_count'] = count($module_info['contacts']);
			$data['contacts'] = $module_info['contacts'];
		}else{
			$data['contacts_count'] = 0;
			$data['contacts'] = [];
		}
		if(isset($module_info['leads'])){
			$data['leads'] = $module_info['leads'];
			$data['leads_count'] = count($module_info['leads']);
		}else{
			$data['leads'] = [];
			$data['leads_count'] = 0;
		}
		if(isset($module_info['other'])){
			$data['other'] = $module_info['other'];
		}else{
			$data['other'] = [];
		}
		if(isset($module_info['task'])){
			$data['task'] = $module_info['task'];
		}else{
			$data['task'] = [];
		}

		
		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}
		$amo_fileds = $this->model_extension_module_amocrm->leads_custom_fields();
		$data['order_status'] = $this->model_extension_module_amocrm->getOrderStatus();
		$data['amo_fileds'] = [];
		$data['amo_fileds_selects'] = [];
		if(isset($amo_fileds['_embedded']['custom_fields'])){
			foreach ($amo_fileds['_embedded']['custom_fields'] as $key => $value) {
				if($value['type'] == "text"){
					$data['amo_fileds'][] = [
						'id'=>$value['id'],	
						'name'=>$value['name']
					];
				}elseif($value['type'] == "select"){

						$enums = [];
						foreach ($value['enums'] as $enum) {
							$enums[]=[
									'id'=>$enum['id'],
									'value'=>$enum['value'],
									'selected'=>$value['id']."|".$enum['id']
							];
						}
						$data['amo_fileds_selects'][]=[
								'id'=>$value['id'],	
								'name'=>$value['name'],
								'values'=>$enums
						];
				}else if($value['type'] == 'numeric'){
						$data['amo_fileds'][] = [
						'id'=>$value['id'],	
						'name'=>$value['name']
					];
				}
			}
		}

	
		$data['amo_fileds'] = array_reverse($data['amo_fileds']);

		$amo_fileds_contacts = $this->model_extension_module_amocrm->contacts_custom_fields();
		$data['amo_fileds_contacts'] = [];
		if(isset($amo_fileds_contacts['_embedded']['custom_fields'])){

			foreach ($amo_fileds_contacts['_embedded']['custom_fields'] as $key => $value) {
				if($value['type'] == "text"){
					$data['amo_fileds_contacts'][] = [
						'id'=>$value['id'],	
						'name'=>$value['name']
					];
				}
			}
			
		}

		$amo_fileds_users = $this->model_extension_module_amocrm->getUsers();
		$data['amo_users'] = [];
		if(isset($amo_fileds_users['_embedded']['users'])){
			foreach ($amo_fileds_users['_embedded']['users'] as $key => $value) {
				$data['amo_users'][] = [
					'id'=>$value['id'],	
					'name'=>$value['name']
				];
			}
		}


		$data['amo_fileds_contacts'] = array_reverse($data['amo_fileds_contacts']);
		$url = new Url(HTTP_CATALOG, $this->config->get('config_secure') ? HTTP_CATALOG : HTTPS_CATALOG);
		$data['secrets_url'] = $url->link('extension/module/amocrm/webhook');
		$data['redirect_url'] = $url->link('extension/module/amocrm');
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('extension/module/amocrm_settings', $data));
	}


	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/amocrm')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}
		return !$this->error;
	}
}