<?php
class ControllerCommonSitemap extends Controller
{
	public function index()
	{
		$data = [];

		@mkdir(DIR_ROOT_PATH . '/sitemaps/xml', 0755, true);
		@mkdir(DIR_ROOT_PATH . '/sitemaps/html', 0755, true);

		$this->load->language('information/sitemap');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('information/sitemap')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_password'] = $this->language->get('text_password');
		$data['text_address'] = $this->language->get('text_address');
		$data['text_history'] = $this->language->get('text_history');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_cart'] = $this->language->get('text_cart');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_search'] = $this->language->get('text_search');
		$data['text_information'] = $this->language->get('text_information');
		$data['text_contact'] = $this->language->get('text_contact');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');


		$page = !!$this->request->get['sitemap'] ? $this->request->get['sitemap'] : 0;
		$xml = simplexml_load_file(DIR_ROOT_PATH . '/sitemap.xml');
		$data['sitemaps'] = [];
		foreach ($xml->sitemap as $key => $sitemap) {
			if (abs($page - $key) < 6 || $page < 6 || $page > count($xml->sitemap) - 6)
				$data['sitemaps'][] = ['href' => (string)$sitemap->loc, 'current' => $page == $key];
		}
		$xml = simplexml_load_file(DIR_ROOT_PATH . '/sitemaps/html/sitemap_' . str_pad($page, 3, "0", STR_PAD_LEFT) . '.xml');
		$data['map'] = [];
		foreach ($xml->url as $url) {
			$data['map'][] = ['href' => (string)$url->loc, 'title' => (string)$url->title];
		}
		$this->response->setOutput($this->load->view('common/sitemap', $data));
	}
	public function create()
	{

		@mkdir(DIR_ROOT_PATH . '/sitemaps/xml', 0755, true);
		@mkdir(DIR_ROOT_PATH . '/sitemaps/html', 0755, true);

		echo 'start' . PHP_EOL;
		try {
			define('CITY_CODE', 'msk');
			define('CITY_ID', 510);

			$this->load->model('catalog/product');
			$this->load->model('tool/image');
			$this->load->model('extension/module/citychooser/city');
			$this->load->model('catalog/category');
			$this->load->model('catalog/information');
			$this->load->model('catalog/ocfilter');


			$outputMain  = '<?xml version="1.0" encoding="UTF-8"?>';
			$outputMain .= '<sitemapindex xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9">';

			$data['cities'] = $this->model_extension_module_citychooser_city->getCities();
			$outNum = 0;

			echo 'cities' . PHP_EOL;
			foreach ($data['cities'] as $city) {
				echo $city['code'] . PHP_EOL;
				$output  = '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">';
				$outputHtml  = '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">';
				$city_code = $city['code'] == 'msk' ? '' : $city['code'] . '/';
				$limit = 500;
				$offset = 0;
                do {
                    $products = $this->model_catalog_product->getProductsForSitemap($offset, $limit);
                    if (!empty($products)) {
                        foreach ($products as $product) {
                            $link = $this->url->link('product/product', 'product_id=' . $product['product_id']);
                            $link = str_replace(HTTPS_SERVER, HTTPS_SERVER . $city_code, $link);
                            if ($product['image']) {
                                $output .= '<url>';
                                $output .= '<loc>' . $link . '</loc>';
                                $output .= '<changefreq>weekly</changefreq>';
                                $output .= '<lastmod>' . date('Y-m-d\TH:i:sP', strtotime($product['date_modified'])) . '</lastmod>';
                                $output .= '<priority>1.0</priority>';
                                $output .= '<image:image>';
                                $output .= '<image:loc>' . $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height')) . '</image:loc>';
                                $output .= '<image:caption>' . $product['name'] . '</image:caption>';
                                $output .= '<image:title>' . $product['name'] . '</image:title>';
                                $output .= '</image:image>';
                                $output .= '</url>';
                                $outputHtml .= '<url>';
                                $outputHtml .= '<loc>' . $link . '</loc>';
                                $outputHtml .= '<title>' . $product['name'] . '</title>';
                                $outputHtml .= '</url>';
                            }
                        }
                        // $output .= '</urlset>';
                        // file_put_contents(DIR_ROOT_PATH . '/sitemap_' . str_pad($outNum, 3, "0", STR_PAD_LEFT) . '.xml', $output);

                        /*
                        $outputMain .= '<sitemap>';
                        $outputMain .= '<loc>' . HTTPS_SERVER . 'sitemap_' . str_pad($outNum, 3, "0", STR_PAD_LEFT) . '.xml</loc>';
                        $outputMain .= '<lastmod>' . date('Y-m-d\TH:i:sP', time()) . '</lastmod>';
                        $outputMain .= '</sitemap>';
                        $output  = '<?xml version="1.0" encoding="UTF-8"?>';
                        $output .= '<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9">';
                        ++$outNum;
                        */
                    }
                    $offset += $limit;
                } while (!empty($products));


				$categories = $this->getCategories(0, $city_code);
				$output .= $categories[0];
				$outputHtml .= $categories[1];

				$ocfilter_pages = $this->model_catalog_ocfilter->getPages();
				foreach ($ocfilter_pages as $page) {
					$link = rtrim($this->url->link('product/category', 'path=' . $page['category_id']), '/');
					if ($page['keyword'])  $link .= '/' . $page['keyword'];
					else  $link .= '/' . $page['params'];
					$link = str_replace(HTTPS_SERVER, HTTPS_SERVER . $city_code, $link);
					$output .= '<url>';
					$output .= '<loc>' . $link . '</loc>';
					$output .= '<changefreq>weekly</changefreq>';
					$output .= '<priority>0.7</priority>';
					$output .= '</url>';
					$outputHtml .= '<url>';
					$outputHtml .= '<loc>' . $link . '</loc>';
					$outputHtml .= '<title>' . $page['title'] . '</title>';
					$outputHtml .= '</url>';
				}

				$informations = $this->model_catalog_information->getInformations();
				foreach ($informations as $information) {
					$link = $this->url->link('information/information', 'information_id=' . $information['information_id']);
					$link = str_replace(HTTPS_SERVER, HTTPS_SERVER . $city_code, $link);
					$output .= '<url>';
					$output .= '<loc>' . $link . '</loc>';
					$output .= '<changefreq>weekly</changefreq>';
					$output .= '<priority>0.5</priority>';
					$output .= '</url>';
					$outputHtml .= '<url>';
					$outputHtml .= '<loc>' . $link . '</loc>';
					$outputHtml .= '<title>' . $information['title'] . '</title>';
					$outputHtml .= '</url>';
				}

				$output .= '<url>';
				$output .= '<loc>' . HTTPS_SERVER . $city_code . 'contact-us/</loc>';
				$output .= '<changefreq>weekly</changefreq>';
				$output .= '<priority>0.5</priority>';
				$output .= '</url>';

				$outputHtml .= '<url>';
				$outputHtml .= '<loc>' . $link . '</loc>';
				$outputHtml .= '<title>Контакты</title>';
				$outputHtml .= '</url>';

				$output .= '</urlset>';
				$outputHtml .= '</urlset>';
				file_put_contents(DIR_ROOT_PATH . '/sitemaps/xml/sitemap_' . str_pad($outNum, 3, "0", STR_PAD_LEFT) . '.xml', $output);
				file_put_contents(DIR_ROOT_PATH . '/sitemaps/html/sitemap_' . str_pad($outNum, 3, "0", STR_PAD_LEFT) . '.xml', $outputHtml);
				$outputMain .= '<sitemap>';
				$outputMain .= '<loc>' . HTTPS_SERVER . 'sitemaps/xml/sitemap_' . str_pad($outNum, 3, "0", STR_PAD_LEFT) . '.xml</loc>';
				$outputMain .= '<lastmod>' . date('Y-m-d\TH:i:sP', time()) . '</lastmod>';
				$outputMain .= '</sitemap>';
				$output  = '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">';
				$outputHtml  = '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">';
				++$outNum;
			}

			// $this->load->model('catalog/manufacturer');

			// $manufacturers = $this->model_catalog_manufacturer->getManufacturers();

			// foreach ($manufacturers as $manufacturer) {
			// 	$output .= '<url>';
			// 	$output .= '<loc>' . $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']) . '</loc>';
			// 	$output .= '<changefreq>weekly</changefreq>';
			// 	$output .= '<priority>0.7</priority>';
			// 	$output .= '</url>';

			// 	if (!$this->config->get('google_sitemap_disable_products')) {
			//         $products = $this->model_catalog_product->getProducts(array('filter_manufacturer_id' => $manufacturer['manufacturer_id']));

			//         foreach ($products as $product) {
			//             $output .= '<url>';
			//             $output .= '<loc>' . $this->url->link('product/product', 'manufacturer_id=' . $manufacturer['manufacturer_id'] . '&product_id=' . $product['product_id']) . '</loc>';
			//             $output .= '<changefreq>weekly</changefreq>';
			//             $output .= '<priority>1.0</priority>';
			//             $output .= '</url>';
			//         }
			// 	}
			// }

			$outputMain .= '</sitemapindex>';

			file_put_contents(DIR_ROOT_PATH . '/sitemap.xml', $outputMain);
		} catch (Exception $e) {
			echo $e->getMessage();
		}
	}
	protected function getCategories($parent_id, $city_code, $current_path = '')
	{
		$output = '';
		$outputHtml = '';

		$results = $this->model_catalog_category->getCategories($parent_id);

		foreach ($results as $result) {
			if (!$current_path) {
				$new_path = $result['category_id'];
			} else {
				$new_path = $current_path . '_' . $result['category_id'];
			}

			$link = $this->url->link('product/category', 'path=' . $new_path);
			$link = str_replace(HTTPS_SERVER, HTTPS_SERVER . $city_code, $link);

            $date_modified = strtotime($result['date_modified']);
            $q = "SELECT MAX(pr.date_modified) date_modified FROM oc_product_to_category ptc  
                    LEFT JOIN `oc_product` pr ON pr.product_id=ptc.product_id
                    WHERE ptc.category_id='" . (int)$result['category_id'] . "' AND pr.status='1'";
            if ($query = $this->db->query($q) and $row = $query->row and !empty($row['date_modified']) and $row['date_modified'] != '') {
                if (strtotime($row['date_modified']) > $date_modified) {
                    $date_modified = strtotime($row['date_modified']);
                }
            }
            if ($date_modified < strtotime('1971-02-02')) {
                $date_modified = strtotime('2021-09-20');
            }
			$output .= '<url>';
			$output .= '<loc>' . $link . '</loc>';
			$output .= '<changefreq>weekly</changefreq>';
			$output .= '<priority>0.7</priority>';
            $output .= '<lastmod>' . date('c', $date_modified) . '</lastmod>';
			$output .= '</url>';
			$outputHtml .= '<url>';
			$outputHtml .= '<loc>' . $link . '</loc>';
			$outputHtml .= '<title>' . $result['title'] . '</title>';
			$outputHtml .= '</url>';

            $categories = $this->getCategories($result['category_id'], $city_code, $new_path);
			$output .= $categories[0];
			$outputHtml .= $categories[1];
		}

		return [$output, $outputHtml];
	}
}
