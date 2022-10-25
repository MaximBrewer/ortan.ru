<?php
class ControllerExtensionModuleCityChooser extends Controller
{
	private $error = array();


	public function index()
	{
		$this->load->language('extension/module/citychooser');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/citychooser/city');

		$this->getList();
	}



	public function add()
	{
		$this->load->language('extension/module/citychooser');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/citychooser/city');

		// 	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
		// 		$this->model_extension_module_citychooser_city->addProduct($this->request->post);

		// 		$this->session->data['success'] = $this->language->get('text_success');

		// 		$url = '';

		// 		if (isset($this->request->get['filter_city'])) {
		// 			$url .= '&filter_city=' . urlencode(html_entity_decode($this->request->get['filter_city'], ENT_QUOTES, 'UTF-8'));
		// 		}

		// 		if (isset($this->request->get['filter_model'])) {
		// 			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
		// 		}

		// 		if (isset($this->request->get['filter_price'])) {
		// 			$url .= '&filter_price=' . $this->request->get['filter_price'];
		// 		}

		// 		if (isset($this->request->get['filter_quantity'])) {
		// 			$url .= '&filter_quantity=' . $this->request->get['filter_quantity'];
		// 		}

		//   if (isset($this->request->get['filter_category'])) {
		//     $url .= '&filter_category=' . $this->request->get['filter_category'];
		//   }

		// 		if (isset($this->request->get['filter_status'])) {
		// 			$url .= '&filter_status=' . $this->request->get['filter_status'];
		// 		}

		// 		if (isset($this->request->get['sort'])) {
		// 			$url .= '&sort=' . $this->request->get['sort'];
		// 		}

		// 		if (isset($this->request->get['order'])) {
		// 			$url .= '&order=' . $this->request->get['order'];
		// 		}

		// 		if (isset($this->request->get['page'])) {
		// 			$url .= '&page=' . $this->request->get['page'];
		// 		}

		// 		$this->response->redirect($this->url->link('extension/module/citychooser', 'token=' . $this->session->data['token'] . $url, true));
		// 	}

		$this->getForm();
	}

	public function edit()
	{
		$this->load->language('extension/module/citychooser');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/citychooser/city');

			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
				
				$this->model_extension_module_citychooser_city->editCity($this->request->get['city_id'], $this->request->post);

				$this->session->data['success'] = $this->language->get('text_success');

				$url = '';

				if (isset($this->request->get['filter_city'])) {
					$url .= '&filter_city=' . urlencode(html_entity_decode($this->request->get['filter_city'], ENT_QUOTES, 'UTF-8'));
				}

				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}

				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}

				if (isset($this->request->get['page'])) {
					$url .= '&page=' . $this->request->get['page'];
				}

				$this->response->redirect($this->url->link('extension/module/citychooser', 'token=' . $this->session->data['token'] . $url, true));
			}

		$this->getForm();
	}

	public function delete()
	{
		$this->load->language('extension/module/citychooser');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/citychooser');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $city_id) {
				$this->model_extension_module_citychooser_city->deleteProduct($city_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_city'])) {
				$url .= '&filter_city=' . urlencode(html_entity_decode($this->request->get['filter_city'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_model'])) {
				$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_price'])) {
				$url .= '&filter_price=' . $this->request->get['filter_price'];
			}

			if (isset($this->request->get['filter_quantity'])) {
				$url .= '&filter_quantity=' . $this->request->get['filter_quantity'];
			}

			if (isset($this->request->get['filter_category'])) {
				$url .= '&filter_category=' . $this->request->get['filter_category'];
			}

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('extension/module/citychooser', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}

	protected function getList()
	{
		if (isset($this->request->get['filter_city'])) {
			$filter_city = $this->request->get['filter_city'];
		} else {
			$filter_city = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'pd.name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_city'])) {
			$url .= '&filter_city=' . urlencode(html_entity_decode($this->request->get['filter_city'], ENT_QUOTES, 'UTF-8'));
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => 'Дополнения',
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/citychooser', 'token=' . $this->session->data['token'], true)
		);


		$data['add'] = $this->url->link('extension/module/citychooser/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('extension/module/citychooser/delete', 'token=' . $this->session->data['token'] . $url, true);

		$data['cities'] = array();

		$filter_data = array(
			'filter_city'	  => $filter_city,
			'sort'            => $sort,
			'order'           => $order,
			'start'           => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'           => $this->config->get('config_limit_admin')
		);

		$city_total = $this->model_extension_module_citychooser_city->getTotalCities($filter_data);

		$results = $this->model_extension_module_citychooser_city->getCities($filter_data);

		foreach ($results as $result) {
			$data['cities'][] = array(
				'city_id' => $result['city_id'],
				'city'       => $result['city'],
				'full'       => $result['full'],
				'edit'       => $this->url->link('extension/module/citychooser/edit', 'token=' . $this->session->data['token'] . '&city_id=' . $result['city_id'] . $url, true)
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if (isset($this->request->get['filter_city'])) {
			$url .= '&filter_city=' . urlencode(html_entity_decode($this->request->get['filter_city'], ENT_QUOTES, 'UTF-8'));
		}

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_name'] = $this->url->link('extension/module/citychooser', 'token=' . $this->session->data['token'] . '&sort=pd.name' . $url, true);
		$data['sort_order'] = $this->url->link('extension/module/citychooser', 'token=' . $this->session->data['token'] . '&sort=p.sort_order' . $url, true);

		$url = '';

		if (isset($this->request->get['filter_city'])) {
			$url .= '&filter_city=' . urlencode(html_entity_decode($this->request->get['filter_city'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $city_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('extension/module/citychooser', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($city_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($city_total - $this->config->get('config_limit_admin'))) ? $city_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $city_total, ceil($city_total / $this->config->get('config_limit_admin')));

		$data['filter_city'] = $filter_city;

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');


		$this->response->setOutput($this->load->view('extension/module/citychooser/city_list', $data));
	}


	protected function validateForm() {

		// if (!$this->user->hasPermission('modify', 'extension/module/citychooser')) {
		// 	$this->error['warning'] = $this->language->get('error_permission');
		// }

		// foreach ($this->request->post['city_description'] as $language_id => $value) {
		// 	if ((utf8_strlen($value['city']) < 3) || (utf8_strlen($value['city']) > 255)) {
		// 		$this->error['city'][$language_id] = $this->language->get('error_city');
		// 	}
		// }

		// var_dump($this->error);
		// die;
		// if ((utf8_strlen($this->request->post['model']) < 1) || (utf8_strlen($this->request->post['model']) > 64)) {
		// 	$this->error['model'] = $this->language->get('error_model');
		// }

		// if (utf8_strlen($this->request->post['keyword']) > 0) {
		// 	$this->load->model('catalog/url_alias');

		// 	$url_alias_info = $this->model_catalog_url_alias->getUrlAlias($this->request->post['keyword']);

		// 	if ($url_alias_info && isset($this->request->get['city_id']) && $url_alias_info['query'] != 'city_id=' . $this->request->get['city_id']) {
		// 		$this->error['keyword'] = sprintf($this->language->get('error_keyword'));
		// 	}

		// 	if ($url_alias_info && !isset($this->request->get['city_id'])) {
		// 		$this->error['keyword'] = sprintf($this->language->get('error_keyword'));
		// 	}
		// }

		// if ($this->error && !isset($this->error['warning'])) {
		// 	$this->error['warning'] = $this->language->get('error_warning');
		// }

		return !$this->error;
	}


	public function autocomplete()
	{
		$json = array();

		if (isset($this->request->get['filter_city'])) {
			$this->load->model('extension/module/citychooser/city');

			if (isset($this->request->get['filter_city'])) {
				$filter_city = $this->request->get['filter_city'];
			} else {
				$filter_city = '';
			}

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = $this->config->get('config_limit_autocomplete');
			}

			$filter_data = array(
				'filter_city'  => $filter_city,
				'start'        => 0,
				'limit'        => $limit
			);

			$results = $this->model_extension_module_citychooser_city->getCities($filter_data);

			foreach ($results as $result) {

				$json[] = array(
					'city_id' => $result['city_id'],
					'city'       => strip_tags(html_entity_decode($result['city'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function install()
	{
		$this->load->model('extension/module/citychooser/city');
		$this->model_extension_module_citychooser_city->install();
	}

	public function uninstall()
	{
		$this->load->model('extension/module/citychooser/city');
		$this->model_extension_module_citychooser_city->uninstall();
	}


	protected function getForm()
	{
		//CKEditor
		if ($this->config->get('config_editor_default')) {
			$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
		} else {
			$this->document->addScript('view/javascript/summernote/summernote.js');
			$this->document->addScript('view/javascript/summernote/lang/summernote-' . $this->language->get('lang') . '.js');
			$this->document->addScript('view/javascript/summernote/opencart.js');
			$this->document->addStyle('view/javascript/summernote/summernote.css');
		}

		$data['heading_title'] = $this->language->get('heading_title');




		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		if (isset($this->error['sort'])) {
			$data['error_sort'] = $this->error['sort'];
		} else {
			$data['error_sort'] = array();
		}
		if (isset($this->error['phone'])) {
			$data['error_phone'] = $this->error['phone'];
		} else {
			$data['error_phone'] = array();
		}

		if (isset($this->error['add_phone'])) {
			$data['error_add_phone'] = $this->error['add_phone'];
		} else {
			$data['error_add_phone'] = array();
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = array();
		}

		if (isset($this->error['add_email'])) {
			$data['error_add_email'] = $this->error['add_email'];
		} else {
			$data['error_add_email'] = array();
		}


		if (isset($this->error['whatsapp'])) {
			$data['error_whatsapp'] = $this->error['whatsapp'];
		} else {
			$data['error_whatsapp'] = array();
		}


		if (isset($this->error['telegram'])) {
			$data['error_telegram'] = $this->error['telegram'];
		} else {
			$data['error_telegram'] = array();
		}


		if (isset($this->error['viber'])) {
			$data['error_viber'] = $this->error['viber'];
		} else {
			$data['error_viber'] = array();
		}


		if (isset($this->error['geo_lat'])) {
			$data['error_geo_lat'] = $this->error['geo_lat'];
		} else {
			$data['error_geo_lat'] = array();
		}


		if (isset($this->error['geo_lon'])) {
			$data['error_geo_lon'] = $this->error['geo_lon'];
		} else {
			$data['error_geo_lon'] = array();
		}


		if (isset($this->error['show_map'])) {
			$data['error_show_map'] = $this->error['show_map'];
		} else {
			$data['error_show_map'] = array();
		}


		if (isset($this->error['main'])) {
			$data['error_main'] = $this->error['main'];
		} else {
			$data['error_main'] = array();
		}

		$url = '';

		if (isset($this->request->get['filter_city'])) {
			$url .= '&filter_city=' . urlencode(html_entity_decode($this->request->get['filter_city'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}


		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => 'Дополнения',
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/citychooser', 'token=' . $this->session->data['token'], true)
		);

		if (!isset($this->request->get['city_id'])) {
			$data['action'] = $this->url->link('extension/module/citychooser/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('extension/module/citychooser/edit', 'token=' . $this->session->data['token'] . '&city_id=' . $this->request->get['city_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('extension/module/citychooser', 'token=' . $this->session->data['token'] . $url, true);

		if (isset($this->request->get['city_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$city_info = $this->model_extension_module_citychooser_city->getCity($this->request->get['city_id']);
		}

		$data['token'] = $this->session->data['token'];
		$data['ckeditor'] = $this->config->get('config_editor_default');

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data['lang'] = $this->language->get('lang');

		if (isset($this->request->post['sort'])) {
			$data['sort'] = $this->request->post['sort'];
		} elseif (!empty($city_info)) {
			$data['sort'] = $city_info['sort'];
		} else {
			$data['sort'] = '';
		}

		if (isset($this->request->post['phone'])) {
			$data['phone'] = $this->request->post['phone'];
		} elseif (!empty($city_info)) {
			$data['phone'] = $city_info['phone'];
		} else {
			$data['phone'] = '';
		}

		if (isset($this->request->post['add_phone'])) {
			$data['add_phone'] = $this->request->post['add_phone'];
		} elseif (!empty($city_info)) {
			$data['add_phone'] = $city_info['add_phone'];
		} else {
			$data['add_phone'] = '';
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} elseif (!empty($city_info)) {
			$data['email'] = $city_info['email'];
		} else {
			$data['email'] = '';
		}


		if (isset($this->request->post['add_email'])) {
			$data['add_email'] = $this->request->post['add_email'];
		} elseif (!empty($city_info)) {
			$data['add_email'] = $city_info['add_email'];
		} else {
			$data['add_email'] = '';
		}


		if (isset($this->request->post['whatsapp'])) {
			$data['whatsapp'] = $this->request->post['whatsapp'];
		} elseif (!empty($city_info)) {
			$data['whatsapp'] = $city_info['whatsapp'];
		} else {
			$data['whatsapp'] = '';
		}


		if (isset($this->request->post['telegram'])) {
			$data['telegram'] = $this->request->post['telegram'];
		} elseif (!empty($city_info)) {
			$data['telegram'] = $city_info['telegram'];
		} else {
			$data['telegram'] = '';
		}


		if (isset($this->request->post['viber'])) {
			$data['viber'] = $this->request->post['viber'];
		} elseif (!empty($city_info)) {
			$data['viber'] = $city_info['viber'];
		} else {
			$data['viber'] = '';
		}


		if (isset($this->request->post['geo_lat'])) {
			$data['geo_lat'] = $this->request->post['geo_lat'];
		} elseif (!empty($city_info)) {
			$data['geo_lat'] = $city_info['geo_lat'];
		} else {
			$data['geo_lat'] = '';
		}


		if (isset($this->request->post['geo_lon'])) {
			$data['geo_lon'] = $this->request->post['geo_lon'];
		} elseif (!empty($city_info)) {
			$data['geo_lon'] = $city_info['geo_lon'];
		} else {
			$data['geo_lon'] = '';
		}


		if (isset($this->request->post['show_map'])) {
			$data['show_map'] = $this->request->post['show_map'];
		} elseif (!empty($city_info)) {
			$data['show_map'] = $city_info['show_map'];
		} else {
			$data['show_map'] = 0;
		}

		if (isset($this->request->post['main'])) {
			$data['main'] = $this->request->post['main'];
		} elseif (!empty($city_info)) {
			$data['main'] = $city_info['main'];
		} else {
			$data['main'] = 0;
		}

		

		if (isset($this->request->post['city_description'])) {
			$data['city_description'] = $this->request->post['city_description'];
		} elseif (isset($this->request->get['city_id'])) {
			$data['city_description'] = $this->model_extension_module_citychooser_city->getCityDescriptions($this->request->get['city_id']);
		} else {
			$data['city_description'] = array();
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/citychooser/city_form', $data));
	}
}
