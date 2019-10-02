<?php
class ControllerCustomFilials extends Controller {
	public function index() {
		$this->load->language('custom/filials');

		$this->load->model('setting/setting');
		$this->load->model('setting/store');
		$this->load->model('localisation/location');

		$store_id = $this->config->get('config_store_id');
		$store_info = $this->model_setting_setting->getSetting('config', $store_id);
		$locations_info = $this->model_localisation_location->getLocations();

		$locations = array();
		$coords = array();

		$locations[0] = array(
			'name'				=> $locations_info[$store_info['config_location'][0]]['name'],
			'address'			=> $store_info['config_address'],
			'phone'				=> $store_info['config_telephone'],
			'open'				=> $store_info['config_langdata']['1']['open'],
			'geocode'			=> $store_info['config_geocode'],
			'image'				=> $store_info['config_image'],
		);

		foreach($locations_info as $location) {
			$locations[] = array(
				'location_id'		=> $location['location_id'],
				'name'				=> $location['name'],
				'address'			=> $location['address'],
				'phone'				=> $location['telephone'],
				'open'				=> $location['open'],
				'geocode'			=> $location['geocode'],
				'image'				=> $location['image'],
			);

			$coords[] = [$location['geocode']];
		}

		$data['store'] = array(
			'store_id'	=> $store_id,
			'locations'	=> $locations,
			'coords'	=> $coords
		);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('custom/filials', $data));
	}
}
