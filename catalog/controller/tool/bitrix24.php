<?php
class ControllerToolBitrix24 extends Controller
{

    public function products2bitrix(){
        set_time_limit(3600);

        $this->load->model('extension/module/bitrix24');

        $this->category2bitrix(0);
        //$this->property2bitrix(11, 221); //опция товара - размер
        //$this->property2bitrix(11, 221); //опция сделки - размер


        $q = "SELECT p.product_id 
            FROM " . DB_PREFIX . "product p
            WHERE p.status='1' ORDER BY p.bitrix_uploaded";
/*
        $q = "SELECT DISTINCT(p.product_id) FROM " . DB_PREFIX . "product_option po 
            LEFT JOIN " . DB_PREFIX . "product p ON po.product_id=p.product_id
            WHERE po.option_id='11' AND p.status='1' ORDER BY p.bitrix_uploaded LIMIT 1";
*/
        $query = $this->db->query($q);
        foreach($query->rows as $aProduct){
            $bitrixId = $this->model_extension_module_bitrix24->export_product($aProduct['product_id']);
        }
	}

	public function properties(){
        $this->load->model('extension/module/bitrix24');
        $res = $this->model_extension_module_bitrix24->get_properties();
        print_r($res);
    }
	public function property(){
        $this->load->model('extension/module/bitrix24');
        $res = $this->model_extension_module_bitrix24->get_property(223);
        print_r($res);
    }

    //экспорт значений опции в Битрикс
	public function property2bitrix($option_id = 11, $bitrixPropertyId = 223, $language_id = 1){
        $this->load->model('extension/module/bitrix24');

        $q = "SELECT ov.option_value_id, ov.sort_order, ov.bitrix_id, ovd.name FROM " . DB_PREFIX . "option_value ov 
            LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) 
            WHERE ov.option_id = '" . (int)$option_id . "' AND ovd.language_id = '" . (int)$language_id . "' ORDER BY ov.sort_order, ovd.name";
        $query = $this->db->query($q);

        $aOptionValues = [];
        foreach ($query->rows as $aOptionValue) {
            $aOptionValues[] = [
                'option_value_id' => $aOptionValue['option_value_id'],
                'name'            => $aOptionValue['name'],
                'sort_order'      => $aOptionValue['sort_order'],
                'bitrix_id'       => $aOptionValue['bitrix_id'],
            ];
        }

        $res = $this->model_extension_module_bitrix24->update_property_values($bitrixPropertyId, $aOptionValues);
        return $res;
    }

    private function category2bitrix($categoryId){
        $this->load->model('extension/module/bitrix24');

        $q = "SELECT ca.*, cd.name cd_name, pa.bitrix_id pa_bitrix_id FROM " . DB_PREFIX . "category ca
            LEFT JOIN " . DB_PREFIX . "category pa ON ca.parent_id=pa.category_id 
            LEFT JOIN " . DB_PREFIX . "category_description cd ON ca.category_id=cd.category_id AND city_id='510' AND cd.language_id='1' 
            WHERE ca.parent_id='".(int)$categoryId."' AND ca.status='1'";
        $query = $this->db->query($q);
        foreach($query->rows as $aCategory){
            if ($aCategory['category_id'] != 59) {
                $bitrixId = $this->model_extension_module_bitrix24->export_category($aCategory['bitrix_id'], $aCategory);
                $bitrixId = !empty($bitrixId) ? $bitrixId : $aCategory['bitrix_id'];
                if ($bitrixId) {
                    $q = "UPDATE " . DB_PREFIX . "category
                        SET bitrix_id='" . (int)$bitrixId . "' 
                        WHERE category_id='" . (int)$aCategory['category_id'] . "'";
                    $this->db->query($q);
                }
            }
            $this->category2bitrix($aCategory['category_id']);
        }
    }
}
