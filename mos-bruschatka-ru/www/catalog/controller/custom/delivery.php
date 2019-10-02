<?php
class ControllerCustomDelivery extends Controller {
	public function index() {
		$this->load->language('custom/delivery');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('custom/delivery')
		);

		$data['heading_title'] = $this->language->get('heading_title');
		$data['placeholder_name'] = $this->language->get('placeholder_name');
		$data['placeholder_phone'] = $this->language->get('placeholder_phone');
        $data['placeholder_img'] = $this->language->get('placeholder_img');

		$data['map_contact'] = $this->load->controller('custom/components/map_contact');

		$data['privacy_info'] = $this->load->controller('common/privacy_info');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->load->model('setting/setting');
		$this->load->model('localisation/location');
		$store_id = $this->config->get('config_store_id');
		$store_info = $this->model_setting_setting->getSetting('config', $store_id);
		$locations_info = $this->model_localisation_location->getLocations();

        $locations = $this->assembleLocations($locations_info, $store_info['config_location'][0]);

		$data['store'] = array(
			'store_id'	=> $store_id,
			'locations'	=> $locations,
		);

		$this->response->setOutput($this->load->view('custom/delivery', $data));
	}

    /**
     * @param mixed $locationsInfo
     * @param string $locationId
     * @return array
     */
	private function assembleLocations($locationsInfo, $locationId)
    {
        $locations = [];

        foreach ($locationsInfo as $location) {
            $locations[] =
                [
                    'location_id'		=> $location['location_id'],
                    'name'				=> $location['name'],
                    'address'			=> $location['address'],
                    'phone'				=> $location['telephone'],
                    'open'				=> $location['open'],
                    'geocode'			=> $location['geocode'],
                    'image'				=> $location['image'],
                ];

            if ($location['location_id'] === $locationId) {
                array_unshift($locations, $location);
            }
        }

        return $locations;
    }
}
