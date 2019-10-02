<?php
class ModelCatalogCalculator extends Model {
	public function getcalculator($calculator_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "calculator i LEFT JOIN " . DB_PREFIX . "calculator_description id ON (i.calculator_id = id.calculator_id) LEFT JOIN " . DB_PREFIX . "calculator_to_store i2s ON (i.calculator_id = i2s.calculator_id) WHERE i.calculator_id = '" . (int)$calculator_id . "' AND id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1'");

		return $query->row;
	}

	public function getcalculators() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "calculator i LEFT JOIN " . DB_PREFIX . "calculator_description id ON (i.calculator_id = id.calculator_id) LEFT JOIN " . DB_PREFIX . "calculator_to_store i2s ON (i.calculator_id = i2s.calculator_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' ORDER BY i.sort_order, LCASE(id.title) ASC");

		return $query->rows;
	}

	public function getcalculatorLayoutId($calculator_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "calculator_to_layout WHERE calculator_id = '" . (int)$calculator_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");

		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return 0;
		}
	}
}
