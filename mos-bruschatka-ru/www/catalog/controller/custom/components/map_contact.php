<?php
class ControllerCustomComponentsMapContact extends Controller {
	public function index() {
		$this->load->model('setting/setting');
		$this->load->model('localisation/location');
		$store_id = $this->config->get('config_store_id');
		$store_info = $this->model_setting_setting->getSetting('config', $store_id);

		$data['store'] = array(
			'store_id'	=> $store_id,
			'name'		=> $store_info['config_name'],
			'phone'		=> $store_info['config_telephone'],
			'email'		=> $store_info['config_email'],
			'opening'	=> $store_info['config_langdata']['1']['open'],
			'address'	=> $store_info['config_langdata']['1']['address'],
			'comments'	=> isset($store_info['config_comment']) ? $store_info['config_comment'] : '',
			'coords'	=> $store_info['config_geocode']
		);

		$data['contact_link'] = $this->url->link('information/contact');

		return $this->load->view('custom/components/map_contact', $data);
	}
}
