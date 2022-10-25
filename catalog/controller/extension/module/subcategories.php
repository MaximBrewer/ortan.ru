<?php
class ControllerExtensionModuleSubcategories extends Controller
{
	public function index()
	{

		$this->load->language('extension/module/subcategories');

		$data['heading_title'] = $this->language->get('heading_title');

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		if (!empty($parts) && $category_id = $parts[count($parts) - 1]) {

			$this->load->model('catalog/category');

			$this->load->model('catalog/product');

			$data['categories'] = array();

			$categories = $this->model_catalog_category->getCategories($category_id);

			foreach ($categories as $category) {
                if ($category['image']) {
                    $thumb = $this->model_tool_image->resize($category['image'], 40, 40);
                } else {
                    $thumb = '/image/no-photo.svg';
                }

				$data['categories'][] = array(
					'category_id' => $category['category_id'],
					'name'        => $category['name'],
					'href'        => $this->url->link('product/category', 'path=' . $category['category_id']),
                    'thumb'       => $thumb
				);
			}

			return $this->load->view('extension/module/subcategories', $data);
		} else {
			return '';
		}
	}
}
