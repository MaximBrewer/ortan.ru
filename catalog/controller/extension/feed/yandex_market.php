<?php

/**
 * Класс YML экспорта
 * YML (Yandex Market Language) - стандарт, разработанный "Яндексом"
 * для принятия и публикации информации в базе данных Яндекс.Маркет
 * YML основан на стандарте XML (Extensible Markup Language)
 * описание формата YML http://partner.market.yandex.ru/legal/tt/
 */
class ControllerExtensionFeedYandexMarket extends Controller
{
	private $shop = array();
	private $currencies = array();
	private $categories = array();
	private $offers = array();
	private $from_charset = 'utf-8';
	private $eol = "\n";

	public function index()
	{
		if ($this->config->get('yandex_market_status')) {

			if (!($allowed_categories = $this->config->get('yandex_market_categories'))) exit();

			$this->load->model('extension/feed/yandex_market');
			$this->load->model('localisation/currency');
			$this->load->model('tool/image');

			// Магазин
			$this->setShop('name', $this->config->get('yandex_market_shopname'));
			$this->setShop('company', $this->config->get('yandex_market_company'));
			$this->setShop('url', HTTP_SERVER);
			$this->setShop('phone', $this->config->get('config_telephone'));
			$this->setShop('platform', 'ocStore');
			$this->setShop('version', VERSION);

			// Валюты
			// TODO: Добавить возможность настраивать проценты в админке.
			$offers_currency = $this->config->get('yandex_market_currency');
			if (!$this->currency->has($offers_currency)) exit();

			$decimal_place = $this->currency->getDecimalPlace($offers_currency);

			$shop_currency = $this->config->get('config_currency');

			$this->setCurrency($offers_currency, 1);

			$currencies = $this->model_localisation_currency->getCurrencies();

			$supported_currencies = array('RUR', 'RUB', 'USD', 'BYR', 'KZT', 'EUR', 'UAH');

			$currencies = array_intersect_key($currencies, array_flip($supported_currencies));

			foreach ($currencies as $currency) {
				if ($currency['code'] != $offers_currency && $currency['status'] == 1) {
					$this->setCurrency($currency['code'], number_format(1 / $this->currency->convert($currency['value'], $offers_currency, $shop_currency), 4, '.', ''));
				}
			}

			// Категории
			$categories = $this->model_extension_feed_yandex_market->getCategory();

			foreach ($categories as $category) {
				$this->setCategory($category['name'], $category['category_id'], $category['parent_id']);
			}

			// Товарные предложения
			$in_stock_id = $this->config->get('yandex_market_in_stock'); // id статуса товара "В наличии"
			$out_of_stock_id = $this->config->get('yandex_market_out_of_stock'); // id статуса товара "Нет на складе"
			$vendor_required = false; // true - только товары у которых задан производитель, необходимо для 'vendor.model'

			if (isset($_GET['stock']))
				$products = $this->model_extension_feed_yandex_market->getStockProduct($allowed_categories, $out_of_stock_id, $vendor_required);
			elseif (isset($_GET['category_id'])) {
				$products = $this->model_extension_feed_yandex_market->getCategoryProduct($_GET['category_id'], $out_of_stock_id, $vendor_required);
			} elseif (!isset($_GET['all']))
				$products = $this->model_extension_feed_yandex_market->getProduct($allowed_categories, $out_of_stock_id, $vendor_required);
			else
				$products = $this->model_extension_feed_yandex_market->getAllProduct($allowed_categories, $out_of_stock_id, $vendor_required);

			foreach ($products as $product) {
				// var_dump($product);die;
				if (!$product['ovd_name']) continue;
				if (!empty($product['name_ym'])) {
					$product['name'] = $product['name_ym'];
				}

				$data = array();

				// Атрибуты товарного предложения
				$data['id'] = $product['product_id'];
				$data['group_id'] = $product['product_id'];
				// $data['type'] = 'vendor.model';
				$data['available'] = ($product['quantity'] > 0 || $product['stock_status_id'] == $in_stock_id);
				//				$data['bid'] = 10;
				//				$data['cbid'] = 15;

				// Параметры товарного предложения
				$data['url'] = $this->url->link('product/product', 'path=' . $this->getPath($product['category_id']) . '&product_id=' . $product['product_id']);
				$data['price'] = $this->currency->convert($this->tax->calculate($product['rub_price'], $product['tax_class_id']), $shop_currency, $offers_currency);
				$data['oldprice'] = false;
				if ($product['discount'] && $product['rub_price'] > $product['discount']) {
					$data['oldprice'] = $data['price'];
					$data['price'] = $this->currency->convert($this->tax->calculate($product['discount'], $product['tax_class_id']), $shop_currency, $offers_currency);
				}

				$data['currencyId'] = $offers_currency;
				$data['categoryId'] = $product['category_id'];
				$data['delivery'] = 'true';
				//				$data['local_delivery_cost'] = 100;

				$data['name'] = $product['name'];
				$data['vendor'] = $product['ovd_name'];
				$data['vendorCode'] = $product['model'];
				$data['barcode'] = $this->generateEAN($product['product_id']);
				// if ($product['country']) $data['country_of_origin'] = $product['country'];
				$data['country_of_origin'] = $product['ovd2_name'];

				$data['model'] = $product['name'];
				$data['description'] = strip_tags($product['description']) ?: $product['name'];
				//				$data['manufacturer_warranty'] = 'true';

				if ($product['image']) {
					$data['picture'] = $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
				}

				$images = $this->model_catalog_product->getProductImages($product['product_id']);
				if (!empty($images)) {
					$data['picture'] = [$data['picture']];
					foreach ($images as $image) {
						$data['picture'][] = $this->model_tool_image->resize($image['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
					}
				}

				if (floatval($product['weight']) and $product['weight_class_id']) {
					$data['weight'] = $this->weight->format($product['weight'], $product['weight_class_id']);
				}
				$data['weight'] = 1;

				if ((floatval($product['length'])
					or floatval($product['width'])
					or floatval($product['height'])
				) and $product['length_class_id']) {
					$length = $this->weight->format($product['length'], $product['length_class_id']);
					$width = $this->weight->format($product['width'], $product['length_class_id']);
					$height = $this->weight->format($product['height'], $product['length_class_id']);

					$length = $this->weight->format($product['length'], $product['length_class_id']);
					$width = $this->weight->format($product['width'], $product['length_class_id']);
					$height = $this->weight->format($product['height'], $product['length_class_id']);
					$data['dimensions'] = $length . '/' . $width . '/' . $height;
				}
				$data['dimensions'] = 20 . '/' . 20 . '/' . 10;

				if ($product['colors']) {
					foreach (explode(',', $product['colors']) as $color) {
						$data['param'][] = [
							'name' => 'Цвет',
							'value' => str_replace(['светло-', 'темно-'], '', mb_strtolower($color))
						];
						break;
					}
				}
				// <param name="Цвет">желтый</param> 

				/*
				// пример структуры массива для вывода параметров
				$data['param'] = array(
					array(
						'name'=>'Wi-Fi',
						'value'=>'есть'
					), array(
						'name'=>'Размер экрана',
						'unit'=>'дюйм',
						'value'=>'20'
					), array(
						'name'=>'Вес',
						'unit'=>'кг',
						'value'=>'4.6'
					)
				);
*/


				if ($product['sizes']) {
					foreach (explode(',', $product['sizes']) as $size) {
						$offerData = $data;
						$offerData['id'] .= '-' . $size;
						// $offerData['id'] = $offerData['id'] ю;
						$offerData['param'][] = [
							'name' => 'Размер',
							'value' => $size,
							'unit' => 'INT'
						];
						// <param name="Размер" unit="INT">XXL</param>
						$this->setOffer($offerData);
					}
				} else {
					$data['id'] = md5($data['id']);
					$this->setOffer($data);
				}
			}

			$this->categories = array_filter($this->categories, array($this, "filterCategory"));

			$this->response->addHeader('Content-Type: application/xml');
			$yml = $this->getYml();
			if (!isset($_GET['all'])) {
				file_put_contents(DIR_ROOT_PATH . '/feed/yandex_market.xml', $yml);
			} elseif (isset($_GET['category_id'])) {
				file_put_contents(DIR_ROOT_PATH . '/feed/yandex_market_' . $_GET['category_id'] . '.xml', $yml);
			} {
				file_put_contents(DIR_ROOT_PATH . '/feed/yandex_market_all.xml', $yml);
			}
			$this->response->setOutput($yml);
		}
	}

	/**
	 * Методы формирования YML
	 */

	/**
	 * Формирование массива для элемента shop описывающего магазин
	 *
	 * @param string $name - Название элемента
	 * @param string $value - Значение элемента
	 */
	private function setShop($name, $value)
	{
		$allowed = array('name', 'company', 'url', 'phone', 'platform', 'version', 'agency', 'email');
		if (in_array($name, $allowed)) {
			$this->shop[$name] = $this->prepareField($value);
		}
	}

	/**
	 * Валюты
	 *
	 * @param string $id - код валюты (RUR, RUB, USD, BYR, KZT, EUR, UAH)
	 * @param float|string $rate - курс этой валюты к валюте, взятой за единицу.
	 *	Параметр rate может иметь так же следующие значения:
	 *		CBRF - курс по Центральному банку РФ.
	 *		NBU - курс по Национальному банку Украины.
	 *		NBK - курс по Национальному банку Казахстана.
	 *		СВ - курс по банку той страны, к которой относится интернет-магазин
	 * 		по Своему региону, указанному в Партнерском интерфейсе Яндекс.Маркета.
	 * @param float $plus - используется только в случае rate = CBRF, NBU, NBK или СВ
	 *		и означает на сколько увеличить курс в процентах от курса выбранного банка
	 * @return bool
	 */
	private function setCurrency($id, $rate = 'CBRF', $plus = 0)
	{
		$allow_id = array('RUR', 'RUB', 'USD', 'BYR', 'KZT', 'EUR', 'UAH');
		if (!in_array($id, $allow_id)) {
			return false;
		}
		$allow_rate = array('CBRF', 'NBU', 'NBK', 'CB');
		if (in_array($rate, $allow_rate)) {
			$plus = str_replace(',', '.', $plus);
			if (is_numeric($plus) && $plus > 0) {
				$this->currencies[] = array(
					'id' => $this->prepareField(strtoupper($id)),
					'rate' => $rate,
					'plus' => (float)$plus
				);
			} else {
				$this->currencies[] = array(
					'id' => $this->prepareField(strtoupper($id)),
					'rate' => $rate
				);
			}
		} else {
			$rate = str_replace(',', '.', $rate);
			if (!(is_numeric($rate) && $rate > 0)) {
				return false;
			}
			$this->currencies[] = array(
				'id' => $this->prepareField(strtoupper($id)),
				'rate' => (float)$rate
			);
		}

		return true;
	}

	/**
	 * Категории товаров
	 *
	 * @param string $name - название рубрики
	 * @param int $id - id рубрики
	 * @param int $parent_id - id родительской рубрики
	 * @return bool
	 */
	private function setCategory($name, $id, $parent_id = 0)
	{
		$id = (int)$id;
		if ($id < 1 || trim($name) == '') {
			return false;
		}
		if ((int)$parent_id > 0) {
			$this->categories[$id] = array(
				'id' => $id,
				'parentId' => (int)$parent_id,
				'name' => $this->prepareField($name, true)
			);
		} else {
			$this->categories[$id] = array(
				'id' => $id,
				'name' => $this->prepareField($name, true)
			);
		}

		return true;
	}

	/**
	 * Товарные предложения
	 *
	 * @param array $data - массив параметров товарного предложения
	 */
	private function setOffer($data)
	{
		$offer = array();

		$attributes = array('id', 'type', 'available', 'group_id', 'bid', 'cbid', 'param');
		$attributes = array_intersect_key($data, array_flip($attributes));

		foreach ($attributes as $key => $value) {
			switch ($key) {
				case 'id':
				case 'bid':
				case 'cbid':
				case 'group_id':
					$value = $value;
					// if ($value > 0) {
					$offer[$key] = $value;
					// }
					break;

				case 'type':
					if (in_array($value, array('vendor.model', 'book', 'audiobook', 'artist.title', 'tour', 'ticket', 'event-ticket'))) {
						$offer['type'] = $value;
					}
					break;

				case 'available':
					$offer['available'] = ($value ? 'true' : 'false');
					break;

				case 'param':
					if (is_array($value)) {
						$offer['param'] = $value;
					}
					break;

				default:
					break;
			}
		}

		$type = isset($offer['type']) ? $offer['type'] : '';

		$allowed_tags = array('url' => 0, 'buyurl' => 0, 'price' => 1, 'oldprice' => 1, 'dimensions' => 1, 'wprice' => 0, 'currencyId' => 1, 'xCategory' => 0, 'categoryId' => 1, 'picture' => 0, 'store' => 0, 'pickup' => 0, 'delivery' => 0, 'deliveryIncluded' => 0, 'local_delivery_cost' => 0, 'orderingTime' => 0, 'weight' => '0', 'dimension' => '0', 'country_of_origin' => '0', 'barcode' => '0');

		switch ($type) {
			case 'vendor.model':
				$allowed_tags = array_merge($allowed_tags, array('typePrefix' => 0, 'vendor' => 1, 'vendorCode' => 0, 'model' => 1, 'provider' => 0, 'tarifplan' => 0));
				break;

			case 'book':
				$allowed_tags = array_merge($allowed_tags, array('author' => 0, 'name' => 1, 'publisher' => 0, 'series' => 0, 'year' => 0, 'ISBN' => 0, 'volume' => 0, 'part' => 0, 'language' => 0, 'binding' => 0, 'page_extent' => 0, 'table_of_contents' => 0));
				break;

			case 'audiobook':
				$allowed_tags = array_merge($allowed_tags, array('author' => 0, 'name' => 1, 'publisher' => 0, 'series' => 0, 'year' => 0, 'ISBN' => 0, 'volume' => 0, 'part' => 0, 'language' => 0, 'table_of_contents' => 0, 'performed_by' => 0, 'performance_type' => 0, 'storage' => 0, 'format' => 0, 'recording_length' => 0));
				break;

			case 'artist.title':
				$allowed_tags = array_merge($allowed_tags, array('artist' => 0, 'title' => 1, 'year' => 0, 'media' => 0, 'starring' => 0, 'director' => 0, 'originalName' => 0, 'country' => 0));
				break;

			case 'tour':
				$allowed_tags = array_merge($allowed_tags, array('worldRegion' => 0, 'country' => 0, 'region' => 0, 'days' => 1, 'dataTour' => 0, 'name' => 1, 'hotel_stars' => 0, 'room' => 0, 'meal' => 0, 'included' => 1, 'transport' => 1, 'price_min' => 0, 'price_max' => 0, 'options' => 0));
				break;

			case 'event-ticket':
				$allowed_tags = array_merge($allowed_tags, array('name' => 1, 'place' => 1, 'hall' => 0, 'hall_part' => 0, 'date' => 1, 'is_premiere' => 0, 'is_kids' => 0));
				break;

			default:
				$allowed_tags = array_merge($allowed_tags, array('name' => 1, 'vendor' => 0, 'vendorCode' => 0));
				break;
		}

		$allowed_tags = array_merge($allowed_tags, array('aliases' => 0, 'additional' => 0, 'description' => 0, 'sales_notes' => 0, 'promo' => 0, 'manufacturer_warranty' => 0, 'country_of_origin' => 0, 'downloadable' => 0, 'adult' => 0, 'barcode' => 0));

		$required_tags = array_filter($allowed_tags);

		if (sizeof(array_intersect_key($data, $required_tags)) != sizeof($required_tags)) {
			return;
		}

		$data = array_intersect_key($data, $allowed_tags);
		//		if (isset($data['tarifplan']) && !isset($data['provider'])) {
		//			unset($data['tarifplan']);
		//		}

		$allowed_tags = array_intersect_key($allowed_tags, $data);

		// Стандарт XML учитывает порядок следования элементов,
		// поэтому важно соблюдать его в соответствии с порядком описанным в DTD
		$offer['data'] = array();
		foreach ($allowed_tags as $key => $value) {
			if (is_array($data[$key])) {
				$aRes = [];
				foreach ($data[$key] as $arrVal) {
					$aRes[] = $this->prepareField($arrVal);
				}
				$offer['data'][$key] = $aRes;
			} else {
				$offer['data'][$key] = $this->prepareField($data[$key]);
			}
		}
		$this->offers[] = $offer;
	}

	/**
	 * Формирование YML файла
	 *
	 * @return string
	 */
	private function getYml()
	{
		$yml  = '<?xml version="1.0" encoding="UTF-8"?>' . $this->eol;
		$yml .= '<!DOCTYPE yml_catalog SYSTEM "shops.dtd">' . $this->eol;
		$yml .= '<yml_catalog date="' . date('Y-m-d H:i') . '">' . $this->eol;
		$yml .= '<shop>' . $this->eol;

		// информация о магазине
		$yml .= $this->array2Tag($this->shop);

		// валюты
		$yml .= '<currencies>' . $this->eol;
		foreach ($this->currencies as $currency) {
			if ($currency['id'] === 'RUB') {
				$yml .= $this->getElement($currency, 'currency');
			}
		}
		$yml .= '</currencies>' . $this->eol;

		// категории
		$yml .= '<categories>' . $this->eol;
		foreach ($this->categories as $category) {
			$category_name = $category['name'];
			unset($category['name'], $category['export']);
			$yml .= $this->getElement($category, 'category', $category_name);
		}
		$yml .= '</categories>' . $this->eol;

		// товарные предложения
		$yml .= '<offers>' . $this->eol;
		foreach ($this->offers as $offer) {
			$tags = $this->array2Tag($offer['data']);
			unset($offer['data']);
			if (isset($offer['param'])) {
				$tags .= $this->array2Param($offer['param']);
				unset($offer['param']);
			}
			$yml .= $this->getElement($offer, 'offer', $tags);
		}
		$yml .= '</offers>' . $this->eol;

		$yml .= '</shop>';
		$yml .= '</yml_catalog>';

		file_put_contents(DIR_ROOT_PATH . '/market.yml', $yml);

		return $yml;
	}

	/**
	 * Фрмирование элемента
	 *
	 * @param array $attributes
	 * @param string $element_name
	 * @param string $element_value
	 * @return string
	 */
	private function getElement($attributes, $element_name, $element_value = '')
	{
		$retval = '<' . $element_name;
		foreach ($attributes as $key => $value) {
			$retval .= ' ' . $key . '="' . $value . '"';
		}
		//$retval .= $element_value ? '>' . $this->eol . $element_value . '</' . $element_name . '>' : '/>';
		$retval .= $element_value ? '>' . $element_value . '</' . $element_name . '>' : '/>';
		$retval .= $this->eol;

		return $retval;
	}

	/**
	 * Преобразование массива в теги
	 *
	 * @param array $tags
	 * @return string
	 */
	private function array2Tag($tags)
	{
		$retval = '';
		foreach ($tags as $key => $value) {
			if (is_array($value)) {
				foreach ($value as $val) {
					$retval .= '<' . $key . '>' . $val . '</' . $key . '>' . $this->eol;
				}
			} else {
				$retval .= '<' . $key . '>' . $value . '</' . $key . '>' . $this->eol;
			}
		}

		return $retval;
	}

	/**
	 * Преобразование массива в теги параметров
	 *
	 * @param array $params
	 * @return string
	 */
	private function array2Param($params)
	{
		$retval = '';
		foreach ($params as $param) {
			$retval .= '<param name="' . $this->prepareField($param['name']);
			if (isset($param['unit'])) {
				$retval .= '" unit="' . $this->prepareField($param['unit']);
			}
			$retval .= '">' . $this->prepareField($param['value']) . '</param>' . $this->eol;
		}

		return $retval;
	}

	/**
	 * Подготовка текстового поля в соответствии с требованиями Яндекса
	 * Запрещаем любые html-тэги, стандарт XML не допускает использования в текстовых данных
	 * непечатаемых символов с ASCII-кодами в диапазоне значений от 0 до 31 (за исключением
	 * символов с кодами 9, 10, 13 - табуляция, перевод строки, возврат каретки). Также этот
	 * стандарт требует обязательной замены некоторых символов на их символьные примитивы.
	 * @param string $field
	 * @param bool $isCapitalize
	 * @return string
	 */
	private function prepareField($field, $isCapitalize = false)
	{
		$field = htmlspecialchars_decode($field);
		$field = strip_tags($field);
		$field = str_replace("&nbsp;", '', $field);
		$from = array('"', '&', '>', '<', '\'');
		$to = array('&quot;', '&amp;', '&gt;', '&lt;', '&apos;');
		$field = str_replace($from, $to, $field);
		if ($this->from_charset != 'UTF-8') {
			$field = iconv($this->from_charset, 'UTF-8//TRANSLIT//IGNORE', $field);
		}
		$field = preg_replace('#[\x00-\x08\x0B-\x0C\x0E-\x1F]+#is', ' ', $field);
		if ($isCapitalize) {
			$field = mb_strtolower($field, 'UTF-8');
			$field = $this->mb_ucfirst($field, 'UTF-8');
		}

		return trim($field, ' 	');
	}

	private function mb_ucfirst($string, $encoding)
	{
		$firstChar = mb_substr($string, 0, 1, $encoding);
		$then = mb_substr($string, 1, null, $encoding);
		return mb_strtoupper($firstChar, $encoding) . $then;
	}

	protected function getPath($category_id, $current_path = '')
	{
		if (isset($this->categories[$category_id])) {
			$this->categories[$category_id]['export'] = 1;

			if (!$current_path) {
				$new_path = $this->categories[$category_id]['id'];
			} else {
				$new_path = $this->categories[$category_id]['id'] . '_' . $current_path;
			}

			if (isset($this->categories[$category_id]['parentId'])) {
				return $this->getPath($this->categories[$category_id]['parentId'], $new_path);
			} else {
				return $new_path;
			}
		}
	}

	function filterCategory($category)
	{
		return isset($category['export']);
	}

	private function generateEAN($number)
	{
		//$code = '200' . str_pad($number, 9, '0');
		$code = '200' . str_pad($number, 9, '0', STR_PAD_LEFT);
		$weightflag = true;
		$sum = 0;
		// Weight for a digit in the checksum is 3, 1, 3.. starting from the last digit.
		// loop backwards to make the loop length-agnostic. The same basic functionality
		// will work for codes of different lengths.
		for ($i = strlen($code) - 1; $i >= 0; $i--) {
			$sum += (int)$code[$i] * ($weightflag ? 3 : 1);
			$weightflag = !$weightflag;
		}
		$code .= (10 - ($sum % 10)) % 10;
		return $code;
	}
}
