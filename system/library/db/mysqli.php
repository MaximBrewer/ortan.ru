<?php

namespace DB;

final class MySQLi
{
	private $connection;

	public function __construct($hostname, $username, $password, $database, $port = '3306')
	{
		try {
			$mysqli = new \mysqli($hostname, $username, $password, $database, $port);
		} catch (mysqli_sql_exception $e) {
			throw new \Exception('Error: Could not make a database link using ' . $username . '@' . $hostname . '!');
		}

		if (!$mysqli->connect_errno) {
			$this->connection = $mysqli;
			$this->connection->report_mode = MYSQLI_REPORT_ERROR;
			$this->connection->set_charset('utf8');
			$this->connection->query("SET SESSION sql_mode = ''");
		} else {
			throw new \Exception('Error: Could not make a database link using ' . $username . '@' . $hostname . '!');
		}
	}

	public function query($sql, $params)
	{
		if (isset($params['multi']) && $params['multi']) {
			$query = $this->connection->multi_query($sql);
			while ($this->connection->next_result()){};
			return;
		}
		$cache = new \Cache('Redis', '3600');

		$cache_key = 'mysql.keyword.' . md5(serialize($sql));

		$caching = strstr($sql, 'SELECT * FROM oc_url_alias WHERE')
			|| strstr($sql, 'SELECT * FROM oc_extension WHERE')
			|| strstr($sql, 'SELECT value FROM oc_setting WHERE')
			|| strstr($sql, 'SELECT * FROM oc_store WHERE')
			|| strstr($sql, 'SELECT DISTINCT * FROM oc_cc_city c LEFT JOIN oc_cc_city_description')
			|| strstr($sql, 'SELECT * FROM oc_currency')
			|| strstr($sql, 'SELECT parent_id, sizes FROM oc_category WHERE')
			|| strstr($sql, 'SELECT * FROM oc_category_to_layout WHERE')
			|| strstr($sql, 'SELECT * FROM oc_layout_route WHERE')

			|| strstr($sql, 'SELECT * FROM oc_category c LEFT JOIN oc_category_description cd ON')
			|| strstr($sql, 'SELECT * FROM oc_information i LEFT JOIN oc_information_description id ON')
			|| strstr($sql, 'SELECT * FROM oc_layout_module WHERE')
			|| strstr($sql, 'SELECT * FROM oc_weight_class wc LEFT JOIN oc_weight_class_description wcd ON')
			|| strstr($sql, 'SELECT * FROM oc_length_class mc LEFT JOIN oc_length_class_description mcd ON')
			|| strstr($sql, 'SELECT * FROM oc_product_to_category WHERE product_id')
			|| strstr($sql, 'SELECT * FROM oc_category WHERE category_id')
			|| strstr($sql, 'SELECT DISTINCT * FROM oc_currency WHERE code')
			|| strstr($sql, 'SELECT category_id, parent_id FROM oc_category WHERE')
			|| strstr($sql, 'SELECT c.category_id, c.parent_id, p.seo_canonical FROM oc_product_to_category p2c LEFT JOIN oc_category c ON (p2c.category_id = c.category_id) LEFT JOIN oc_product p ON (p2c.product_id = p.product_id) WHERE p2c.product_id')
			|| strstr($sql, 'SELECT * FROM oc_product_option_value pov LEFT JOIN oc_option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN oc_option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE')
			|| strstr($sql, 'SELECT * FROM oc_product_option_value pov LEFT JOIN oc_option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN oc_option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE')
			|| strstr($sql, 'SELECT * FROM oc_product_option po LEFT JOIN `oc_option` o ON (po.option_id = o.option_id) LEFT JOIN oc_option_description od ON (o.option_id = od.option_id) WHERE')
			|| strstr($sql, "SELECT REPLACE(`query`, 'manufacturer_id=', '') AS manufacturer_id FROM oc_url_alias WHERE")
			|| strstr($sql, 'SELECT DISTINCT * FROM oc_category c LEFT JOIN oc_category_description cd ON')
			|| strstr($sql, 'SELECT c.category_id, c.parent_id, p.seo_canonical FROM oc_product_to_category p2c LEFT JOIN oc_category c ON (p2c.category_id = c.category_id) LEFT JOIN oc_product p ON (p2c.product_id = p.product_id) WHERE')
			|| strstr($sql, "SELECT DISTINCT *, pd.name AS name, p.image, (SELECT md.name FROM oc_manufacturer_description md WHERE md.manufacturer_id = p.manufacturer_id AND md.language_id = '1') AS manufacturer, (SELECT price FROM oc_product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '1' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM oc_product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '1' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special, (SELECT points FROM oc_product_reward pr WHERE pr.product_id = p.product_id AND customer_group_id = '1') AS reward, (SELECT ss.name FROM oc_stock_status ss WHERE ss.stock_status_id = p.stock_status_id AND ss.language_id = '1') AS stock_status, (SELECT wcd.unit FROM oc_weight_class_description wcd WHERE p.weight_class_id = wcd.weight_class_id AND wcd.language_id = '1') AS weight_class, (SELECT lcd.unit FROM oc_length_class_description lcd WHERE p.length_class_id = lcd.length_class_id AND lcd.language_id = '1') AS length_class, (SELECT AVG(rating) AS total FROM oc_review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT COUNT(*) AS total FROM oc_review r2 WHERE r2.product_id = p.product_id AND r2.status = '1' GROUP BY r2.product_id) AS reviews, p.sort_order FROM oc_product p LEFT JOIN oc_product_description pd ON (p.product_id = pd.product_id) LEFT JOIN oc_product_to_store p2s ON (p.product_id = p2s.product_id) LEFT JOIN oc_manufacturer m ON (p.manufacturer_id = m.manufacturer_id) WHERE p.product_id")
			|| strstr($sql, 'SELECT c.category_id, c.parent_id, p.seo_canonical FROM oc_product_to_category p2c LEFT JOIN oc_category c ON (p2c.category_id = c.category_id) LEFT JOIN oc_product p ON (p2c.product_id = p.product_id) WHERE')
			|| strstr($sql, 'SELECT keyword FROM oc_ocfilter_option_value WHERE value_id')
			|| strstr($sql, 'SELECT keyword FROM oc_ocfilter_option WHERE option_id')
			|| strstr($sql, 'SELECT * FROM oc_layout_route WHERE')
			|| strstr($sql, 'SELECT * FROM oc_layout_route WHERE')
			|| strstr($sql, 'SELECT * FROM oc_layout_route WHERE')


			|| strstr($sql, 'SELECT * FROM `oc_setting` WHERE')
			|| strstr($sql, 'SELECT keyword FROM oc_url_alias WHERE')
			|| strstr($sql, 'SELECT city_id FROM oc_cc_city WHERE')
			|| false;

		if (!defined('IS_ADMIN') || !IS_ADMIN) {
			if ($caching) {
				$sql_data = $cache->get($cache_key);

				if (false !== $sql_data) {
					$result = new \stdClass();
					$result->num_rows = $sql_data['num_rows'];
					$result->row = $sql_data['row'];
					$result->rows = $sql_data['rows'];
					return $result;
				}
			}
		}

		$start = microtime(true);
		$query = $this->connection->query($sql);

		if (!$this->connection->errno) {
			if ($query instanceof \mysqli_result) {
				$data = array();

				while ($row = $query->fetch_assoc()) {
					$data[] = $row;
				}

				$result = new \stdClass();
				$result->num_rows = $query->num_rows;
				$result->row = isset($data[0]) ? $data[0] : array();
				$result->rows = $data;


				if ($caching) {
					$cache->set($cache_key, [
						'num_rows' => $result->num_rows,
						'row' => $result->row,
						'rows' => $result->rows,
					]);
				}

				$query->close();

				// file_put_contents($_SERVER['DOCUMENT_ROOT'] . '/mysql.log', print_r([
				// 	number_format((microtime(true) - $start) / 1000, 8),
				// 	$sql
				// ], !0), FILE_APPEND);
				return $result;
			} else {
				return true;
			}
		} else {
			throw new \Exception('Error: ' . $this->connection->error  . '<br />Error No: ' . $this->connection->errno . '<br />' . $sql);
		}
	}

	public function escape($value)
	{
		return $this->connection->real_escape_string($value);
	}

	public function countAffected()
	{
		return $this->connection->affected_rows;
	}

	public function getLastId()
	{
		return $this->connection->insert_id;
	}

	public function connected()
	{
		return $this->connection->ping();
	}

	public function __destruct()
	{
		$this->connection->close();
	}
}
