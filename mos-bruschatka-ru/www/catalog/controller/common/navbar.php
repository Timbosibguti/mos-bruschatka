<?php
class ControllerCommonNavbar extends Controller {
	public function index() {
		$this->load->model('setting/setting');
		$this->load->model('localisation/location');
		$store_id = $this->config->get('config_store_id');
		$store_info = $this->model_setting_setting->getSetting('config', $store_id);
		$location_info = $this->model_localisation_location->getLocation($store_info['config_location'][0]);

		$index = 0;
		
		if( strpos( $store_info['config_name'], 'ОПТ') !== false) {
			$version = 2;
			$menuLinks = array(
				$index++	=> array(
					'name'		=> 'Популярные модели',
					'icon'		=> 'icon-stars',
					'href'		=> '#hits'
				),
				$index++	=> array(
					'name'		=> 'Преимущества',
					'icon'		=> 'icon-thumbs-up',
					'href'		=> '#advantages',
				),
				$index++	=> array(
					'name'		=> 'Партернство',
					'icon'		=> 'icon-hands',
					'href'		=> '#certification',
				),
				$index++	=> array(
					'name'		=> 'О нас',
					'icon'		=> 'icon-information',
					'href'		=> '#about',
				),
				$index++	=> array(
					'name'		=> 'Проекты',
					'icon'		=> 'icon-house',
					'href'		=> '#projects',
				)
			);
		} else {
			$version = 1;
			$menuLinks = array(
				$index++	=> array(
					'name'		=> 'Каталог',
					'icon'		=> 'icon-list',
					'href'		=> $this->url->link('product/category', 'path=98'),
					'childrens'	=> array(
						'0'		=> array(
							'name'	=> 'Тротуарная плитка',
							'icon'	=> 'icon-troturnaya',
							'href'		=> $this->url->link('product/category', 'path=98')
						),
						'1'		=> array(
							'name'	=> 'Брусчатка',
							'icon'	=> 'icon-bruschatka',
							'href'		=> $this->url->link('product/category', 'path=95')
						),
						'2'		=> array(
							'name'	=> 'Бордюрный камень',
							'icon'	=> 'icon-bordyur',
							'href'		=> $this->url->link('product/category', 'path=97')
						),
						'3'		=> array(
							'name'	=> 'Колор Микс',
							'icon'	=> 'icon-kolor-miks',
							'href'		=> $this->url->link('product/category', 'path=96')
						),
						'4'		=> array(
							'name'	=> 'Лоток дождевой',
							'icon'	=> 'icon-lotok-dojd',
							'href'		=> $this->url->link('product/category', 'path=99')
						),
					)
				),
				$index++	=> array(
					'name'		=> 'Проекты',
					'icon'		=> 'icon-house',
					'href'		=> '/projects',
				),
				$index++	=> array(
					'name'		=> 'Укладка',
					'icon'		=> 'icon-worker',
					'href'		=> $this->url->link('custom/ukladka'),
				),
				$index++	=> array(
					'name'		=> 'Доставка',
					'icon'		=> 'icon-truck',
					'href'		=> $this->url->link('custom/delivery'),
				),
				$index++	=> array(
					'name'		=> 'О компании',
					'icon'		=> 'icon-information',
					'href'		=> $this->url->link('custom/about_us'),
					'childrens'	=> array(
						'0'		=> array(
							'name'		=> 'О нас',
							'icon'		=> 'icon-information',
							'href'		=> $this->url->link('custom/about_us'),
						),
						'1'		=> array(
							'name'	=> 'Реквизиты',
							'icon'	=> 'icon-contract',
							'href'		=> $this->url->link('custom/requisites')
						),
						'3'		=> array(
							'name'	=> 'Контакты',
							'icon'	=> 'icon-contact1',
							'href'		=> $this->url->link('information/contact')
						),
					)
				)
			);
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
			'menuLinks'		=> $menuLinks
		);

		return $this->load->view('common/navbar', $data);
	}
}
