<?php
class ControllerCommonHome extends Controller {
	public function index() {

        $data['lang_link'] = $this->config->get('lang_pref');

		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));

		if (isset($this->request->get['route'])) {
            if ($this->config->get('config_canonical_method')) {
                if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
                    $server = $this->config->get('config_ssl');
                } else {
                    $server = $this->config->get('config_url');
                };

                $request_url = rtrim($server, '/') . $this->request->server['REQUEST_URI'];
                $canonical_url = $this->config->get('config_url');

                if (($request_url != $canonical_url) || $this->config->get('config_canonical_self')) {
                    $this->document->addLink($this->config->get('config_url'), 'canonical');
                }
            } else {
                $this->document->addLink($this->config->get('config_url'), 'canonical');
            }
		}


		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['products'] = array();

		$filter_data = array(
				'filter_category_id' => 204,
				'sort'               => 'p.sort_order',
				'order'              => "ASC",
				'start'              => 0,
				'limit'              => 6
			);

		$results = $this->model_catalog_product->getProducts($filter_data);


		if ($results) {
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], 300, 300);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', 300, 300);
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}


				if ($result['quantity'] <= 0) {
					$stock = $result['stock_status'];
				} elseif ($this->config->get('config_stock_display')) {
					$stock = $result['quantity'];
				} else {
					$stock = $this->language->get('text_instock');
				}
					$stock = $result['stock_status'];
				$bestseller = false;
				foreach($this->model_catalog_product->getCategories($result['product_id']) as $cat){
					if($cat['category_id'] == (int)CATEGORY_BESTSELLER) $bestseller = true;
				}
                
				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'model'        => $result['model'],
            		'stock_status' => $stock,
            		'novelty' => $result['novelty'],
            		'bestseller' => $bestseller,
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}

		}



		$data['products2'] = array();

		$filter_data2 = array(
				'filter_category_id' => 205,
				'sort'               => "random",
				'order'              => "ASC",
				'start'              => 0,
				'limit'              => 6
			);

		$results2 = $this->model_catalog_product->getProducts($filter_data2);


		if ($results2) {
			foreach ($results2 as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], 300, 300);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', 300, 300);
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}


				if ($result['quantity'] <= 0) {
					$stock = $result['stock_status'];
				} elseif ($this->config->get('config_stock_display')) {
					$stock = $result['quantity'];
				} else {
					$stock = $this->language->get('text_instock');
				}
					$stock = $result['stock_status'];
				$bestseller = false;
				foreach($this->model_catalog_product->getCategories($result['product_id']) as $cat){
					if($cat['category_id'] == (int)CATEGORY_BESTSELLER) $bestseller = true;
				}
                
				$data['products2'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'model'        => $result['model'],
            		'stock_status' => $stock,
            		'novelty' => $result['novelty'],
            		'bestseller' => $bestseller,
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}

		}


		$this->load->model('catalog/ex_reviews_page_my');

		$data['review_total_all'] = $this->model_catalog_ex_reviews_page_my->getTotalReviews($filter_data);
  
		$data['review_total_all'] += 1000;
		$data['review_total_all_text'] = number_format($data['review_total_all'], 0, '.', ' ');
  
		$filter_data['filter_rating'] = "1";
		$data['review_total_1'] = $this->model_catalog_ex_reviews_page_my->getTotalReviews($filter_data);
		$filter_data['filter_rating'] = "2";
		$data['review_total_2'] = $this->model_catalog_ex_reviews_page_my->getTotalReviews($filter_data);
		$filter_data['filter_rating'] = "3";
		$data['review_total_3'] = $this->model_catalog_ex_reviews_page_my->getTotalReviews($filter_data);
		$filter_data['filter_rating'] = "4";
		$data['review_total_4'] = $this->model_catalog_ex_reviews_page_my->getTotalReviews($filter_data);
		$filter_data['filter_rating'] = "5";
		$data['review_total_5'] = $this->model_catalog_ex_reviews_page_my->getTotalReviews($filter_data) + 1000;
  
		$data['rating_percent'] = $this->model_catalog_ex_reviews_page_my->getPercent();

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('common/home', $data));
	}
}
