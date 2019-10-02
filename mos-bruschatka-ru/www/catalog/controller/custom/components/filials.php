<?php
class ControllerCustomComponentsFilials extends Controller {
	public function index() {
		$this->load->model('tool/image');
		$this->load->model('localisation/location');
		$this->load->model('setting/store');
		$store_info = $this->model_setting_store->getStores();
		$locations_info = $this->model_localisation_location->getLocations();

		$data['locations'] = array();

		foreach($locations_info as $location) {
			$data['locations'][] = array(
				'location_id'		=> $location['location_id'],
				'name'				=> $location['name'],
				'address'			=> $location['address'],
				'phone'				=> $location['telephone'],
				'open'				=> $location['open'],
				'geocode'			=> $location['geocode'],
				'image'				=> $this->model_tool_image->resize($location['image'], 150, 150)
			);

			$coords[] = [$location['geocode']];
		}

		return $this->load->view('custom/components/filials', $data);
	}
}