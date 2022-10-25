<?php
class ModelCatalogSortType extends Model {
    public function getSorts() {
        $query = $this->db->query("SELECT st.sort_id, st.value, st.href, st.text FROM " . DB_PREFIX . "sort_type st ORDER BY st.sort_order");
        return $query->rows;
    }
}