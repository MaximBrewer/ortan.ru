<?php
class ModelToolFiles extends Model
{
	public function getImportProductImages()
	{
		$query = $this->db->query("
		SELECT `p1`.`image` as image
		FROM oc_product p1");
		return $query->rows;
	}
	public function getImportProductImagesImages()
	{
		$query = $this->db->query("
		SELECT `pi`.`image` as image
		FROM oc_product_image pi
		LEFT JOIN oc_product p on p.product_id = pi.product_id");
		return $query->rows;
	}
}
