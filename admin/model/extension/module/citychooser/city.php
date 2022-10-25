<?php
class ModelExtensionModuleCitychooserCity extends Model
{

    public function addCity($data)
    {
        $this->db->query("INSERT INTO " . DB_PREFIX . "cc_city SET phone = '" . $this->db->escape($data['phone']) . "',  sort = '" . $this->db->escape($data['sort']) . "', add_phone = '" . $this->db->escape($data['add_phone']) . "', email = '" . $this->db->escape($data['email']) . "', add_email = '" . $this->db->escape($data['add_email']) . "', whatsapp = '" . $this->db->escape($data['whatsapp']) . "', telegram = '" . $this->db->escape($data['telegram']) . "', viber = '" . $this->db->escape($data['viber']) . "', geo_lat = '" . $this->db->escape($data['geo_lat']) . "', geo_lon = '" . $this->db->escape($data['geo_lon']) . "', show_map = '" . (isset($data['show_map']) ? $this->db->escape($data['show_map']) : 0) . "', main = '" . (isset($data['main']) ? $this->db->escape($data['main']) : 0) . "'");

        $city_id = $this->db->getLastId();

        foreach ($data['city_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "cc_city_description SET city_id = '" . (int)$city_id . "', language_id = '" . (int)$language_id . "', full = '" . $this->db->escape($value['full']) . "', city = '" . $this->db->escape($value['city']) . "', address_city = '" . $this->db->escape($value['address_city']) . "', address_city2 = '" . $this->db->escape($value['address_city2']) . "', address_zip = '" . $this->db->escape($value['address_zip']) . "', address = '" . $this->db->escape($value['address']) . "', schedule = '" . $this->db->escape($value['schedule']) . "'");
        }

        $this->cache->delete('city');
        return $city_id;
    }

    public function editCity($city_id, $data)
    {
        $this->db->query("UPDATE " . DB_PREFIX . "cc_city SET phone = '" . $this->db->escape($data['phone']) . "',  sort = '" . $this->db->escape($data['sort']) . "', add_phone = '" . $this->db->escape($data['add_phone']) . "', email = '" . $this->db->escape($data['email']) . "', add_email = '" . $this->db->escape($data['add_email']) . "', whatsapp = '" . $this->db->escape($data['whatsapp']) . "', telegram = '" . $this->db->escape($data['telegram']) . "', viber = '" . $this->db->escape($data['viber']) . "', geo_lat = '" . $this->db->escape($data['geo_lat']) . "', geo_lon = '" . $this->db->escape($data['geo_lon']) . "', show_map = '" . (isset($data['show_map']) ? $this->db->escape($data['show_map']) : 0) . "', main = '" . (isset($data['main']) ? $this->db->escape($data['main']) : 0) . "' WHERE city_id = ".$city_id."");

        $this->db->query("DELETE FROM " . DB_PREFIX . "cc_city_description WHERE city_id = '" . (int)$city_id . "'");

        foreach ($data['city_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "cc_city_description SET city_id = '" . (int)$city_id . "', language_id = '" . (int)$language_id . "', full = '" . $this->db->escape($value['full']) . "', city = '" . $this->db->escape($value['city']) . "', address_city = '" . $this->db->escape($value['address_city']) . "', address_city2 = '" . $this->db->escape($value['address_city2']) . "', address_zip = '" . $this->db->escape($value['address_zip']) . "', address = '" . $this->db->escape($value['address']) . "', schedule = '" . $this->db->escape($value['schedule']) . "'");
        }

        $this->cache->delete('city');
    }

    public function deleteCity($city_id)
    {
        $this->db->query("DELETE FROM " . DB_PREFIX . "cc_city WHERE city_id = '" . (int)$city_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "cc_city_description WHERE city_id = '" . (int)$city_id . "'");
        $this->cache->delete('city');
    }

    public function getTotalCities($data = array())
    {
        $sql = "SELECT COUNT(DISTINCT c.city_id) AS total FROM " . DB_PREFIX . "cc_city c LEFT JOIN " . DB_PREFIX . "cc_city_description cd ON (c.city_id = cd.city_id)";

        $sql .= " WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

        if (!empty($data['filter_city'])) {
            $sql .= " AND cd.city LIKE '%" . $this->db->escape($data['filter_city']) . "%'";
        }

        $query = $this->db->query($sql);

        return $query->row['total'];
    }


    public function getCity($city_id)
    {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "cc_city c LEFT JOIN " . DB_PREFIX . "cc_city_description cd ON (c.city_id = cd.city_id) WHERE c.city_id = '" . (int)$city_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

        return $query->row;
    }

    public function getCities($data = array())
    {

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

        return $query->rows;
    }

    public function getCityDescriptions($city_id)
    {
        $city_description_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "cc_city_description WHERE city_id = '" . (int)$city_id . "'");

        foreach ($query->rows as $result) {
            $city_description_data[$result['language_id']] = array(
                'full'             => $result['full'],
                'city'             => $result['city'],
                'address_city'             => $result['address_city'],
                'address_city2'             => $result['address_city2'],
                'address_zip'             => $result['address_zip'],
                'address'             => $result['address'],
                'schedule'             => $result['schedule'],
            );
        }

        return $city_description_data;
    }



    public function install()
    {
        $sql  = "DROP TABLE IF EXISTS `" . DB_PREFIX . "cc_city`;";
        $this->db->query($sql);
        $sql  = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "cc_city` ( ";
        $sql .= "`city_id` integer(11) NOT NULL AUTO_INCREMENT, ";
        $sql .= "`main` TINYINT(1) NOT NULL DEFAULT '0', ";
        $sql .= "`phone` varchar(255), ";
        $sql .= "`sort` INT(11), ";
        $sql .= "`add_phone` varchar(255), ";
        $sql .= "`email` varchar(255), ";
        $sql .= "`add_email` varchar(255), ";
        $sql .= "`whatsapp` varchar(255), ";
        $sql .= "`telegram` varchar(255), ";
        $sql .= "`viber` varchar(255), ";
        $sql .= "`geo_lat` varchar(255), ";
        $sql .= "`geo_lon` varchar(255), ";
        $sql .= "`show_map` TINYINT(1) NOT NULL DEFAULT '0', ";
        $sql .= "PRIMARY KEY (`city_id`) ";
        $sql .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        $sql .= PHP_EOL;
        $this->db->query($sql);

        $sql  = "DROP TABLE IF EXISTS `" . DB_PREFIX . "cc_city_description`;";
        $this->db->query($sql);
        $sql  = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "cc_city_description` ( ";
        $sql .= "`city_id` integer(11) NOT NULL, ";
        $sql .= "`language_id` integer(11) NOT NULL, ";
        $sql .= "`full` varchar(255), ";
        $sql .= "`city` varchar(255), ";
        $sql .= "`address` varchar(255), ";
        $sql .= "`schedule` varchar(255) ";
        $sql .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8;";
        $sql .= PHP_EOL;
        $this->db->query($sql);

        $row = 1;
        $r = 0;

        if (($handle = fopen(dirname(dirname(dirname(dirname(dirname(__DIR__))))) . "/system/storage/city.csv", "r")) !== FALSE) {
            while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
                if (!$r) {
                    $r = 1;
                    continue;
                }
                $row++;

                $sql = "INSERT INTO `" . DB_PREFIX . "cc_city` (geo_lat,geo_lon) VALUES (\"" . $this->db->escape($data[20]) . "\",\"" . $this->db->escape($data[21]) . "\");" . PHP_EOL;

                try {
                    $this->db->query($sql);
                } catch (\Throable $e) {
                    var_dump($sql);
                    var_dump($e);
                }

                $city_id = $this->db->getLastId();

                if ($data[13] == "eb208b95-1f50-4290-a9c9-46909aea49a0")
                    $city = $this->db->escape($data[11]);
                else
                    $city = ($data[4] == 'г' ? $this->db->escape($data[5]) : $this->db->escape($data[9]));

                $sql = "INSERT INTO `" . DB_PREFIX . "cc_city_description` (city_id,language_id,full,city) VALUES ($city_id,1,\"" . $this->db->escape($data[0]) . "\",\"" . $this->db->escape($city) . "\")";

                try {
                    $this->db->query($sql);
                } catch (\Throwable $e) {
                    var_dump($sql);
                    var_dump($e);
                }

                $sql = "INSERT INTO `" . DB_PREFIX . "cc_city_description` (city_id,language_id,full,city) VALUES ($city_id,2,\"" . $this->db->escape($data[0]) . "\",\"" . $this->db->escape($city) . "\")";

                try {
                    $this->db->query($sql);
                } catch (\Throwable $e) {
                    var_dump($sql);
                    var_dump($e);
                }
            }
            fclose($handle);
        };
    }

    public function uninstall()
    {
        $sql  = "DROP TABLE `" . DB_PREFIX . "cc_city`;";
        $this->db->query($sql);
    }
}
