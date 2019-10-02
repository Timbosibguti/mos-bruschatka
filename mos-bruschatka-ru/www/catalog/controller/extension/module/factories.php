<?php
class ControllerExtensionModuleFactories extends Controller {
	public function index($setting) {

		static $module = 0;

		$this->load->language('extension/module/factories');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$this->load->model('catalog/manufacturer');

		$this->load->model('tool/image');

		$data['manufacturers'] = array();

		$m_filter_data = array(
			'sort'  => 'sort_order',
			'order' => 'ASC',
			'start' => 0,
			'limit' => 6
		);

		$m_results = $this->model_catalog_manufacturer->getManufacturers($m_filter_data);

		if($m_results) {
			foreach ($m_results as $m_result) {
				$data['manufacturers'][] = array(
					'manufacturer_id'  => $m_result['manufacturer_id'],
					'name'        => $m_result['name'],
					'description'        => $m_result['description'],
					'image' => $this->model_tool_image->resize($m_result['image'], 270, 80),
					'logo' => $this->model_tool_image->resize($m_result['logo'], 20, 20),
				);
			}
		}

		$data['module'] = $module++;


		if ($data['manufacturers']) {
			return $this->load->view('extension/module/factories', $data);
		}
	}
}
