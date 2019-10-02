<?php
class ControllerCustomComponentsCalculator extends Controller {
	public function index() {
		$this->load->language('extension/module/calculator');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$data['placeholder_name'] = $this->language->get('placeholder_name');
		$data['placeholder_phone'] = $this->language->get('placeholder_phone');
		$data['placeholder_email'] = $this->language->get('placeholder_email');
		$data['placeholder_img'] = $this->language->get('placeholder_img');

		$data['privacy_info'] = $this->load->controller('common/privacy_info');

		$products = [
			[
				'name'	=> 'Волна',
				'image' => 'catalog/items/nobetek/zigzag/zigzag.jpg',
				'patterns' => ['volnaPattern1', 'volnaPattern2', 'volnaPattern3', 'volnaPattern4'],
			],
			[
				'name' => 'Квадрат',
                'image' => 'catalog/items/nobetek/1K5f/0.png',
				'patterns' => ['kvadratPattern1', 'kvadratPattern2', 'kvadratPattern3'],
			],
			[
				'name' => 'Газонный камень',
                'image' => 'catalog/items/nobetek/1RD10/0.png',
				'patterns' => ['gkamenPattern1'],
			],
			[
				'name' => 'Брусчатка',
                'image' => 'catalog/items/nobetek/2P8f/2p8f.jpg',
				'patterns' => ['brusPattern1', 'brusPattern2', 'brusPattern3', 'brusPattern4'],
			],
			[
				'name' => 'Старый город',
                'image' => 'catalog/items/1SG5f/0.png',
				'patterns' => ['oldPattern1', 'oldPattern2'],
			],
			[
				'name' => 'Классика',
                'image' => 'catalog/items/nobetek/1KL6f/0.png',
				'patterns' => ['classicPattern1', 'classicPattern2', 'classicPattern3'],
			],
        ];

		foreach ($products as $product) {
            $product_patterns = [];

            if($product['patterns']) {
                foreach($product['patterns'] as $pattern) {
                    $pattern_img = 'catalog/calculator/patterns/' . $pattern . '.png';
                    $product_patterns[] = [
                        'name'	=> $pattern,
                        'thumb'	=> $this->model_tool_image->getImage($pattern_img),
                    ];
                }
            }

            $data['products'][] = [
                'thumb'						=> $this->model_tool_image->getImage($product['image']),
                'name'						=> $product['name'],
                'patterns'					=> $product_patterns,
            ];
		}

		$data['colors'] = [
			'Серый' => '7b7370',
			'Песочный' => 'cebbaa',
			'Красно-коричневый' => '725452',
			'Черный' => '4e4e50',
			'Красный' => '835d5c',
			'Коричневый' => '62504e',
			'Бежевый' => 'a28c81',
			'Зеленый' => '7e8772',
			'Синий' => '6f8087',
			'Персиковый' => 'a16c4c',
			'Желтый' => 'a59559',
		];
		
		$data['dimensions'] = [
			'dimension1' => 'до 10 м2',
			'dimension2' => '10-20 м2',
			'dimension3' => '20-30 м2',
			'dimension4' => '30-50 м2',
			'dimension5' => '50-100 м2',
			'dimension6' => 'более 100 м2'
        ];

		return $this->load->view('custom/components/calculator', $data);
	}
}
