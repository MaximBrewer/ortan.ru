<?php
class ModelExtensionFeedYandexMarket extends Model {
	public function getCategory() {
		$q = "SELECT cd.name, c.category_id, c.parent_id FROM " . DB_PREFIX . "category c 
		LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) 
		LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) 
		WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' 
			AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  AND c.status = '1' AND c.sort_order <> '-1'";
		$query = $this->db->query($q);

		return $query->rows;
	}

	public function getProduct($allowed_categories, $out_of_stock_id, $vendor_required = true) {
		$q = "SELECT p.*, pd.name, pd.name_ym, pd.description, m.name AS manufacturer, p2c.category_id, ovd.name ovd_name, ovd2.name ovd2_name, covd.name covd2_name, ps.price as discount, p.price as price,
		
		(SELECT GROUP_CONCAT(distinct name ORDER BY ovq.sort_order)
		FROM oc_product_option_value povq
		left join oc_option_value ovq
		ON (povq.option_value_id = ovq.option_value_id AND ovq.option_id ='11') 
		left join oc_option_value_description ovdq
		ON (povq.option_value_id = ovdq.option_value_id AND ovdq.option_id ='11') 
		where povq.product_id=p.product_id and povq.option_id='11') as sizes,
		
		(SELECT GROUP_CONCAT(distinct name ORDER BY covq.sort_order)
		FROM oc_product_option_value cpovq
		left join oc_option_value covq
		ON (cpovq.option_value_id = covq.option_value_id AND covq.option_id ='13') 
		left join oc_option_value_description covdq
		ON (cpovq.option_value_id = covdq.option_value_id AND covdq.option_id ='13') 
		where cpovq.product_id=p.product_id and cpovq.option_id='13') as colors
		
		FROM " . DB_PREFIX . "product p 
			LEFT JOIN " . DB_PREFIX . "product_to_category AS p2c ON (p.product_id = p2c.product_id AND p2c.main_category='1') 
			" . ($vendor_required ? '' : 'LEFT ') ." JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) 
			LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) 
			LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) 
			LEFT JOIN " . DB_PREFIX . "product_option_value cpop ON (p.product_id = cpop.product_id AND cpop.option_id='13') 
			LEFT JOIN " . DB_PREFIX . "option_value_description covd ON (cpop.option_value_id = covd.option_value_id AND covd.option_id ='13') 
			LEFT JOIN " . DB_PREFIX . "product_option_value pop ON (p.product_id = pop.product_id AND pop.option_id='14') 
			LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (pop.option_value_id = ovd.option_value_id AND ovd.option_id ='14') 
			LEFT JOIN " . DB_PREFIX . "product_option_value pop2 ON (p.product_id = pop2.product_id AND pop2.option_id='15') 
			LEFT JOIN " . DB_PREFIX . "option_value_description ovd2 ON (pop2.option_value_id = ovd2.option_value_id AND ovd2.option_id ='15') 
			LEFT JOIN " . DB_PREFIX . "product_special ps ON (p.product_id = ps.product_id) AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ps.date_start < NOW() AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()) 
			WHERE p2c.category_id IN (" . $this->db->escape($allowed_categories) . ") AND p.isyandexmarket='1' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.date_available <= NOW() AND p.status = '1' AND (p.quantity > '0' OR p.stock_status_id != '" . (int)$out_of_stock_id . "') GROUP BY p.product_id";
		$query = $this->db->query($q);

		return $query->rows;
	}

	public function getStockProduct($allowed_categories, $out_of_stock_id, $vendor_required = true) {
		$q = "SELECT p.*, pd.name, pd.name_ym, pd.description, m.name AS manufacturer, p2c.category_id, ovd.name ovd_name, ovd2.name ovd2_name, covd.name covd2_name, ps.price as discount, p.price as price,
		
		(SELECT GROUP_CONCAT(distinct name ORDER BY ovq.sort_order)
		FROM oc_product_option_value povq
		left join oc_option_value ovq
		ON (povq.option_value_id = ovq.option_value_id AND ovq.option_id ='11') 
		left join oc_option_value_description ovdq
		ON (povq.option_value_id = ovdq.option_value_id AND ovdq.option_id ='11') 
		where povq.product_id=p.product_id and povq.option_id='11') as sizes,
		
		(SELECT GROUP_CONCAT(distinct name ORDER BY covq.sort_order)
		FROM oc_product_option_value cpovq
		left join oc_option_value covq
		ON (cpovq.option_value_id = covq.option_value_id AND covq.option_id ='13') 
		left join oc_option_value_description covdq
		ON (cpovq.option_value_id = covdq.option_value_id AND covdq.option_id ='13') 
		where cpovq.product_id=p.product_id and cpovq.option_id='13') as colors
		
		FROM " . DB_PREFIX . "product p 
			LEFT JOIN " . DB_PREFIX . "product_to_category AS p2c ON (p.product_id = p2c.product_id) 
			" . ($vendor_required ? '' : 'LEFT ') ." JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) 
			LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) 
			LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) 
			LEFT JOIN " . DB_PREFIX . "product_option_value cpop ON (p.product_id = cpop.product_id AND cpop.option_id='13') 
			LEFT JOIN " . DB_PREFIX . "option_value_description covd ON (cpop.option_value_id = covd.option_value_id AND covd.option_id ='13') 
			LEFT JOIN " . DB_PREFIX . "product_option_value pop ON (p.product_id = pop.product_id AND pop.option_id='14') 
			LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (pop.option_value_id = ovd.option_value_id AND ovd.option_id ='14') 
			LEFT JOIN " . DB_PREFIX . "product_option_value pop2 ON (p.product_id = pop2.product_id AND pop2.option_id='15') 
			LEFT JOIN " . DB_PREFIX . "option_value_description ovd2 ON (pop2.option_value_id = ovd2.option_value_id AND ovd2.option_id ='15') 
			LEFT JOIN " . DB_PREFIX . "product_special ps ON (p.product_id = ps.product_id) AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ps.date_start < NOW() AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()) 
			WHERE p2c.category_id IN (207) AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.date_available <= NOW() AND p.status = '1' AND (p.quantity > '0' OR p.stock_status_id != '" . (int)$out_of_stock_id . "') GROUP BY p.product_id";
		$query = $this->db->query($q);

		return $query->rows;
	}

	public function getAllProduct($allowed_categories, $out_of_stock_id, $vendor_required = true) {
		$q = "SELECT p.*, pd.name, pd.name_ym, pd.description, m.name AS manufacturer, p2c.category_id, ovd.name ovd_name, ovd2.name ovd2_name, covd.name covd2_name, ps.price as discount, p.price as price,
		
		(SELECT GROUP_CONCAT(distinct name ORDER BY ovq.sort_order)
		FROM oc_product_option_value povq
		left join oc_option_value ovq
		ON (povq.option_value_id = ovq.option_value_id AND ovq.option_id ='11') 
		left join oc_option_value_description ovdq
		ON (povq.option_value_id = ovdq.option_value_id AND ovdq.option_id ='11') 
		where povq.product_id=p.product_id and povq.option_id='11') as sizes,
		
		(SELECT GROUP_CONCAT(distinct name ORDER BY covq.sort_order)
		FROM oc_product_option_value cpovq
		left join oc_option_value covq
		ON (cpovq.option_value_id = covq.option_value_id AND covq.option_id ='13') 
		left join oc_option_value_description covdq
		ON (cpovq.option_value_id = covdq.option_value_id AND covdq.option_id ='13') 
		where cpovq.product_id=p.product_id and cpovq.option_id='13') as colors
		
		FROM " . DB_PREFIX . "product p 
			LEFT JOIN " . DB_PREFIX . "product_to_category AS p2c ON (p.product_id = p2c.product_id AND p2c.main_category='1') 
			" . ($vendor_required ? '' : 'LEFT ') ." JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id) 
			LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) 
			LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) 
			LEFT JOIN " . DB_PREFIX . "product_option_value cpop ON (p.product_id = cpop.product_id AND cpop.option_id='13') 
			LEFT JOIN " . DB_PREFIX . "option_value_description covd ON (cpop.option_value_id = covd.option_value_id AND covd.option_id ='13') 
			LEFT JOIN " . DB_PREFIX . "product_option_value pop ON (p.product_id = pop.product_id AND pop.option_id='14') 
			LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (pop.option_value_id = ovd.option_value_id AND ovd.option_id ='14') 
			LEFT JOIN " . DB_PREFIX . "product_option_value pop2 ON (p.product_id = pop2.product_id AND pop2.option_id='15') 
			LEFT JOIN " . DB_PREFIX . "option_value_description ovd2 ON (pop2.option_value_id = ovd2.option_value_id AND ovd2.option_id ='15') 
			LEFT JOIN " . DB_PREFIX . "product_special ps ON (p.product_id = ps.product_id) AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ps.date_start < NOW() AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()) 
			WHERE p2c.category_id IN (" . $this->db->escape($allowed_categories) . ") AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.date_available <= NOW() AND p.status = '1' AND (p.quantity > '0' OR p.stock_status_id != '" . (int)$out_of_stock_id . "') GROUP BY p.product_id";
		$query = $this->db->query($q);

		return $query->rows;
	}
}
?>