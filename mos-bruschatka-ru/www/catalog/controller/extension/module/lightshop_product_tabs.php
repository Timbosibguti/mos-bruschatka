<?php
class ControllerExtensionModuleLightShopProductTabs extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/featured');
		$this->load->language('product/product');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		$data['text_stock'] = $this->language->get('text_stock');

		$data['language_id'] = $this->config->get('config_language_id');
		
		if (isset($setting['view'])) {
			$data['view'] = $setting['view'];
		} else {
			$data['view'] = '';
		}
		
		if (isset($setting['tp_limit'])) {
			$data['tp_limit'] = $setting['tp_limit'];
		} else {
			$data['tp_limit'] = 3;
		}
		
		// labels
			$labelsInfo = array();
			if($this->config->get('theme_lightshop_label')){
				$labelsInfo = $this->config->get('theme_lightshop_label');
			}
			$data['labelsinfo'] = $labelsInfo ;
		// labels

		
		foreach($setting['theme_lightshop_product_tabs'] as $tab => $product_tab){			
			
				if (isset($dataTabs[$product_tab['sort']])) {
					$dataTabs[] = $product_tab; 
				}else{
					$dataTabs[$product_tab['sort']] = $product_tab;
				}
		}	
		ksort($dataTabs);
		
		$data['product_tabs'] = $dataTabs;
		
		foreach($setting['theme_lightshop_product_tabs'] as $tab => $product_tab){
			$tabProducts = $this->getProducts($product_tab);
				if (isset($data['products'][$product_tab['sort']])) {
					$data['products'][] = $tabProducts; 
				}else{
					$data['products'][$product_tab['sort']] = $tabProducts;
				}
		}
	

		if ($data['products']) {
			if(isset($setting['layout']) && strpos($setting['layout'],'column_') !== false){
				return $this->load->view('extension/module/lightshop_product_tabs_column', $data);
			}else{
				return $this->load->view('extension/module/lightshop_product_tabs', $data);
			}
		}
	}

	public function getProducts($setting) {

			$this->load->model('catalog/product');
			$this->load->model('tool/image');

			$data['products'] = array();

			if (!$setting['limit']) {
				$limit = 4;
			}else{
				$limit = $setting['limit'];
			}
			$results = array();
			if($setting['target'] == 0 || $setting['target'] == 2 ){ //Вывести все продукты
				$page = 1;
				$order = 'ASC';
				$filter_category_ids = false;
				if($setting['sortorder'] == 'discount' || $setting['sortorder'] == 'p.viewed' || $setting['sortorder'] == 'p.date_added'){
					$order = 'DESC';
				}
				if($setting['target'] == '2'){					
					if(isset($setting['categories'])){
						$filter_category_ids = $setting['categories'];						
					}else{
						$filter_category_ids = array('-1');
					}						
				}				
				$filter_data = array(
					'filter_category_ids' => $filter_category_ids,
					'sort'               => $setting['sortorder'],
					'order'              => $order,
					'start'              => ($page - 1) * $limit,
					'limit'              => $limit
				);
				if($setting['sortorder'] == 'bestseller'){
					$results = $this->model_catalog_product->getBestSellerProducts($limit);
				}else{
					$results = $this->model_catalog_product->getProducts($filter_data);
				}
				 
			}elseif($setting['target'] == '1' && isset($setting['products'])){ //Вывести только указанные продукты.
					foreach($setting['products'] as $product_id){
						$results[] = $this->model_catalog_product->getProduct($product_id);
					}

			}elseif($setting['target'] == '3'){ //Вывести просмотренные.
				$cookies = array();
				if(isset($_COOKIE["productsVieded"])){
					$i = 0;
					foreach($_COOKIE["productsVieded"] as $product_id => $val){
						$cookies[$val] = $product_id;
					}
					krsort($cookies);
					
					foreach($cookies as $product_id){
						$prodInfo = $this->model_catalog_product->getProduct($product_id);
						if(!$prodInfo || $i >= $limit){ continue;}
						$results[] = $prodInfo;
						$i++;
					}
				}
			}

		// labels
			$labelsInfo = array();
			if($this->config->get('theme_lightshop_label')){
				$labelsInfo = $this->config->get('theme_lightshop_label');
			}

			$newest = array();
			$sales = false;
			if(isset($labelsInfo['new']['period']) && $labelsInfo['new']['status']){
				$newest = $this->model_catalog_product->getNewestProducts($labelsInfo['new']['period']);			
			}
			if(isset($labelsInfo['sale']['status']) && $labelsInfo['sale']['status']){
				$sales = true;				
			}			
		// labels



			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->lightshop_resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));// lightshop
				} else {
					$image = $this->model_tool_image->lightshop_resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));// lightshop
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($product_info['quantity'] <= 0) {
					$data['stock'] = $product_info['stock_status'];
				} elseif ($this->config->get('config_stock_display')) {
					$data['stock'] = $product_info['quantity'];
				} else {
					$data['stock'] = $this->language->get('text_instock');
				}

				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}
				
		// labels
				if (in_array($result['product_id'], $newest)) {
					$isNewest = true;
				} else {
					$isNewest = false;
				}
				
				$discount = '';	
				if($sales && $special){
					if($labelsInfo['sale']['extra'] == 1){
						$discount = round((($result['price'] - $result['special'])/$result['price'])*100);
						$discount = $discount. ' %';
					}
					if($labelsInfo['sale']['extra'] == 2){
						$discount = $this->currency->format($this->tax->calculate(($result['price'] - $result['special']), $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					}					
				}							
		// labels				

				if($setting['target'] == 0 && $setting['sortorder'] == 'discount' && !$special){ continue;} //Фильтр - добавлять только акционные товары
					
				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'quantity'       => $result['quantity'],
					'price'       => $price,
					'special'     => $special,
					'isnewest'       => $isNewest,
					'sales'       => $sales,
					'stock'       => $result['stock'],
					'discount'       => $discount,
					'tax'         => $tax,
					'minimum'     => ($result['minimum'] > 0) ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', '&product_id=' . $result['product_id'] )
				);
			}
			
		return $data['products'];
	}
}
