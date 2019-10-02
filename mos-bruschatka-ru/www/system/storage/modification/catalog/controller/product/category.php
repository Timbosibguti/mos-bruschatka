<?php
class ControllerProductCategory extends Controller {
    const COLOR_OPTION_NAME = 'Цвет';

	public function index() {
		$this->load->language('product/category');

		$this->load->model('catalog/category');

		$this->load->model('catalog/manufacturer');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$this->load->model('setting/setting');
            

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}


//lightshop start
		if (isset($this->session->data['change_currency'])) {
			unset($this->session->data['change_currency']);
			unset($this->request->get['min_price']);
			unset($this->request->get['max_price']);
		}

		if (isset($this->request->get['min_price'])) {
			$min_price = $this->request->get['min_price'];
		} else {
			$min_price = '';
		}

		if (isset($this->request->get['max_price'])) {
			$max_price = $this->request->get['max_price'];
		} else {
			$max_price = '';
		}
//lightshop stop
            
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int)$this->request->get['limit'];
		} else {
			$limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
		}


		// OCFilter start
    if (isset($this->request->get['filter_ocfilter'])) {
      $filter_ocfilter = $this->request->get['filter_ocfilter'];
    } else {
      $filter_ocfilter = '';
    }
		// OCFilter end
      
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['path'])) {
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

//lightshop start
			if (isset($this->request->get['min_price'])) {
				$url .= '&min_price=' . $this->request->get['min_price'];
			} 

			if (isset($this->request->get['max_price'])) {
				$url .= '&max_price=' . $this->request->get['max_price'];
			} 
			$cat_url = '';
//lightshop stop
            

			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			$id = 0;
            

			if($parts) {
				$parentCategory_id = $parts[0];
			} else {
				$parentCategory_id = $this->request->get['path'];
			}

			$data['subCategories'] = array();

			$results = $this->model_catalog_category->getCategories($parentCategory_id) ?: $this->model_catalog_category->getCategories();

			foreach ($results as $result) {
				$filter_data = array(
					'filter_category_id'  => $result['category_id'],
					'filter_sub_category' => true
				);

				$data['subCategories'][] = array(
					'name' => $result['name'],
					'total_products'	=> $this->model_catalog_product->getTotalProducts($filter_data),
					'href' => $this->url->link('product/category', 'path=' . $parentCategory_id . '_' . $result['category_id'] . $url)
				);
			}

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],

						'breadList' => $this->breadList($id),// lightshop
						'cat_id' => $id,// lightshop
            
						
						'href' => $this->url->link('product/category', 'path=' . $path )
            
					);
				}

				$id = $path_id;
            
			}

//lightshop start
			$cat_url = $this->url->link('product/category', 'path=' . $path . '_' . $category_id);
//lightshop stop
            
		} else {
			$category_id = 0;
		}

		$category_info = $this->model_catalog_category->getCategory($category_id);

		if ($category_info) {

			if ($category_info['meta_title']) {
				$this->document->setTitle($category_info['meta_title']);
			} else {
				$this->document->setTitle($category_info['name']);
			}

			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);

			if ($category_info['meta_h1']) {
				$data['heading_title'] = $category_info['meta_h1'];
			}

			$data['text_refine'] = $this->language->get('text_refine');
			$data['text_empty'] = $this->language->get('text_empty');
			$data['text_quantity'] = $this->language->get('text_quantity');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_price'] = $this->language->get('text_price');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['text_sort'] = $this->language->get('text_sort');
			$data['text_limit'] = $this->language->get('text_limit');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_view'] = $this->language->get('button_view');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list'] = $this->language->get('button_list');
			$data['button_grid'] = $this->language->get('button_grid');

			// lightshop
			$this->load->language('extension/theme/lightshop');
			$data['schema'] = $this->config->get('theme_lightshop_schema');
			$data['product_detail'] = $this->config->get('theme_lightshop_product_detail');
			$data['category_background'] = $this->config->get('theme_lightshop_category_background');
			$data['category_sorts'] = $this->config->get('theme_lightshop_category_sorts');
			$data['category_limits'] = $this->config->get('theme_lightshop_category_limits');
			$data['category_categories'] = $this->config->get('theme_lightshop_category_categories');
			$data['catalog_type'] = $this->config->get('theme_lightshop_catalog_type');
			
			$data['button_fastorder_sendorder'] = $this->language->get('button_lighshop_sendorder');
			$data['text_lightshop_buy_click'] = $this->language->get('text_lightshop_buy_click');
			$data['text_product_view_btn'] = $this->language->get('text_product_view_btn');
			
			$data['pс_view'] = $this->config->get('theme_lightshop_pс_view');
			$data['mobile_view'] = $this->config->get('theme_lightshop_mobile_view');
			if ($this->config->get('theme_lightshop_buy_click_pdata')) {
				$this->load->language('extension/theme/lightshop');
				$this->load->model('catalog/information');

				$information_info = $this->model_catalog_information->getInformation($this->config->get('theme_lightshop_buy_click_pdata'));

				if ($information_info) {
					$data['text_lightshop_pdata'] = sprintf($this->language->get('text_lightshop_pdata'), $this->language->get('button_lighshop_sendorder'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('theme_lightshop_buy_click_pdata'), true), $information_info['title'], $information_info['title']);
				} else {
					$data['text_lightshop_pdata'] = '';
				}
			} else {
				$data['text_lightshop_pdata'] = '';
			}
			
			$data['buy_click'] = array();
			if($this->config->get('theme_lightshop_buy_click')){
				$data['buy_click'] = $this->config->get('theme_lightshop_buy_click');
				if ($this->customer->isLogged()) {
					$this->load->model('account/customer');
					$data['customer_info'] = $this->model_account_customer->getCustomer($this->customer->getId());
				}
			}			
			$this->load->language('checkout/checkout');
			$data['entry_firstname'] = $this->language->get('entry_firstname');
			$data['entry_lastname'] = $this->language->get('entry_lastname');
			$data['entry_email'] = $this->language->get('entry_email');
			$data['entry_telephone'] = $this->language->get('entry_telephone');
			$data['entry_comment'] = $this->language->get('entry_comment');
			// lightshop end

            

			$data['placeholder_img'] = $this->language->get('placeholder_img');

			// Set the last category breadcrumb
			$data['breadcrumbs'][] = array(
				'text' => $category_info['name'],
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'])
			);

			if ($category_info['image']) {
				
				$data['thumb'] = $this->config->get('theme_lightshop_image_category_resize') ? $this->model_tool_image->lightshop_resize($category_info['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height')) : $this->model_tool_image->resize($category_info['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));// lightshop
            
				$this->document->setOgImage($data['thumb']);
			} else {
				$data['thumb'] = '';
			}

			$data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
			$data['compare'] = $this->url->link('product/compare');

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

//lightshop start
			if (isset($this->request->get['min_price'])) {
				$url .= '&min_price=' . $this->request->get['min_price'];
			} 

			if (isset($this->request->get['max_price'])) {
				$url .= '&max_price=' . $this->request->get['max_price'];
			} 
//lightshop stop
            

			$data['categories'] = array();

			$results = $this->model_catalog_category->getCategories($category_id);

			foreach ($results as $result) {
				$filter_data = array(
					'filter_category_id'  => $result['category_id'],
					'filter_sub_category' => true
				);

				$data['categories'][] = array(
					'name' => $result['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),

					// lightshop
					'thumb' => $this->config->get('theme_lightshop_image_category_resize') ? $this->model_tool_image->lightshop_resize(($result['image']=='' ? 'no_image.png' : $result['image']), $this->config->get($this->config->get('config_theme') . '_image_category_width'),  $this->config->get($this->config->get('config_theme') . '_image_category_height')) : $this->model_tool_image->resize(($result['image']=='' ? 'no_image.png' : $result['image']), $this->config->get($this->config->get('config_theme') . '_image_category_width'),  $this->config->get($this->config->get('config_theme') . '_image_category_height')),
					// lightshop end
            
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url)
				);
			}

			$data['products'] = array();

			$filter_data = array(
				'filter_category_id' => $category_id,

				'min_price'    		 => $min_price,//lightshop
				'max_price'    		 => $max_price,//lightshop
            
				'filter_filter'      => $filter,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);

//lightshop start
			if($this->config->get('theme_lightshop_subcategory')){
				$filter_data['filter_sub_category'] = true;
			}
//lightshop stop
            


  		// OCFilter start
  		$filter_data['filter_ocfilter'] = $filter_ocfilter;
  		// OCFilter end
      
			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

			$results = $this->model_catalog_product->getProducts($filter_data);

			// lightshop
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}	

			$currR = $this->currency->getSymbolRight($this->session->data['currency']);
			$currL = $this->currency->getSymbolLeft($this->session->data['currency']);

			if($currR){
				$data['currencydata'] = "R_" . $currR ;
			}else{
				$data['currencydata'] = "L_" . $currL ;
			}
		
			$data['url'] = $url;
			$isDateTime = false;
			$data['path'] = $this->request->get['path'];
			$data['category_id'] = $category_id;
			$data['cat_url'] = $cat_url;
			$data['product_total'] = $product_total;
			$data['minPrice'] = $this->model_catalog_category->getMinPrice($category_id);
			$data['maxPrice'] = $this->model_catalog_category->getMaxPrice($category_id);
			$data['currency'] = $this->session->data['currency'];
			$labelsInfo = array();
			if($this->config->get('theme_lightshop_label')){
				$labelsInfo = $this->config->get('theme_lightshop_label');  
			}
			$data['labelsinfo'] = $labelsInfo ;
			$data['language_id'] = $this->config->get('config_language_id');
			$newest = array();
			$sales = false;
			if(isset($labelsInfo['new']['period']) && $labelsInfo['new']['status']){
				$newest = $this->model_catalog_product->getNewestProducts($labelsInfo['new']['period']);	
			}
			if(isset($labelsInfo['sale']['status']) && $labelsInfo['sale']['status']){
				$sales = true;				
			}
			// lightshop end

            

			$manufacturer_info = array();

			foreach ($results as $result) {
				if ($result['image']) {
					
					$image = $this->config->get('theme_lightshop_image_product_resize') ? $this->model_tool_image->lightshop_resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height')) : $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));// lightshop
            
				} else {
					
					$image = $this->config->get('theme_lightshop_image_product_resize') ? $this->model_tool_image->lightshop_resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height')) : $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));// lightshop
            
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

				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}

				$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($result['manufacturer_id']);

				if ($manufacturer_info['logo']) {
					$logo_image = $this->model_tool_image->resize($manufacturer_info['logo'], 20, 20);
				} else {
					$logo_image = false;
				}

                $discounts = $this->model_catalog_product->getProductDiscounts($result['product_id']);
                $discount_percent = ($discounts) ? $discounts[0]['price'] : false;

                $options = $this->model_catalog_product->getProductOptions($result['product_id']);
                $product_colors = $this->assembleProductColors($options);
                $options_default_values = $this->assembleOptionsValues($options);


				// lightshop
				$extraImages = array();				
				$images = $this->model_catalog_product->getProductImages($result['product_id']);
				foreach($images as $imageX){
					$extraImages[] = $this->config->get('theme_lightshop_image_product_resize') ? $this->model_tool_image->lightshop_resize($imageX['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height')) : $this->model_tool_image->resize($imageX['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
				}
				
				if (in_array($result['product_id'], $newest)) {
					$isNewest = true;
				} else {
					$isNewest = false;
				}			
								
				if ($result['quantity'] <= 0) {
					$stock = $result['stock_status'];
				} elseif ($this->config->get('config_stock_display')) {
					$stock = $result['quantity'];
				} else {
					$stock = $this->language->get('text_instock');
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

				$options = array();

				foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
					$product_option_value_data = array();

					foreach ($option['product_option_value'] as $option_value) {
						if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
							if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
								$priceOp = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
							} else {
								$priceOp = false;
							}

							$product_option_value_data[] = array(
								'product_option_value_id' => $option_value['product_option_value_id'],
								'option_value_id'         => $option_value['option_value_id'],
								'name'                    => $option_value['name'],
								'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
								'price'                   => $priceOp,
								'price_prefix'            => $option_value['price_prefix']
							);
						}
					}

					if ($option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
						$isDateTime = true;
					}
					
					$options[] = array(
						'product_option_id'    => $option['product_option_id'],
						'product_option_value' => $product_option_value_data,
						'option_id'            => $option['option_id'],
						'name'                 => $option['name'],
						'type'                 => $option['type'],
						'value'                => $option['value'],
						'required'             => $option['required']
					);
				}						
				// lightshop end

            

	      	$data['options'] = array();
	      if($this->config->get('catalog_options_status')) {
			foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
						} else {
							$price = false;
						}

						$product_option_value_data[] = array(
							//'product_option_value_id' => $option_value['product_option_value_id'],
							//'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							//'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
				}
				if(in_array($option['option_id'], $this->config->get('catalog_options_show_options'))) {
					$data['options'][] = array(
						'product_option_id'    => $option['product_option_id'],
						'product_option_value' => $product_option_value_data,
						'option_id'            => $option['option_id'],
						'name'                 => $option['name'],
						'type'                 => $option['type'],
						'value'                => $option['value'],
						'required'             => $option['required']
					);
				}
			}
		}
	      	
				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],

					'manufacturer'        => $result['manufacturer'],// lightshop
					'quantity'        => $result['quantity'],// lightshop
					'stock'        => $stock,// lightshop
					'images'       => $extraImages,// lightshop	
					'isnewest'       => $isNewest,// lightshop
					'sales'       => $sales,// lightshop
					'discount'       => $discount,// lightshop
            
					'manufacturer' => $result['manufacturer'],
					'manufacturer_logo' => $logo_image,
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $discount_percent,
					'tags'        => explode(',' , $result['tag']),
					'tax'         => $tax,
					'minimum'     => ($result['minimum'] > 0) ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url),
                    'colors'      => $product_colors,
                    'options'     => $options_default_values,
				);

			// lightshop
			if ($isDateTime) {
				$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
				$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/locale/'.$this->config->get('config_language').'.js');
				$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
				$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');				
			}
			// lightshop end
            
			}

			$url = '';


      // OCFilter start
			if (isset($this->request->get['filter_ocfilter'])) {
				$url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
			}
      // OCFilter end
      
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();


			$data['sorts'][] = array(
				'text'  => $this->language->get('text_sort_name'),
				'value' => 'pd.name',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path']  . '&page=' . $page . '&sort=pd.name&order' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_sort_price'),
				'value' => 'p.price',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path']  . '&page=' . $page . '&sort=p.price&order' . $url)
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_sort_views'),
					'value' => 'p.viewed',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path']  . '&page=' . $page . '&sort=rating&order' . $url)
				);
			}

			$url = '';


      // OCFilter start
			if (isset($this->request->get['filter_ocfilter'])) {
				$url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
			}
      // OCFilter end
      
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get($this->config->get('config_theme') . '_product_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $value)
				);
			}

			$url = '';


      // OCFilter start
			if (isset($this->request->get['filter_ocfilter'])) {
				$url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
			}
      // OCFilter end
      
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

//lightshop start
			if (isset($this->request->get['min_price'])) {
				$url .= '&min_price=' . $this->request->get['min_price'];
			} 

			if (isset($this->request->get['max_price'])) {
				$url .= '&max_price=' . $this->request->get['max_price'];
			} 
//lightshop stop
            

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}');

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			if ($page == 1) {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'canonical');
			} elseif ($page == 2) {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'prev');
			} else {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page - 1), true), 'prev');
			}

			if ($limit && ceil($product_total / $limit) > $page) {
				$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page + 1), true), 'next');
			}

			$data['sort'] = $sort;
			$data['order'] = $order;
			$data['limit'] = $limit;

      // OCFilter Start
      if (isset($this->request->get['filter_ocfilter'])) {
        if (!$product_total) {
      	  $this->response->redirect($this->url->link('product/category', 'path=' . $this->request->get['path']));
        }

        $data['description'] = '';

        $this->document->deleteLink('canonical');
      }

      $ocfilter_page_info = $this->load->controller('extension/module/ocfilter/getPageInfo');

      if ($ocfilter_page_info) {
        $this->document->setTitle($ocfilter_page_info['meta_title']);

        if ($ocfilter_page_info['meta_description']) {
			    $this->document->setDescription($ocfilter_page_info['meta_description']);
        }

        if ($ocfilter_page_info['meta_keyword']) {
			    $this->document->setKeywords($ocfilter_page_info['meta_keyword']);
        }

			  $data['heading_title'] = $ocfilter_page_info['title'];

        if ($ocfilter_page_info['description'] && !isset($this->request->get['page']) && !isset($this->request->get['sort']) && !isset($this->request->get['order']) && !isset($this->request->get['search']) && !isset($this->request->get['limit'])) {
        	$data['description'] = html_entity_decode($ocfilter_page_info['description'], ENT_QUOTES, 'UTF-8');
        }

  			$data['breadcrumbs'][] = array(
  				'text' => $ocfilter_page_info['title'],
  				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
  			);
      } else {
        $meta_title = $this->document->getTitle();
        $meta_description = $this->document->getDescription();
        $meta_keyword = $this->document->getKeywords();

        $filter_title = $this->load->controller('extension/module/ocfilter/getSelectedsFilterTitle');

        if ($filter_title) {
          if (false !== strpos($meta_title, '{filter}')) {
            $meta_title = trim(str_replace('{filter}', $filter_title, $meta_title));
          } else {
            $meta_title .= ' ' . $filter_title;
          }

          $this->document->setTitle($meta_title);

          if ($meta_description) {
            if (false !== strpos($meta_description, '{filter}')) {
              $meta_description = trim(str_replace('{filter}', $filter_title, $meta_description));
            } else {
              $meta_description .= ' ' . $filter_title;
            }

  			    $this->document->setDescription($meta_description);
          }

          if ($meta_keyword) {
            if (false !== strpos($meta_keyword, '{filter}')) {
              $meta_keyword = trim(str_replace('{filter}', $filter_title, $meta_keyword));
            } else {
              $meta_keyword .= ' ' . $filter_title;
            }

           	$this->document->setKeywords($meta_keyword);
          }

          $heading_title = $data['heading_title'];

          if (false !== strpos($heading_title, '{filter}')) {
            $heading_title = trim(str_replace('{filter}', $filter_title, $heading_title));
          } else {
            $heading_title .= ' ' . $filter_title;
          }

          $data['heading_title'] = $heading_title;

          $data['description'] = '';

    			$data['breadcrumbs'][] = array(
    				'text' => (utf8_strlen($heading_title) > 30 ? utf8_substr($heading_title, 0, 30) . '..' : $heading_title),
    				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
    			);
        } else {
          $this->document->setTitle(trim(str_replace('{filter}', '', $meta_title)));
          $this->document->setDescription(trim(str_replace('{filter}', '', $meta_description)));
          $this->document->setKeywords(trim(str_replace('{filter}', '', $meta_keyword)));

          $data['heading_title'] = trim(str_replace('{filter}', '', $data['heading_title']));
        }
      }
      // OCFilter End
      

			$data['continue'] = $this->url->link('common/home');

// lightshop

			if ($this->config->get($this->config->get('theme_lightshop_config_captcha_fo') . '_status')) {
				$data['captcha_fo'] = $this->load->controller('extension/captcha/' . $this->config->get('theme_lightshop_config_captcha_fo'));
			} else {
				$data['captcha_fo'] = '';
			}
		
		if (isset($this->request->get['view'])) {
			$view = $this->request->get['view'];
			$viewM = $this->request->get['view'];
		}elseif(isset($this->session->data['view'])){
			$view = $this->session->data['view'];
			$viewM = $this->session->data['view'];
		} else {
			$view = $this->config->get('theme_lightshop_pс_view');
			$viewM = $this->config->get('theme_lightshop_mobile_view');
		}
			if (isset($_COOKIE["ismobile"]) && $_COOKIE["ismobile"] == 1){ 
				$this->session->data['view'] = $viewM;
			}else{
				$this->session->data['view'] = $view;
			}
		$data['viewLayer'] = $view;
		$data['viewLayerM'] = $viewM;
		$viewSub = '';
		$data['viewSub'] = '';


				if(strpos($this->session->data['view'],'main') === false){	
					$data['view'] = $this->session->data['view'];

				}else{
					$data['view'] = $this->session->data['view'];

					$viewSub = explode('-',$data['view']);
					if(isset($viewSub[1])){
						$viewSub = '--'.$viewSub[1];
						$data['viewSub'] = 'catalogue__products-list'.$viewSub;
						$data['viewLayerM'] = 'main';
					}else{
						$data['viewSub'] = '';						
					}
					$data['view'] = 'main';

				}	

// lightshop end

            

			$this->registry->set('context', $category_info);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');


// lightshop start
			if (isset($this->request->get['view'])) {
				
				$this->response->setOutput($this->load->view('product/category_'.$data['view'], $data));
				return ;
			}elseif(isset($this->request->get['popupdetail'])){
				
				$this->response->setOutput($this->load->view('product/category_popup', $data));
				return ;			
			}
// lightshop end
		
            
			$this->response->setOutput($this->load->view('product/category', $data));
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/category', $url)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			
// lightshop
		$this->load->language('extension/theme/lightshop');
		$data['category_id'] = $category_id;
		$data['text_404'] = sprintf($this->language->get('text_404'), $this->url->link('information/contact', '', true), $this->url->link('product/search', '', true), $this->url->link('common/home', '', true));
		$this->response->setOutput($this->load->view('error/404', $data));
// lightshop end			
            
		}
	}

// lightshop
	public function breadList($category_id) {
		$this->load->model('catalog/category');
		$data = array();
		$categories = $this->model_catalog_category->getCategories($category_id);
		foreach($categories as $category){
			$data[] = array(
				'name'		=> $category['name'],
				'href'       => $this->url->link('product/category', 'path=' . $category['category_id'])
			);
		}
		return $data;
	}
	public function breadlistcr() {

		$this->load->model('catalog/category');
		$category_id = $this->request->get['cat_id'];
		$data['breadLists'] = array();
		$categories = $this->model_catalog_category->getCategories($category_id);
		foreach($categories as $category){
			$data['breadLists'][] = array(
				'name'		=> $category['name'],
				'href'       => $this->url->link('product/category', 'path=' . $category['category_id'])
			);
		}
		$this->response->setOutput($this->load->view('product/bread_popup',$data));
	}
		
	public function chview() {
		$this->load->model('catalog/category');
		$data = array();
		$this->load->language('product/category');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');
		
		$this->load->language('extension/theme/lightshop');

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		if (isset($this->request->get['view'])) {
			$view = $this->request->get['view'];
		}elseif(isset($this->session->data['view'])){
			$view = $this->session->data['view'];
		} else {
			$view = 'main';
		}


		if (isset($this->request->get['min_price'])) {
			$min_price = $this->request->get['min_price'];
		} else {
			$min_price = '';
		}

		if (isset($this->request->get['max_price'])) {
			$max_price = $this->request->get['max_price'];
		} else {
			$max_price = '';
		}

		$this->session->data['view'] = $view;
		

				if(strpos($this->session->data['view'],'main') === false){	
					$viewFile = $this->session->data['view'];
				}else{
					$viewFile = $this->session->data['view'];
					$viewSub = explode('-',$viewFile);
					if(isset($viewSub[1])){
						$viewSub = $viewSub[1];
						$data['viewSub'] = 'catalogue__products-list--'.$viewSub;						
					}else{
						$data['viewSub'] = '';						
					}

					$viewFile = 'main';
				}			
				
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int)$this->request->get['limit'];
		} else {
			$limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
		}
		$url = '';

		if (isset($this->request->get['path'])) {

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			if (isset($this->request->get['min_price'])) {
				$url .= '&min_price=' . $this->request->get['min_price'];
			} 

			if (isset($this->request->get['max_price'])) {
				$url .= '&max_price=' . $this->request->get['max_price'];
			} 

			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);
			$id = 0;
			foreach ($parts as $path_id) {
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'breadList' => $this->breadList($id),// lightshop
						'cat_id' => $id,// lightshop
						'href' => $this->url->link('product/category', 'path=' . $path . $url)
					);
				}
				$id = $path_id;
			}
		} else {
			$category_id = 0;
		}
		$category_info = $this->model_catalog_category->getCategory($category_id);

			$data['text_refine'] = $this->language->get('text_refine');
			$data['text_empty'] = $this->language->get('text_empty');
			$data['text_quantity'] = $this->language->get('text_quantity');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_price'] = $this->language->get('text_price');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['text_sort'] = $this->language->get('text_sort');
			$data['text_limit'] = $this->language->get('text_limit');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list'] = $this->language->get('button_list');
			$data['button_grid'] = $this->language->get('button_grid');
			


			$data['schema'] = $this->config->get('theme_lightshop_schema');
			$data['product_detail'] = $this->config->get('theme_lightshop_product_detail');

			$data['compare'] = $this->url->link('product/compare');

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			if (isset($this->request->get['min_price'])) {
				$url .= '&min_price=' . $this->request->get['min_price'];
			} 

			if (isset($this->request->get['max_price'])) {
				$url .= '&max_price=' . $this->request->get['max_price'];
			} 

		if (isset($this->request->get['search'])) {
			$search = $this->request->get['search'];
		} else {
			$search = '';
		}
//search
		if (isset($this->request->get['tag'])) {
			$tag = $this->request->get['tag'];
		} elseif (isset($this->request->get['search'])) {
			$tag = $this->request->get['search'];
		} else {
			$tag = '';
		}

		if (isset($this->request->get['description'])) {
			$description = $this->request->get['description'];
		} else {
			$description = '';
		}

		if (isset($this->request->get['category_id'])) {
			$category_id = $this->request->get['category_id'];
		} else {
//			$category_id = 0;
		}

		if (isset($this->request->get['sub_category'])) {
			$sub_category = $this->request->get['sub_category'];
		} else {
			$sub_category = '';
		}
//search
			$data['products'] = array();

			$filter_data = array(
				'filter_name'         => $search,
				'filter_tag'          => $tag,
				'filter_description'  => $description,
				'filter_sub_category' => $sub_category,
				'filter_category_id' => $category_id,
				'filter_filter'      => $filter,
				'min_price'    		 => $min_price,
				'max_price'    		 => $max_price,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);


  		// OCFilter start
  		$filter_data['filter_ocfilter'] = $filter_ocfilter;
  		// OCFilter end
      
			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

			$results = $this->model_catalog_product->getProducts($filter_data);
			

			$data['product_total'] = $product_total;
			$data['minPrice'] = $this->model_catalog_category->getMinPrice($category_id);
			$data['maxPrice'] = $this->model_catalog_category->getMaxPrice($category_id);
			$data['currency'] = $this->session->data['currency'];
			
			$labelsInfo = array();
			if($this->config->get('theme_lightshop_label')){
				$labelsInfo = $this->config->get('theme_lightshop_label');
			}
			$data['labelsinfo'] = $labelsInfo ;
			$data['language_id'] = $this->config->get('config_language_id');
			$newest = array();
			$sales = false;
			if(isset($labelsInfo['new']['period']) && $labelsInfo['new']['status']){
				$newest = $this->model_catalog_product->getNewestProducts($labelsInfo['new']['period']);	
			}
			if(isset($labelsInfo['sale']['status']) && $labelsInfo['sale']['status']){
				$sales = true;				
			}
			
			$data['products'] = array();

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->config->get('theme_lightshop_image_product_resize') ? $this->model_tool_image->lightshop_resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height')) : $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));// lightshop
				} else {
					$image = $this->config->get('theme_lightshop_image_product_resize') ? $this->model_tool_image->lightshop_resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height')) : $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));// lightshop
				}
				
				$extraImages = array();				
				$images = $this->model_catalog_product->getProductImages($result['product_id']);
				foreach($images as $imageX){
					$extraImages[] = $this->config->get('theme_lightshop_image_product_resize') ? $this->model_tool_image->lightshop_resize($imageX['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height')) : $this->model_tool_image->resize($imageX['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
				}			

				if ($result['quantity'] <= 0) {
					$stock = $result['stock_status'];
				} elseif ($this->config->get('config_stock_display')) {
					$stock = $result['quantity'];
				} else {
					$stock = $this->language->get('text_instock');
				}				
				if (in_array($result['product_id'], $newest)) {
					$isNewest = true;
				} else {
					$isNewest = false;
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

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}
				if (isset($this->request->get['path'])) {				
					$href = $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url);
				}else{
					$href = $this->url->link('product/product', 'product_id=' . $result['product_id'] . $url);
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
				

	      	$data['options'] = array();
	      if($this->config->get('catalog_options_status')) {
			foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
						} else {
							$price = false;
						}

						$product_option_value_data[] = array(
							//'product_option_value_id' => $option_value['product_option_value_id'],
							//'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							//'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
				}
				if(in_array($option['option_id'], $this->config->get('catalog_options_show_options'))) {
					$data['options'][] = array(
						'product_option_id'    => $option['product_option_id'],
						'product_option_value' => $product_option_value_data,
						'option_id'            => $option['option_id'],
						'name'                 => $option['name'],
						'type'                 => $option['type'],
						'value'                => $option['value'],
						'required'             => $option['required']
					);
				}
			}
		}
	      	
				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'manufacturer'        => $result['manufacturer'],
					'quantity'        => $result['quantity'],
					'stock'        => $stock,
					'images'       => $extraImages,
					'isnewest'       => $isNewest,
					'sales'       => $sales,
					'discount'       => $discount,
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => ($result['minimum'] > 0) ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $href
				);
			}

		echo $this->load->view('product/category_'.$viewFile, $data);
		return ;
	}
	
	public function popupdetail() {
		$this->load->language('product/category');
		
		$this->load->language('extension/theme/lightshop');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$this->load->model('setting/setting');

		$this->load->model('catalog/lightshop');
		
		$data['review_status'] = $this->config->get('config_review_status');

		$filter_ocfilter = '';
		
		$prodkey = false;

			$data['button_fastorder_sendorder'] = $this->language->get('button_lighshop_sendorder');
			$data['text_lightshop_buy_click'] = $this->language->get('text_lightshop_buy_click');
			
		$data['text_lightshop_popup_link'] = $this->language->get('text_lightshop_popup_link');
		$data['text_lightshop_popup_link_more'] = $this->language->get('text_lightshop_popup_link_more');
		$data['text_lightshop_popup_upload'] = $this->language->get('text_lightshop_popup_upload');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		$data['button_cart'] = $this->language->get('button_cart');

			$data['buy_click'] = array();
			if($this->config->get('theme_lightshop_buy_click')){
				$data['buy_click'] = $this->config->get('theme_lightshop_buy_click');
			}


		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int)$this->request->get['limit'];
		} else {
			$limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
		}

		if (isset($this->request->get['min_price'])) {
			$min_price = $this->request->get['min_price'];
		} else {
			$min_price = '';
		}

		if (isset($this->request->get['max_price'])) {
			$max_price = $this->request->get['max_price'];
		} else {
			$max_price = '';
		}
		
			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
			
			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}
			
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
			if (isset($this->request->get['popuptype'])) {
				$url .= '&popuptype=' . $this->request->get['popuptype'];
			}
			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}
			
			
		if (isset($this->request->get['prod_id'])) {
			$product_id = $this->request->get['prod_id'];
		}		
		
		$data['language'] = $this->session->data['language'];

		if (isset($this->request->get['search'])) {
			$search = $this->request->get['search'];
		} else {
			$search = '';
		}
		
		if (isset($this->request->get['path'])) {

			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

		} else {
			$category_id = 0;
		}
		
		$data['text_select'] = $this->language->get('text_select');		
//search
		if (isset($this->request->get['tag'])) {
			$tag = $this->request->get['tag'];
		} elseif (isset($this->request->get['search'])) {
			$tag = $this->request->get['search'];
		} else {
			$tag = '';
		}

		if (isset($this->request->get['description'])) {
			$description = $this->request->get['description'];
		} else {
			$description = '';
		}
		
		if (isset($this->request->get['popuptype'])) {
			$popuptype = $this->request->get['popuptype'];
		} else {
			$popuptype = 'main';
		}
		if (isset($this->request->get['manufacturer_id'])) {
			$manufacturer_id = (int)$this->request->get['manufacturer_id'];
		} else {
			$manufacturer_id = 0;
		}

		if (isset($this->request->get['sub_category'])) {
			$sub_category = $this->request->get['sub_category']; 
		} else {
			$sub_category = '';
		}
		
		$data['page'] = $page;
//search
			$data['products'] = array();

			$filter_data = array(
				'filter_name'         => $search,
				'filter_tag'          => $tag,
				'filter_description'  => $description,
				'filter_sub_category' => $sub_category,
				'filter_category_id' => $category_id,
				'filter_manufacturer_id' => $manufacturer_id,
				'min_price'    		 => $min_price,
				'max_price'    		 => $max_price,
				'filter_filter'      => $filter,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);
			
//lightshop start
			if($this->config->get('theme_lightshop_subcategory')){
				$filter_data['filter_sub_category'] = true;
			}
//lightshop stop


  		// OCFilter start
  		$filter_data['filter_ocfilter'] = $filter_ocfilter;
  		// OCFilter end
      
//			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

//			$results = $this->model_catalog_product->getProducts($filter_data);

		
		switch ($popuptype) { 
		case 'main':

  		// OCFilter start
  		$filter_data['filter_ocfilter'] = $filter_ocfilter;
  		// OCFilter end
      
			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);
			$results = $this->model_catalog_product->getProducts($filter_data);
			break;
		case 'special':

  		// OCFilter start
  		$filter_data['filter_ocfilter'] = $filter_ocfilter;
  		// OCFilter end
      
			$product_total = $this->model_catalog_product->getTotalProductSpecials();
			$results = $this->model_catalog_product->getProductSpecials($filter_data);
			break;
		}

			$data['products'] = array();
			$labelsInfo = array();
			if($this->config->get('theme_lightshop_label')){
				$labelsInfo = $this->config->get('theme_lightshop_label');
			}
			$data['labelsinfo'] = $labelsInfo ;
			$data['language_id'] = $this->config->get('config_language_id');
			$newest = array();
			$sales = false;
			if(isset($labelsInfo['new']['period']) && $labelsInfo['new']['status']){
				$newest = $this->model_catalog_product->getNewestProducts($labelsInfo['new']['period']);	
			}
			if(isset($labelsInfo['sale']['status']) && $labelsInfo['sale']['status']){
				$sales = true;				
			}

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->config->get('theme_lightshop_image_product_detail_resize') ? $this->model_tool_image->lightshop_resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_detail_width'), $this->config->get($this->config->get('config_theme') . '_image_product_detail_height')) : $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_detail_width'), $this->config->get($this->config->get('config_theme') . '_image_product_detail_height'));// lightshop
				} else {
					$image = $this->config->get('theme_lightshop_image_product_detail_resize') ? $this->model_tool_image->lightshop_resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_detail_width'), $this->config->get($this->config->get('config_theme') . '_image_product_detail_height')) : $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_detail_width'), $this->config->get($this->config->get('config_theme') . '_image_product_detail_height'));// lightshop
				}
				
				$extraImages = array();				
				$images = $this->model_catalog_product->getProductImages($result['product_id']);
				foreach($images as $imageX){
					$extraImages[] = $this->config->get('theme_lightshop_image_product_detail_resize') ? $this->model_tool_image->lightshop_resize($imageX['image'], $this->config->get($this->config->get('config_theme') . '_image_product_detail_width'), $this->config->get($this->config->get('config_theme') . '_image_product_detail_height')) : $this->model_tool_image->resize($imageX['image'], $this->config->get($this->config->get('config_theme') . '_image_product_detail_width'), $this->config->get($this->config->get('config_theme') . '_image_product_detail_height'));
				}			

				if ($result['quantity'] <= 0) {
					$stock = $result['stock_status'];
				} elseif ($this->config->get('config_stock_display')) {
					$stock = $result['quantity'];
				} else {
					$stock = $this->language->get('text_instock');
				}				
				if (in_array($result['product_id'], $newest)) {
					$isNewest = true;
				} else {
					$isNewest = false;
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

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

					$href = $this->url->link('product/product', 'product_id=' . $result['product_id'] );

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

				$customTabs = $this->model_catalog_lightshop->getFields4Product($result['product_id']);
				
				$options = array();

				foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
					$product_option_value_data = array();

					foreach ($option['product_option_value'] as $option_value) {
						if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
							if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
								$priceOp = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
							} else {
								$priceOp = false;
							}

							$product_option_value_data[] = array(
								'product_option_value_id' => $option_value['product_option_value_id'],
								'option_value_id'         => $option_value['option_value_id'],
								'name'                    => $option_value['name'],
								'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
								'price'                   => $priceOp,
								'price_prefix'            => $option_value['price_prefix']
							);
						}
					}

					$options[] = array(
						'product_option_id'    => $option['product_option_id'],
						'product_option_value' => $product_option_value_data,
						'option_id'            => $option['option_id'],
						'name'                 => $option['name'],
						'type'                 => $option['type'],
						'value'                => $option['value'],
						'required'             => $option['required']
					);
				}		
			

	      	$data['options'] = array();
	      if($this->config->get('catalog_options_status')) {
			foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
						} else {
							$price = false;
						}

						$product_option_value_data[] = array(
							//'product_option_value_id' => $option_value['product_option_value_id'],
							//'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							//'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
				}
				if(in_array($option['option_id'], $this->config->get('catalog_options_show_options'))) {
					$data['options'][] = array(
						'product_option_id'    => $option['product_option_id'],
						'product_option_value' => $product_option_value_data,
						'option_id'            => $option['option_id'],
						'name'                 => $option['name'],
						'type'                 => $option['type'],
						'value'                => $option['value'],
						'required'             => $option['required']
					);
				}
			}
		}
	      	
				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'manufacturer'        => $result['manufacturer'],
					'quantity'        => $result['quantity'],
					'stock'        => $stock,
					'images'       => $extraImages,
					'isnewest'       => $isNewest,
					'options'       => $options,
					'sales'       => $sales,
					'discount'    => $discount,
					'customTabs'    => $customTabs,
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => ($result['minimum'] > 0) ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $href
				);
				if(isset($product_id) && $result['product_id'] == $product_id){
					$prodkey = count($data['products'])-1;
				}
			}
		if(isset($prodkey) && ($prodkey >= count($data['products'])-3)){			
			$data['isLast'] = 1;
		}	

		if(!isset($product_id)){
			$prodkey = 0;
			$product_id  = current(reset($data['products']));
		}	
		$data['prodkey'] = $prodkey;		
		$data['minVisKey'] = $prodkey - 3;	

		if($page > 1){
			$data['prevLink'] = HTTP_SERVER . '?' .$url . '&page=' . ($page-1);
		}		

		if($page < ceil($product_total/$limit)){
			$data['nextLink'] = HTTP_SERVER . '?' .$url . '&page=' . ($page+1);
		}		
		
				
		$data['product_id'] = $product_id;
		
		$data['popup_link'] = $this->url->link('product/product', 'product_id=' . $product_id);
		
			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = HTTPS_SERVER . '?' .$url . '&page={page}';

			$data['pagination'] = $pagination->render();

		$this->response->setOutput($this->load->view('product/category_popup', $data));
			


	}	

	public function totalproducts() {
		$this->load->language('extension/theme/lightshop');
		$this->load->model('catalog/product');
		$json = array();


		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}

		if (isset($this->request->get['min_price'])) {
			$min_price = $this->request->get['min_price'];
		} else {
			$min_price = '';
		}

		if (isset($this->request->get['max_price'])) {
			$max_price = $this->request->get['max_price'];
		} else {
			$max_price = '';
		}

		if (isset($this->request->get['filter_category_id'])) {
			$category_id = (int)$this->request->get['filter_category_id'];
		} else {
			$category_id = 0;
		}

			$filter_data = array(
				'filter_category_id' => $category_id,
				'filter_sub_category' => true,//lightshop
				'min_price'    		 => $min_price,
				'max_price'    		 => $max_price,
				'filter_filter'      => $filter,
				'limit'     		 => '10000'
			);

		$json['total'] = $this->model_catalog_product->getTotalProducts($filter_data);
		$json['text_show'] = $this->language->get('text_lightshop_show');
		$json['text_products'] = $this->language->get('text_lightshop_products');
		$json['id'] = rand();

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

// lightshop end

            

    private function assembleProductColors($options)
    {
        foreach ($options as $option) {
            if ($option['name'] !== self::COLOR_OPTION_NAME) {
                continue;
            }

            $colors = [];

            foreach ($option['product_option_value'] as $optionValue) {
                if($optionValue['image'] == 'catalog/icons/squarre-gray.png') {
                    $optionValue['image'] = '';
                }

                if (!$optionValue['subtract'] || ($optionValue['quantity'] > 0)) {
                    $colors[] =
                        [
                            'product_option_value_id' => $optionValue['product_option_value_id'],
                            'option_value_id'         => $optionValue['option_value_id'],
                            'name'                    => $optionValue['name'],
                            'image'                   => $optionValue['image'] ? $this->model_tool_image->resize($optionValue['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height')) : '',
                            'option_id'               => $option['product_option_id'],
                        ];
                }
            }

            return $colors;
        }

        return [];
    }

    private function assembleOptionsValues($options)
    {
        $optionsValues = [];

        foreach ($options as $option) {
            foreach ($option['product_option_value'] as $optionValue) {
                if (!$optionValue['subtract'] || ($optionValue['quantity'] > 0)) {
                    $optionsValues['option[' .  $option['product_option_id'] . ']'] = $optionValue['product_option_value_id'];

                    break;
                }
            }
        }

        return $optionsValues;
    }
}
