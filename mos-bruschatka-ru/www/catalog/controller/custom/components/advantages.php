<?php
class ControllerCustomComponentsAdvantages extends Controller {
	public function index() {
		$data['placeholder_name'] = $this->language->get('placeholder_name');
		$data['placeholder_phone'] = $this->language->get('placeholder_phone');
		$data['placeholder_email'] = $this->language->get('placeholder_email');
		$data['placeholder_img'] = $this->language->get('placeholder_img');

		$this->load->model('setting/setting');
		$this->load->model('localisation/location');
		$store_id = $this->config->get('config_store_id');
		$store_info = $this->model_setting_setting->getSetting('config', $store_id);
		$location_info = $this->model_localisation_location->getLocation($store_info['config_location'][0]);
		
		if( strpos( $store_info['config_name'], 'ОПТ') !== false) {
			$version = 2;
		} else {
			$version = 1;
		}

		$data['store'] = array(
			'name'		=> $store_info['config_name'],
			'phone'		=> $location_info['telephone'],
			'email'		=> $store_info['config_email'],
			'opening'	=> $location_info['open'],
			'address'	=> $location_info['address'],
			'comments'	=> $location_info['comment'],
			'coords'	=> $location_info['geocode'],
			'version'   => $version,
		);
		
		return $this->load->view('custom/components/advantages', $data);
	}
}