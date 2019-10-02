<?php
class ModelCatalogFilter extends Model {
    public function getFiltersByFilterGroupId($id) {
        $query = $this->db->query('SELECT * FROM ' . DB_PREFIX . 'filter f LEFT JOIN ' . DB_PREFIX . 'filter_group_description fgd ON (f.filter_group_id = fgd.filter_group_id) WHERE f.filter_group_id="' . (int)$id . '" AND fgd.language_id="' . (int)$this->config->get('config_language_id') . '";');

        return $query->rows;
    }

    public function getFilterDescription($id) {
        $query = $this->db->query('SELECT * FROM ' . DB_PREFIX . 'filter_description fd LEFT JOIN ' . DB_PREFIX . 'filter f ON (fd.filter_id = f.filter_id) WHERE fd.filter_id = "' . (int)$id . '" AND fd.language_id = "' . (int)$this->config->get('config_language_id') . '";');

        return $query->row;
    }
}