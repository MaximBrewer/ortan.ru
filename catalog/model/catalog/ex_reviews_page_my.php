<?php
/*
 * @ https://EasyToYou.eu - IonCube v10 Decoder Online
 * @ PHP 7.2
 * @ Decoder version: 1.0.4
 * @ Release: 01/09/2021
 */

include(DIR_APPLICATION . 'model/catalog/ex_reviews_page.php');

class ModelCatalogExReviewsPageMy extends ModelCatalogExReviewsPage
{
    public function validateLocalKey()
    {
        $this->status = true;
    }

    public function getReviews($data)
    {
        if (isset($data["filter_rating"]) && $data["filter_rating"]) {
            $sql = "SELECT DISTINCT * FROM ((SELECT DISTINCT r.*, pd.name, p.image  FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) ";

            if ($data["start"] < 0) {
                $start = 0;
            } else {
                $start = $data["start"];
            }
            if ($data["limit"] < 1) {
                $limit = 20;
            } else {
                $limit = $data["limit"];
            }
            if (isset($data["order"])) {
                $order = $this->db->escape($data["order"]);
            } else {
                $order = "date_added DESC";
            }
            $sql .= " WHERE r.rating in (" . $data["filter_rating"] . "))) srs ORDER BY $order LIMIT $start ,$limit";
            $query = $this->db->query($sql);
            return $query->rows;
        } else {
            return parent::getReviews($data);
        }
    }

    public function getTotalReviews($data)
    {
        if (isset($data["filter_rating"]) && $data["filter_rating"]) {
            $sql = "SELECT COUNT(*) AS total FROM ((SELECT DISTINCT r.*, pd.name, p.image  FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE r.status = 1 AND r.rating in (" . $data["filter_rating"] . "))) srs";
        } else {
            $sql = "SELECT COUNT(*) AS total FROM ((SELECT DISTINCT r.*, pd.name, p.image  FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE r.status = 1)) srs";
        }
        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    public function getPercent()
    {
        $sql = "SELECT  AVG(rating) AS average FROM " . DB_PREFIX . "review r";
        $query = $this->db->query($sql);
        return $query->row['average'];
    }
}
