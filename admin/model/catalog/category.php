<?php
class ModelCatalogCategory extends Model {

	public function applyTemplateProduct($category_id, $language_id, $category_template, $cities)
	{
		try {
			if (
				isset($category_template['title_product_apply'])
			) {
				$sql = "UPDATE " . DB_PREFIX . "product_description LEFT JOIN " . DB_PREFIX . "product_to_category ON " . DB_PREFIX . "product_description.product_id=" . DB_PREFIX . "product_to_category.product_id SET meta_title = '" . $this->db->escape($category_template['title_product']) . "' WHERE " . DB_PREFIX . "product_to_category.category_id = '" . (int)$category_id . "' AND language_id='" . (int)$language_id . "'";
				$this->db->query($sql, ['multi' => true]);
			}
			if (
				isset($category_template['description_product_apply'])
			) {
				$sql = "UPDATE " . DB_PREFIX . "product_description LEFT JOIN " . DB_PREFIX . "product_to_category ON " . DB_PREFIX . "product_description.product_id=" . DB_PREFIX . "product_to_category.product_id SET meta_description = '" . $this->db->escape($category_template['description_product']) . "' WHERE " . DB_PREFIX . "product_to_category.category_id = '" . (int)$category_id . "' AND language_id='" . (int)$language_id . "'";
				$this->db->query($sql, ['multi' => true]);
			}
		} catch (\Throwable $e) {
			var_dump($e->getMessage());
			die;
		}
	}

	public function applyTemplate($category_id, $language_id, $category_template, $cities, $child = false)
	{
		try {
			$query = $this->db->query("SELECT meta_h1 FROM " . DB_PREFIX . "category_description WHERE language_id = '" . (int)$language_id . "' AND category_id = '" . (int)$category_id . "' AND city_id = '510'");
			$query->num_rows || $query = $this->db->query("SELECT meta_h1 FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "' LIMIT 1");
			$sqls = [];
			if ($query->num_rows) {
				$meta_h1 = $this->db->escape($query->row['meta_h1']);
				foreach ($cities as $city) {
					$title_category = $this->db->escape(str_replace(["{H1}", "{городе}"], [$meta_h1, $city['address_city2']], $category_template['title_category']));
					$description_category = $this->db->escape(str_replace(["{H1}", "{городе}"], [$meta_h1, $city['address_city2']], $category_template['description_category']));
					$exec = false;
					$sql =  "INSERT INTO " . DB_PREFIX . "category_description (
					category_id, 
					city_id, 
					language_id, 
					name, 
					meta_h1, 
					meta_title, 
					meta_description
					) VALUES (
						'$category_id', 
						'" . $city['city_id'] . "', 
						'$language_id', 
						'$meta_h1',
						'$meta_h1',
						'$title_category', 
						'$description_category'
					)
					ON DUPLICATE KEY UPDATE";

					if ($child) {
						if (
							isset($category_template['title_subcategories_apply'])
						) {
							$sql .= " meta_title='$title_category' ";
							$exec = true;
						}
						if (
							isset($category_template['description_subcategories_apply'])
						) {
							$exec && $sql .= " ,";
							$sql .= " meta_description='$description_category' ";
						}
					} else {
						if (
							isset($category_template['title_category_apply'])
						) {
							$sql .= " meta_title='$title_category' ";
							$exec = true;
						}
						if (
							isset($category_template['description_category_apply'])
						) {
							$exec && $sql .= " ,";
							$sql .= " meta_description='$description_category' ";
						}
					}
					$exec && ($sqls[] = $sql . ';');
					if (count($sqls) > 50) {
						$this->db->query(implode(PHP_EOL, $sqls), ['multi' => true]);
						$sqls = [];
					}
				}
				if (count($sqls)) $this->db->query(implode(PHP_EOL, $sqls), ['multi' => true]);
			}
		} catch (\Throwable $e) {
			var_dump($e->getMessage());
			die;
		}
	}

	public function applyRecursiveTemplate($category_id, $language_id, $category_template, $cities = [], $child = false)
	{
		if (empty($cities)) {
			$this->load->model('extension/module/citychooser/city');
			$cities = $this->model_extension_module_citychooser_city->getCities(['limit' => 500]);
		}
		if ($category_id == 59) return true;
		$this->applyTemplate($category_id, $language_id, $category_template, $cities, $child);
		if (
			isset($category_template['title_product_apply'])
			|| isset($category_template['description_product_apply'])
		) {
			try {
				$this->applyTemplateProduct($category_id, $language_id, $category_template, $cities);
			} catch (\Throwable $e) {
				var_dump($e->getMessage());
				die;
			}
		}
		if (
			isset($category_template['title_subcategories_apply'])
			|| isset($category_template['description_subcategories_apply'])
			|| isset($category_template['title_product_apply'])
			|| isset($category_template['description_product_apply'])

		) {

			$query = $this->db->query("SELECT category_id from " . DB_PREFIX . "category where parent_id=" . (int)$category_id);
			if ($query->num_rows)
				foreach ($query->rows as $row) {
					$this->applyRecursiveTemplate($row['category_id'], $language_id, $category_template, $cities, true);
				}
		}
	}
	
	public function addCategory($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "category SET parent_id = '" . (int)$data['parent_id'] . "', `top` = '" . (isset($data['top']) ? (int)$data['top'] : 0) . "', `column` = '" . (int)$data['column'] . "', sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW(), date_added = NOW()");

		$category_id = $this->db->getLastId();

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "category SET image = '" . $this->db->escape($data['image']) . "' WHERE category_id = '" . (int)$category_id . "'");
		}

		if (isset($data['sizes'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "category SET sizes = '" . $this->db->escape($data['sizes']) . "' WHERE category_id = '" . (int)$category_id . "'");
		}

		foreach ($data['category_description'] as $language_id => $language) {
			foreach ($language as $city_id => $value) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_description SET category_id = '" . (int)$category_id . "', city_id = '" . (int)$city_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', menu_name = '" . $this->db->escape($value['menu_name']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
			}
		}

		// MySQL Hierarchical Data Closure Table Pattern
		$level = 0;

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$data['parent_id'] . "' ORDER BY `level` ASC");

		foreach ($query->rows as $result) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET `category_id` = '" . (int)$category_id . "', `path_id` = '" . (int)$result['path_id'] . "', `level` = '" . (int)$level . "'");

			$level++;
		}

		$this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET `category_id` = '" . (int)$category_id . "', `path_id` = '" . (int)$category_id . "', `level` = '" . (int)$level . "'");

		if (isset($data['category_filter'])) {
			foreach ($data['category_filter'] as $filter_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_filter SET category_id = '" . (int)$category_id . "', filter_id = '" . (int)$filter_id . "'");
			}
		}

		if (isset($data['category_store'])) {
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_store SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		// Set which layout to use with this category
		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_layout SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		if (isset($data['keyword'])) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'category_id=" . (int)$category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}

		$this->load->model('catalog/product');
		$this->model_catalog_product->updateMarkupProducts();

		if (isset($data['category_template'])) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "category_template SET category_id = '" . (int)$category_id . "', title_category = '" . $data['category_template']['title_category'] . "', description_category	 = '" . $data['category_template']['description_category'] . "', title_product	 = '" . $data['category_template']['title_product'] . "', 	description_product	 = '" . $data['category_template']['description_product'] . "'");
			$this->applyRecursiveTemplate((int)$category_id, $language_id, $data['category_template']);
		}

		$this->cache->delete('product');
		$this->cache->delete('category');
        if ($this->config->get('config_flush_cache_seopro')) {
            $this->cache->delete('seo_pro');
        }

		return $category_id;
	}

	public function editCategory($category_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "category SET parent_id = '" . (int)$data['parent_id'] . "', `top` = '" . (isset($data['top']) ? (int)$data['top'] : 0) . "', `column` = '" . (int)$data['column'] . "', sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW() WHERE category_id = '" . (int)$category_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "category SET image = '" . $this->db->escape($data['image']) . "' WHERE category_id = '" . (int)$category_id . "'");
		}

		if (isset($data['sizes'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "category SET sizes = '" . $this->db->escape($data['sizes']) . "' WHERE category_id = '" . (int)$category_id . "'");
		}


		foreach ($data['category_description'] as $language_id => $language) {
			foreach ($language as $c_id => $value) {
				$this->db->query("DELETE FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "' AND city_id = '" . (int)$c_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_description SET category_id = '" . (int)$category_id . "', city_id = '" . (int)$c_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', menu_name = '" . $this->db->escape($value['menu_name']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
			}
		}

		// MySQL Hierarchical Data Closure Table Pattern
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE path_id = '" . (int)$category_id . "' ORDER BY level ASC");

		if ($query->rows) {
			foreach ($query->rows as $category_path) {
				// Delete the path below the current one
				$this->db->query("DELETE FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$category_path['category_id'] . "' AND level < '" . (int)$category_path['level'] . "'");

				$path = array();

				// Get the nodes new parents
				$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$data['parent_id'] . "' ORDER BY level ASC");

				foreach ($query->rows as $result) {
					$path[] = $result['path_id'];
				}

				// Get whats left of the nodes current path
				$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$category_path['category_id'] . "' ORDER BY level ASC");

				foreach ($query->rows as $result) {
					$path[] = $result['path_id'];
				}

				// Combine the paths with a new level
				$level = 0;

				foreach ($path as $path_id) {
					$this->db->query("REPLACE INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int)$category_path['category_id'] . "', `path_id` = '" . (int)$path_id . "', level = '" . (int)$level . "'");

					$level++;
				}
			}
		} else {
			// Delete the path below the current one
			$this->db->query("DELETE FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$category_id . "'");

			// Fix for records with no paths
			$level = 0;

			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$data['parent_id'] . "' ORDER BY level ASC");

			foreach ($query->rows as $result) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int)$category_id . "', `path_id` = '" . (int)$result['path_id'] . "', level = '" . (int)$level . "'");

				$level++;
			}

			$this->db->query("REPLACE INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int)$category_id . "', `path_id` = '" . (int)$category_id . "', level = '" . (int)$level . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int)$category_id . "'");

		if (isset($data['category_filter'])) {
			foreach ($data['category_filter'] as $filter_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_filter SET category_id = '" . (int)$category_id . "', filter_id = '" . (int)$filter_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int)$category_id . "'");

		if (isset($data['category_store'])) {
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_store SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "'");

		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_layout SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "category_template WHERE category_id = '" . (int)$category_id . "'");

		if (isset($data['sort_type'])) {
            $this->db->query("UPDATE " . DB_PREFIX . "category SET sort_type='" . $data['sort_type'] . "' WHERE category_id = '" . (int)$category_id . "'");
        }

		$this->db->query("DELETE FROM " . DB_PREFIX . "category_template WHERE category_id = '" . (int)$category_id . "'");
		
		if (isset($data['category_template'])) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "category_template SET category_id = '" . (int)$category_id . "', title_category = '" . $data['category_template']['title_category'] . "', description_category	 = '" . $data['category_template']['description_category'] . "', title_product	 = '" . $data['category_template']['title_product'] . "', 	description_product	 = '" . $data['category_template']['description_product'] . "'");

			try {
				$this->applyRecursiveTemplate((int)$category_id, $language_id, $data['category_template']);
			} catch (\Throwable $e) {
				var_dump($e->getMessage());
				die;
			}
		}
		
		$this->load->model('catalog/product');
		$this->model_catalog_product->updateMarkupProducts();

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int)$category_id . "'");

		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'category_id=" . (int)$category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}

		$this->cache->delete('product');
		$this->cache->delete('category');
        if ($this->config->get('config_flush_cache_seopro')) {
            $this->cache->delete('seo_pro');
        }
	}

	public function deleteCategory($category_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_path WHERE category_id = '" . (int)$category_id . "'");

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_path WHERE path_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$this->deleteCategory($result['category_id']);
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "category WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "coupon_category WHERE category_id = '" . (int)$category_id . "'");

		$this->load->model('catalog/product');
		$this->model_catalog_product->updateMarkupProducts();

		$this->cache->delete('product');
		$this->cache->delete('category');
        if ($this->config->get('config_flush_cache_seopro')) {
            $this->cache->delete('seo_pro');
        }
	}

	public function repairCategories($parent_id = 0) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category WHERE parent_id = '" . (int)$parent_id . "'");

		foreach ($query->rows as $category) {
			// Delete the path below the current one
			$this->db->query("DELETE FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$category['category_id'] . "'");

			// Fix for records with no paths
			$level = 0;

			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$parent_id . "' ORDER BY level ASC");

			foreach ($query->rows as $result) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int)$category['category_id'] . "', `path_id` = '" . (int)$result['path_id'] . "', level = '" . (int)$level . "'");

				$level++;
			}

			$this->db->query("REPLACE INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int)$category['category_id'] . "', `path_id` = '" . (int)$category['category_id'] . "', level = '" . (int)$level . "'");

			$this->repairCategories($category['category_id']);
		}
	}

	public function getCategory($category_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT GROUP_CONCAT(cd1.name ORDER BY level SEPARATOR '&nbsp;&nbsp;&gt;&nbsp;&nbsp;') FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (cp.path_id = cd1.category_id AND cp.category_id != cp.path_id) WHERE cp.category_id = c.category_id AND cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd1.city_id = '" . 510 . "' GROUP BY cp.category_id) AS path, (SELECT DISTINCT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int)$category_id . "') AS keyword FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (c.category_id = cd2.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		return $query->row;
	}

	public function getCategoryTemplate($category_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_template WHERE category_id = '" . (int)$category_id . "'");
		return $query->row;
	}

	public function getCategoriesByParentId($parent_id = 0) {
		$query = $this->db->query("SELECT *, (SELECT COUNT(parent_id) FROM " . DB_PREFIX . "category WHERE parent_id = c.category_id) AS children FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd.city_id = '" . 510 . "'  ORDER BY c.sort_order, cd.name");
		return $query->rows;
	}

	public function getCategories($data = array()) {
		$sql = "SELECT cp.category_id AS category_id, GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR '&nbsp;&nbsp;&gt;&nbsp;&nbsp;') AS name, c1.parent_id, c1.sort_order, c1.status,(select count(product_id) as product_count from " . DB_PREFIX . "product_to_category pc where pc.category_id = c1.category_id) as product_count FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category c1 ON (cp.category_id = c1.category_id) LEFT JOIN " . DB_PREFIX . "category c2 ON (cp.path_id = c2.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (cp.path_id = cd1.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (cp.category_id = cd2.category_id) WHERE cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd1.city_id = '" . 510 . "'  AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd2.city_id = '" . 510 . "' ";

		if (!empty($data['filter_name'])) {
			$sql .= " AND cd2.name LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sql .= " GROUP BY cp.category_id";

		$sort_data = array(
			'product_count',
			'name',
			'sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY sort_order";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getCategoryDescriptions($category_id, $city_id = 510) {
		$category_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "' AND city_id = '" . (int)$city_id . "'");

		foreach ($query->rows as $result) {
			$category_description_data[$result['language_id']][$result['city_id']] = array(
				'name'             => $result['name'],
				'menu_name'        => $result['menu_name'],
				'meta_title'       => $result['meta_title'],
				'meta_h1'          => $result['meta_h1'],
				'meta_description' => $result['meta_description'],
				'meta_keyword'     => $result['meta_keyword'],
				'description'      => $result['description']
			);
		}

		return $category_description_data;
	}
	
	public function getCategoryPath($category_id) {
		$query = $this->db->query("SELECT category_id, path_id, level FROM " . DB_PREFIX . "category_path WHERE category_id = '" . (int)$category_id . "'");

		return $query->rows;
	}
	
	public function getCategoryFilters($category_id) {
		$category_filter_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$category_filter_data[] = $result['filter_id'];
		}

		return $category_filter_data;
	}

	public function getCategoryStores($category_id) {
		$category_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$category_store_data[] = $result['store_id'];
		}

		return $category_store_data;
	}

	public function getCategoryLayouts($category_id) {
		$category_layout_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$category_layout_data[$result['store_id']] = $result['layout_id'];
		}

		return $category_layout_data;
	}

	public function getTotalCategories() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category");

		return $query->row['total'];
	}

	public function getAllCategories() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd.city_id = '" . 510 . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  ORDER BY c.parent_id, c.sort_order, cd.name");

		$category_data = array();
		foreach ($query->rows as $row) {
			$category_data[$row['parent_id']][$row['category_id']] = $row;
		}

		return $category_data;
	}
	
	public function getTotalCategoriesByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
}
