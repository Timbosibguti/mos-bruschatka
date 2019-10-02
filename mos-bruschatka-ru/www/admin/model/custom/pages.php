<?php
class ModelCustomPages extends Model {
	public function addPage($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "custom_page SET sort_order = '" . (int)$data['sort_order'] . "', bottom = '" . (isset($data['bottom']) ? (int)$data['bottom'] : 0) . "', status = '" . (int)$data['status'] . "'");

		$custom_page_id = $this->db->getLastId();

		foreach ($data['custom_page_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "custom_page_description SET custom_page_id = '" . (int)$custom_page_id . "', language_id = '" . (int)$language_id . "', query = '" . $this->db->escape($data['query']) . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
		}

		if (isset($data['custom_page_store'])) {
			foreach ($data['custom_page_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "custom_page_to_store SET custom_page_id = '" . (int)$custom_page_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['custom_page_layout'])) {
			foreach ($data['custom_page_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "custom_page_to_layout SET custom_page_id = '" . (int)$custom_page_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		if (isset($data['query']) && isset($data['keyword'])) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = '" . $this->db->escape($data['query']) . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}

		$this->cache->delete('custom_page');

		return $custom_page_id;
	}

	public function editPage($custom_page_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "custom_page SET sort_order = '" . (int)$data['sort_order'] . "', bottom = '" . (isset($data['bottom']) ? (int)$data['bottom'] : 0) . "', status = '" . (int)$data['status'] . "' WHERE custom_page_id = '" . (int)$custom_page_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "custom_page_description WHERE custom_page_id = '" . (int)$custom_page_id . "'");

		foreach ($data['custom_page_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "custom_page_description SET custom_page_id = '" . (int)$custom_page_id . "', query = '" . $this->db->escape($data['query']) . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_h1 = '" . $this->db->escape($value['meta_h1']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "custom_page_to_store WHERE custom_page_id = '" . (int)$custom_page_id . "'");

		if (isset($data['custom_page_store'])) {
			foreach ($data['custom_page_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "custom_page_to_store SET custom_page_id = '" . (int)$custom_page_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "custom_page_to_layout WHERE custom_page_id = '" . (int)$custom_page_id . "'");

		if (isset($data['custom_page_layout'])) {
			foreach ($data['custom_page_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "custom_page_to_layout SET custom_page_id = '" . (int)$custom_page_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = '" . $this->db->escape($data['query']) . "'");

		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = '" . $this->db->escape($data['query']) . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}

		$this->cache->delete('custom_page');
	}

	public function deletePage($custom_page_id, $query) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "custom_page WHERE custom_page_id = '" . (int)$custom_page_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "custom_page_description WHERE custom_page_id = '" . (int)$custom_page_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "custom_page_to_store WHERE custom_page_id = '" . (int)$custom_page_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "custom_page_to_layout WHERE custom_page_id = '" . (int)$custom_page_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = '" . $query . "'");

		$this->cache->delete('custom_page');
	}

	public function getPage($custom_page_id, $query) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = '" . $query . "' LIMIT 1) AS keyword FROM " . DB_PREFIX . "custom_page WHERE custom_page_id = '" . (int)$custom_page_id . "'");

		return $query->row;
	}

	public function getPages($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "custom_page i LEFT JOIN " . DB_PREFIX . "custom_page_description id ON (i.custom_page_id = id.custom_page_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";

			$sort_data = array(
				'id.title',
				'i.sort_order'
			);

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];
			} else {
				$sql .= " ORDER BY id.title";
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
		} else {
			$custom_page_data = $this->cache->get('custom_page.' . (int)$this->config->get('config_language_id'));

			if (!$custom_page_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "custom_page i LEFT JOIN " . DB_PREFIX . "custom_page_description id ON (i.custom_page_id = id.custom_page_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY id.title");

				$custom_page_data = $query->rows;

				$this->cache->set('custom_page.' . (int)$this->config->get('config_language_id'), $custom_page_data);
			}

			return $custom_page_data;
		}
	}

	public function getPageDescriptions($custom_page_id) {
		$custom_page_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "custom_page_description WHERE custom_page_id = '" . (int)$custom_page_id . "'");

		foreach ($query->rows as $result) {
			$custom_page_description_data[$result['language_id']] = array(
				'query'			   => $result['query'],
				'title'            => $result['title'],
				'description'      => $result['description'],
				'meta_title'       => $result['meta_title'],
				'meta_h1'          => $result['meta_h1'],
				'meta_description' => $result['meta_description'],
				'meta_keyword'     => $result['meta_keyword']
			);
		}

		return $custom_page_description_data;
	}

	public function getPageStores($custom_page_id) {
		$custom_page_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "custom_page_to_store WHERE custom_page_id = '" . (int)$custom_page_id . "'");

		foreach ($query->rows as $result) {
			$custom_page_store_data[] = $result['store_id'];
		}

		return $custom_page_store_data;
	}

	public function getPageLayouts($custom_page_id) {
		$custom_page_layout_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "custom_page_to_layout WHERE custom_page_id = '" . (int)$custom_page_id . "'");

		foreach ($query->rows as $result) {
			$custom_page_layout_data[$result['store_id']] = $result['layout_id'];
		}

		return $custom_page_layout_data;
	}

	public function getTotalPages() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "custom_page");

		return $query->row['total'];
	}

	public function getTotalPagesByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "custom_page_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
}