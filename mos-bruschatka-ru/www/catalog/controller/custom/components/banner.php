<?php
class ControllerCustomComponentsBanner extends Controller {
	public function index() {
		$this->load->model('tool/image');
		$this->load->model('setting/setting');
        $this->load->model('localisation/location');
        $store_id = $this->config->get('config_store_id');
        $store_configs = $this->model_setting_setting->getSetting('config', $store_id);
		$location_info = $this->model_localisation_location->getLocation($store_configs['config_location'][0]);
		
		$shopCode = ltrim($store_configs['config_icon'], 'catalog/favicon/');

        if( strpos( $store_configs['config_name'], 'ОПТ') !== false) {
			$version = 2;
			$title = $store_configs['config_name'];
			$title = ltrim($title, 'Магазин');
			$title = rtrim($title, ' (ОПТ)');
			$title = $title . 'Брусчатка';
        } else {
			$version = 1;
			$title = ltrim($store_configs['config_name'], 'Магазин') . 'Брусчатка';
		}
		
		$image = 'catalog/banners/banner-grass-' . $shopCode;
		$thumb = $this->model_tool_image->getImage($image);

        $data['store'] = array(
            'name'		=> $store_configs['config_name'],
            'title'		=> $title,
            'phone'		=> $location_info['telephone'],
            'email'		=> $store_configs['config_email'],
            'opening'	=> $location_info['open'],
            'address'	=> $location_info['address'],
            'comments'	=> $location_info['comment'],
            'coords'	=> $location_info['geocode'],
			'version'   => $version,
			'thumb'		=> $thumb
		);
		
		return $this->load->view('custom/components/banner');
	}
}