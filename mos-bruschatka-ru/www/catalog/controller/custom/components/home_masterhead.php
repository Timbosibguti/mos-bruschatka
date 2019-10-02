<?php
class ControllerCustomComponentsHomeMasterhead extends Controller {
	public function index() {
		$this->load->model('setting/setting');
		$this->load->model('localisation/location');
		$this->load->model('tool/image');
		$store_id = $this->config->get('config_store_id');
		$store_info = $this->model_setting_setting->getSetting('config', $store_id);
		$location_info = $this->model_localisation_location->getLocation($store_info['config_location'][0]);
		
		if( strpos( $store_info['config_name'], 'ОПТ') !== false) {
			$version = 2;
			$background = 'catalog/banners/5.jpg';
			$sub_title = 'Предсезонная распродажа';
			$title = 'ТРОТУАРНОЙ ПЛИТКИ ОПТОМ';
			$shop_name = ltrim($store_info['config_name'], 'Магазин');
			$shop_name = rtrim($shop_name, '(ОПТ)');
			$shop_name = $shop_name;
			$descr = array('<span class="text--yellow">11 тыс.</span> тонн плитки на складе', 'Мин. объем от <span class="text--yellow">30 м2</span>', 'Скидки до <span class="text--yellow">30%</span>', 'От <span class="text--yellow">83</span> рублей', '<span class="text--yellow">Отсрочка</span> платежа', 'Отгрузка с <span class="text--yellow">15 складов</span> ' . $shop_name);
			$button_text = 'скачать прайс-лист';
			$button_target = '#modalDownloadCatalog';
		} else {
			$version = 1;
			
			if($store_id == 3) {
				$background = 'catalog/banners/kras-1.jpg';
			} else if($store_id == 4) {
				$background = 'catalog/banners/ros-1.jpg';
			} else {
				$background = 'catalog/banners/mos-1.jpg';
			}

			$sub_title = 'Нужна тротуарная плитка ?';
			$title = 'Гипермаркет тротуарной плитки';
			$descr = array('Цена <span class="text--yellow">от завода</span>', '<span class="text--yellow">2500</span> моделей в наличии', 'Гарантии от <span class="text--yellow">50 лет</span>', 'Укладка и доставка');
			$button_text = 'Рассчитать стоимость';
			$button_target = '#calculator';
		}

		$thumb = $this->model_tool_image->getImage($background);

		$data['store'] = array(
			'name'		=> $store_info['config_name'],
			'phone'		=> $location_info['telephone'],
			'email'		=> $store_info['config_email'],
			'opening'	=> $location_info['open'],
			'address'	=> $location_info['address'],
			'comments'	=> $location_info['comment'],
			'coords'	=> $location_info['geocode'],
			'version'   => $version,
			'thumb'		=> $thumb,
			'sub_title'	=> $sub_title,
			'title'		=> $title,
			'descr'		=> $descr,
			'button_text'	=> $button_text,
			'button_target'	=> $button_target
		);
		
		return $this->load->view('custom/components/home_masterhead', $data);
	}
}