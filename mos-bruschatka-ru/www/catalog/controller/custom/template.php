$this->load->model('setting/setting');
        $this->load->model('localisation/location');
        $store_id = $this->config->get('config_store_id');
        $store_info = $this->model_setting_setting->getSetting('config', $store_id);
        $location_info = $this->model_localisation_location->getLocation($store_info['config_location'][0]);

        if( strpos( $store_info['config_name'], 'ОПТ') !== false) {
			$version = 2;
			$title = $store_info['config_name'];
			$title = ltrim($title, 'Магазин');
			$title = rtrim($title, ' (ОПТ)');
			$title = $title . 'Брусчатка';
        } else {
			$version = 1;
			$title = ltrim($store_info['config_name'], 'Магазин') . 'Брусчатка';
        }

        $data['store'] = array(
            'name'		=> $store_info['config_name'],
            'title'		=> $title,
            'phone'		=> $location_info['telephone'],
            'email'		=> $store_info['config_email'],
            'opening'	=> $location_info['open'],
            'address'	=> $location_info['address'],
            'comments'	=> $location_info['comment'],
            'coords'	=> $location_info['geocode'],
            'version'   => $version,
        );