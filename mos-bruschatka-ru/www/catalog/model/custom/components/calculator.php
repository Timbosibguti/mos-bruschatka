<?php
class ModelCustomComponentsCalculator extends Model {
	private function updateRoPrice() {
		$this->load->model('catalog/product');

		$allprod = $this->model_catalog_product->getProducts();
		$data['newprod'] = array();

		if($allprod) {
			foreach($allprod as $prod) {
				if($prod['product_id']) {
					$ro = $this->model_catalog_product->get_RO_price($prod['product_id']);
					$new_ro = array();

					foreach($ro as $o) {
						if($prod['price'] < $o['price'] && $o['price_prefix'] !== '+') {
							$new_ro = array(
								'relatedoptions_id'	=> $o['relatedoptions_id'],
								'price_prefix'		=> '+',
								'price'	=> ($o['price'] - $prod['price'])
							);

							$status = $this->model_catalog_product->update_RO_price($new_ro);
						}
					}

					$data['newprod'] = array(
						'id'	=> $prod['product_id'],
						'new_ro'	=> $new_ro[0],
						'status'	=> $status
					);
				}
			}
		}
	}

	private function updateRoSpecial() {
		$this->load->model('catalog/product');

		$allprod = $this->model_catalog_product->getProducts();
		$data['newprod'] = array();

		if($allprod) {
			foreach($allprod as $prod) {
				if($prod['product_id']) {
					$ro = $this->model_catalog_product->get_RO_price($prod['product_id']);
					$new_ro = array();

					foreach($ro as $o) {
						if($prod['price'] < $o['price'] && $o['price_prefix'] !== '+') {
							$new_ro = array(
								'relatedoptions_id'	=> $o['relatedoptions_id'],
								'price_prefix'		=> '+',
								'price'	=> ($o['price']*1.05)
							);

							$status = $this->model_catalog_product->update_RO_price($new_ro);
						}
					}

					$data['newprod'] = array(
						'id'	=> $prod['product_id'],
						'new_ro'	=> $new_ro[0],
						'status'	=> $status
					);
				}
			}
		}
	}

	public function get_RO_price($product_id) {
		$query = $this->db->query("SELECT relatedoptions_id, price_prefix, price FROM " . DB_PREFIX . "relatedoptions WHERE relatedoptions_id IN (SELECT relatedoptions_id FROM " . DB_PREFIX . "relatedoptions WHERE product_id=" . $product_id . ");");

		return $query->rows;
	}

	public function update_RO_price($data = array()) {
		$this->db->query("UPDATE " . DB_PREFIX . "relatedoptions SET price = '" . $data['price'] . "', price_prefix = '" . $data['price_prefix'] . "' WHERE relatedoptions_id = '" . (int)$data['relatedoptions_id'] . "';");

		return 'success';
	}
}
