<?php
class ModelExtensionModuleCitychooserCity extends Model
{

    public function getCity($code = 'msk')
    {
        // $city_data = $this->cache->get('city.bycode.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . $code);

        if (empty($city_data)) {

            $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "cc_city c LEFT JOIN " . DB_PREFIX . "cc_city_description cd ON (c.city_id = cd.city_id) WHERE c.code = '" . $code . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

            $row = $query->row;
            // var_dump($row);

            if(!$row) $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "cc_city c LEFT JOIN " . DB_PREFIX . "cc_city_description cd ON (c.city_id = cd.city_id) WHERE c.city_id = 510 AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
            $city_data = [
                'city_id' => $row['city_id'],
                'main' => $row['main'],
                'phone' => $row['phone'] ? $row['phone'] : $query->row['phone'],
                'add_phone' => $row['add_phone'] ? $row['add_phone'] : $query->row['add_phone'],
                'email' => $row['email'] ? $row['email'] : $query->row['email'],
                'add_email' => $row['add_email'] ? $row['add_email'] : $query->row['add_email'],
                'whatsapp' => $row['whatsapp'] ? $row['whatsapp'] : $query->row['whatsapp'],
                'telegram' => $row['telegram'] ? $row['telegram'] : $query->row['telegram'],
                'viber' => $row['viber'] ? $row['viber'] : $query->row['viber'],
                'geo_lat' => $row['geo_lat'],
                'geo_lon' => $row['geo_lon'],
                'show_map' => $row['show_map'],
                'full' => $row['full'],
                'city' => $row['city'],
                'address_city' => $row['address_city'],
                'address_city2' => $row['address_city2'],
                'address_zip' => $row['address_zip'],
                'address' => $row['address'],
                'schedule' => $row['schedule'] ? $row['schedule'] : $query->row['schedule'],
            ];

            $this->cache->set('city.bycode.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . $code, $city_data);
        }

        return $city_data;
    }

    public function getCities($data = array())
    {
        $checksum = md5(json_encode($data));

        $cities_data = $this->cache->get('cities.all.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . $checksum);

        if (empty($cities_data)) {

            $sql = "SELECT * FROM " . DB_PREFIX . "cc_city c LEFT JOIN " . DB_PREFIX . "cc_city_description cd ON (c.city_id = cd.city_id)";

            $sql .= " WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

            if (!empty($data['filter_city'])) {
                $sql .= " AND cd.city LIKE '%" . $this->db->escape($data['filter_city']) . "%'";
            }

            $sql .= " GROUP BY c.city_id";

            $sort_data = array(
                'cd.city',
                'c.sort_order'
            );

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $data['sort'];
            } else {
                $sql .= " ORDER BY cd.city";
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

            $cities_data = $query->rows;

            $this->cache->set('cities.all.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . $checksum, $cities_data);
        }

        return $cities_data;
    }

    public function getContactCities($limit = 0)
    {
        $cities_data = $this->cache->get('cities.all.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . $limit);

        if (empty($cities_data)) {
            $sql = "SELECT * FROM " . DB_PREFIX . "cc_city c LEFT JOIN " . DB_PREFIX . "cc_city_description cd ON (c.city_id = cd.city_id)";

            $sql .= " WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

            $sql .= " AND c.show_map=1";

            $sql .= " GROUP BY c.city_id";

            $sort_data = array(
                'cd.city',
                'c.sort_order'
            );

            $sql .= " ORDER BY c.sort, cd.city";
            $sql .= " ASC";

            if ($limit)  $sql .= " LIMIT " . (int)$limit;

            $query = $this->db->query($sql);


            $cities_data = $query->rows;

            $this->cache->set('cities.all.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . $limit, $cities_data);
        }

        return $cities_data;
    }

    public function getBaseCities($limit = 0)
    {
        $cities_data = $this->cache->get('cities.all.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . $limit);

        if (empty($cities_data)) {
            $sql = "SELECT * FROM " . DB_PREFIX . "cc_city c LEFT JOIN " . DB_PREFIX . "cc_city_description cd ON (c.city_id = cd.city_id)  WHERE c.main = 1 AND  cd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

            $sql .= " ORDER BY c.sort, cd.city";
            $sql .= " ASC";

            if ($limit)  $sql .= " LIMIT " . (int)$limit;

            $query = $this->db->query($sql);


            $cities_data = $query->rows;

            $this->cache->set('cities.all.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.' . $this->config->get('config_customer_group_id') . '.' . $limit, $cities_data);
        }

        return $cities_data;
    }
}
