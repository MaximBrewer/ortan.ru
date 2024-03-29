<?php
class ModelLocalisationCurrency extends Model
{
	public function addCurrency($data)
	{
		$this->db->query("INSERT INTO " . DB_PREFIX . "currency SET title = '" . $this->db->escape($data['title']) . "', code = '" . $this->db->escape($data['code']) . "', symbol_left = '" . $this->db->escape($data['symbol_left']) . "', symbol_right = '" . $this->db->escape($data['symbol_right']) . "', decimal_place = '" . $this->db->escape($data['decimal_place']) . "', value = '" . $this->db->escape($data['value']) . "', status = '" . (int)$data['status'] . "', date_modified = NOW()");

		$currency_id = $this->db->getLastId();

		if ($this->config->get('config_currency_auto')) {
			$this->load->controller('extension/currency/' . $this->config->get('config_currency_engine') . "/currency", $this->config->get('config_currency'));
		}

		$this->cache->delete('currency');
		$this->cache->delete('product');

		return $currency_id;
	}

	public function editCurrency($currency_id, $data)
	{

		$cur = $this->getCurrency($currency_id);

		if ($currency_id == 2) {
			$this->db->query("UPDATE " . DB_PREFIX . "product SET price = yprice * " . $this->db->escape(1 / $data['value']) . ", date_modified = NOW() WHERE currency_id = 2");
			$this->db->query("UPDATE " . DB_PREFIX . "product SET yprice = price * " . $this->db->escape($data['value']) . ", date_modified = NOW() WHERE currency_id = 1");
		}

		$this->db->query("UPDATE " . DB_PREFIX . "currency SET title = '" . $this->db->escape($data['title']) . "', code = '" . $this->db->escape($data['code']) . "', symbol_left = '" . $this->db->escape($data['symbol_left']) . "', symbol_right = '" . $this->db->escape($data['symbol_right']) . "', decimal_place = '" . $this->db->escape($data['decimal_place']) . "', value = '" . $this->db->escape($data['value']) . "', status = '" . (int)$data['status'] . "', date_modified = NOW() WHERE currency_id = '" . (int)$currency_id . "'");

		$this->load->model('catalog/product');
		$this->model_catalog_product->updateMarkupProducts();

		$this->cache->delete('currency');
		$this->cache->delete('product');
	}

	public function deleteCurrency($currency_id)
	{
		$this->db->query("DELETE FROM " . DB_PREFIX . "currency WHERE currency_id = '" . (int)$currency_id . "'");

		$this->cache->delete('currency');
		$this->cache->delete('product');
	}

	public function getCurrency($currency_id)
	{
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "currency WHERE currency_id = '" . (int)$currency_id . "'");

		return $query->row;
	}

	public function getCurrencyByCode($currency)
	{
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "currency WHERE code = '" . $this->db->escape($currency) . "'");

		return $query->row;
	}

	public function editValueByCode($code, $value)
	{
		$this->db->query("UPDATE `" . DB_PREFIX . "currency` SET `value` = '" . (float)$value . "', `date_modified` = NOW() WHERE `code` = '" . $this->db->escape((string)$code) . "'");

		$this->load->model('catalog/product');
		$this->model_catalog_product->updateMarkupProducts();

		$this->cache->delete('currency');
		$this->cache->delete('product');
	}

	public function getCurrencies($data = array())
	{
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "currency";

			$sort_data = array(
				'title',
				'code',
				'value',
				'date_modified'
			);

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];
			} else {
				$sql .= " ORDER BY title";
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
		} else {
			$currency_data = $this->cache->get('currency');

			if (!$currency_data) {
				$currency_data = array();

				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "currency ORDER BY title ASC");

				foreach ($query->rows as $result) {
					$currency_data[$result['code']] = array(
						'currency_id'   => $result['currency_id'],
						'title'         => $result['title'],
						'code'          => $result['code'],
						'symbol_left'   => $result['symbol_left'],
						'symbol_right'  => $result['symbol_right'],
						'decimal_place' => $result['decimal_place'],
						'value'         => $result['value'],
						'status'        => $result['status'],
						'date_modified' => $result['date_modified']
					);
				}

				$this->cache->set('currency', $currency_data);
			}

			return $currency_data;
		}
	}

	public function getTotalCurrencies()
	{
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "currency");

		return $query->row['total'];
	}
}
