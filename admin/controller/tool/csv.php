<?php
class ControllerToolCsv extends Controller
{
	
	public function getProductStore($store) {
        $stores = [
            1 => 'Россия',
            2 => 'Беларусь', 
            3 => 'Китай'
        ];
		if(isset($stores[$store])){
			return $stores[$store];
		} else {
			return 'Россия';
		}
	}

    public function categories(){

        $arr = $this->cats2arr(0);

        $filename = 'categories-'.uniqid(). '.csv';
        header("Content-Type: text/csv");
        header("Content-Disposition: attachment; filename=".$filename);

        $output = fopen("php://output", "wb");
        foreach ($arr as $row) {
            fputcsv($output, $row, ';');
        }
        fclose($output);
        die;
    }

    public function brands(){

        $filename = 'brands-'.uniqid(). '.csv';
        header("Content-Type: text/csv");
        header("Content-Disposition: attachment; filename=".$filename);

        $output = fopen("php://output", "wb");
        $arr = [];
        $q = "SELECT name FROM " . DB_PREFIX . "option_value_description WHERE option_id='14' ORDER BY name";
        $query = $this->db->query($q);
        foreach($query->rows as $row){
            fputcsv($output, $row, ';');
        }

        fclose($output);
        die;
    }

    public function products2bitrix(){
        set_time_limit(300);

        $this->load->model('tool/image');

        $row = [
            'ID' => 'ID',
            'extID' => 'Внешний код',
            'name' => 'Название',
            'symbCode' => 'Символьный код',
            'decription' => 'Описание',
            'decriptionFormat' => 'Формат описания',
            'active' => 'Активен',
            'currency' => 'Валюта',
            'price' => 'Цена',
            'NDS' => 'Ставка НДС',
            'priceIncludeNDS' => 'НДС включён в цену',
            'unit' => 'Единица измерения',
            'category1' => 'Раздел (уровень 1)',
            'category2' => 'Раздел (уровень 2)',
            'category3' => 'Раздел (уровень 3)',
            'sort' => 'Сорт.',
            'thumb' => 'Картинка для анонса',
            'image' => 'Детальная картинка',
            'images' => 'Картинки галереи',
            'model' => 'Модель',
            'size' => 'Размер',
            'colour' => 'Цвет',
            'test' => 'Тест',
            'sizes' => 'Точные размеры',
            'brand' => 'Бренд',
            'omolgType' => 'Тип омологации',
            'link' => 'Ссылка на сайт',
            'store' => 'Склад доставки'
        ];


        $filename = 'product2bitrix-'.uniqid(). '.csv';
        header('Content-Encoding: UTF-8');
        header('Content-type: text/csv; charset=UTF-8');
        header("Content-Disposition: attachment; filename=".$filename);

        $output = fopen("php://output", "wb");
        fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF));

        fputcsv($output, $row, ';');


        $q = "SELECT * FROM " . DB_PREFIX . "product pr
            LEFT JOIN " . DB_PREFIX . "product_description pd ON pr.product_id=pd.product_id AND language_id='1' 
            WHERE pr.status='1' ORDER BY pr.product_id";
        $query = $this->db->query($q);
        foreach($query->rows as $aProduct){
            // if($aProduct['product_id'] !=9870) continue;
            //Бренд
            $brandName = $this->productOptionValue($aProduct['product_id'], 14);

            //Омолгация
            $omolgName = $this->productOptionValue($aProduct['product_id'], 40);

            //Цвет
            $colourName = $this->productOptionValue($aProduct['product_id'], 13);

            //Размер
            $sizeName = $this->productOptionValue($aProduct['product_id'], 11);

            //Склад
            $store = $this->getProductStore($aProduct['store']);

            //Категория
            $aCatNames = [];
            $q = "SELECT cd.name, c.category_id, c.parent_id, ua.keyword  FROM " . DB_PREFIX . "product_to_category p2c 
                LEFT JOIN " . DB_PREFIX . "category c ON c.category_id=p2c.category_id
                LEFT JOIN " . DB_PREFIX . "category_description cd ON cd.category_id=p2c.category_id
                LEFT JOIN " . DB_PREFIX . "url_alias ua ON ua.query=CONCAT('category_id=', c.category_id)
                WHERE p2c.product_id = '" . (int)$aProduct['product_id'] . "' AND p2c.main_category='1' AND c.category_id > 0 LIMIT 1";
            $qCats = $this->db->query($q);
            if(empty($qCats->rows)){
                $q = "SELECT cd.name, c.category_id, c.parent_id, ua.keyword  FROM " . DB_PREFIX . "product_to_category p2c 
                    LEFT JOIN " . DB_PREFIX . "category c ON c.category_id=p2c.category_id
                    LEFT JOIN " . DB_PREFIX . "category_description cd ON cd.category_id=p2c.category_id
                    LEFT JOIN " . DB_PREFIX . "url_alias ua ON ua.query=CONCAT('category_id=', c.category_id)
                    WHERE p2c.product_id = '" . (int)$aProduct['product_id'] . "' AND c.category_id > 0 LIMIT 1";
                $qCats = $this->db->query($q);
            }
            foreach($qCats->rows as $aCat){
                array_unshift($aCatNames, $aCat);
            }
            
            
            $cnt = 0;
            while($aCatNames[0] && $aCatNames[0]['parent_id']){
                ++$cnt;
                if($cnt > 6) break;
                $q = "SELECT cd.name, c.category_id, c.parent_id, ua.keyword FROM " . DB_PREFIX . "category c 
                    LEFT JOIN " . DB_PREFIX . "category_description cd ON cd.category_id=c.category_id
                    LEFT JOIN " . DB_PREFIX . "url_alias ua ON ua.query=CONCAT('category_id=', c.category_id)
                    WHERE c.category_id = '" . $aCatNames[0]['parent_id'] . "' LIMIT 1";
                $qCats = $this->db->query($q);
                foreach($qCats->rows as $aCat){
                    array_unshift($aCatNames, $aCat);
                }
            }
            //Точные размеры
            $sizes = $aProduct['length'] . '*' . $aProduct['width'] . '*' . $aProduct['height'];

            if ($aProduct['image']) {
                $image = 'https://ortan.ru/image/'. $aProduct['image'];
                $thumb = $this->model_tool_image->resize($aProduct['image'], 200, 200);
            } else {
                $image = '';
                $thumb = '';
            }

            $links = [];

            $categories = [];
            foreach($aCatNames as $aCat){
                $links[] = $aCat['keyword'];
                if($aCat['product_id'] == 59) continue;
                $categories[] = $aCat;
            }
            // echo "<pre>";
            // var_dump($categories);
            // echo "</pre>";
            
            $links[] = $aProduct['seo_keyword'];
            $link = trim(implode("/", $links), "/");
            $link = "https://ortan.ru/" . $link. "/";

            $row = [
                'ID' => $aProduct['product_id'],
                'extID' => $aProduct['product_id'],
                'name' => $aProduct['name'],
                'symbCode' => '',
                'decription' => htmlspecialchars_decode($aProduct['description']),
                'decriptionFormat' => '',
                'active' => $aProduct['status'] ? 'Да' : 'Нет',
                'currency' => 'RUB',
                'price' => $aProduct['rub_price'],
                'NDS' => '',
                'priceIncludeNDS' => '',
                'unit' => 'шт.',
                'category1' => isset($categories[0]) && !empty($categories[0]) ? $categories[0]['name'] : '',
                'category2' => isset($categories[1]) && !empty($categories[1]) ? $categories[1]['name'] : '',
                'category3' => isset($categories[2]) && !empty($categories[2]) ? $categories[2]['name'] : '',
                'sort' => '',
                'thumb' => $thumb,
                'image' => $image,
                'images' => '',
                'model' => $aProduct['model'],
                'size' => $sizeName,
                'colour' => $colourName,
                'test' => 'Тест',
                'sizes' => $sizes,
                'brand' => $brandName,
                'omolgType' => $omolgName,
                'link' => $link,
                'store' => $store
            ];
            // echo "<pre>";
            // var_dump($row);
            // echo "</pre>";
            // die;
            $aProduct['status'] && fputcsv($output, $row, ';');
        }

        fclose($row);
        die;
    }
    private function productOptionValue($product_id, $option_id){
        $q = "SELECT ovd.name FROM " . DB_PREFIX . "product_option_value pov
                LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON ovd.option_value_id=pov.option_value_id AND ovd.option_id='". (int)$option_id ."' AND ovd.language_id='1' 
                WHERE pov.product_id='" . (int)$product_id . "' AND pov.option_id='". (int)$option_id ."'";
        $qRes = $this->db->query($q);
        $aRes = !empty($qRes->row) ? $qRes->row : [];

        return !empty($aRes['name']) ? $aRes['name'] : '';
    }

    private function cats2arr($cat_id){
        $arr = [];
        $this->load->model('catalog/category');
        $aCategories = $this->model_catalog_category->getCategories($cat_id);
        foreach ($aCategories as $aCategory) {
            $h1 = !empty($aCategory['meta_h1']) ? $aCategory['meta_h1'] : $aCategory['name'];
            $h1 = iconv('UTF-8', 'WINDOWS-1251', $h1);
            $url = $this->url->link('product/category', 'path=' . $aCategory['category_id'], true);
            $arr[] = [$h1, $url];
            $aChildren = $this->cats2arr($aCategory['category_id']);
            if (!empty($aChildren)){
                $arr = array_merge($arr, $aChildren);
            }
        }
        return $arr;
    }
}
// UPDATE `oc_product` SET `store`=1 WHERE `product_id` IN (SELECT `product_id` FROM `oc_product_to_category` WHERE `category_id` = 207);
// UPDATE `oc_product` SET `store`=2 WHERE `product_id` IN (SELECT `product_id` FROM `oc_product_option_value` WHERE `option_id` = 14 AND `option_value_id` = 942);
