<?php
class ControllerProductSearch extends Controller {
	public function index() {
		$this->load->language('product/search');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (isset($this->request->get['search'])) {
			$search = $this->request->get['search'];
		} else {
			$search = '';
		}

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
			$category_id = 0;
		}

		if (isset($this->request->get['sub_category'])) {
			$sub_category = $this->request->get['sub_category'];
		} else {
			$sub_category = '';
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

		if (isset($this->request->get['search'])) {
			$this->document->setTitle($this->language->get('heading_title') .  ' - ' . $this->request->get['search']);
		} elseif (isset($this->request->get['tag'])) {
			$this->document->setTitle($this->language->get('heading_title') .  ' - ' . $this->language->get('heading_tag') . $this->request->get['tag']);
		} else {
			$this->document->setTitle($this->language->get('heading_title'));
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$url = '';

		if (isset($this->request->get['search'])) {
			$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['tag'])) {
			$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['description'])) {
			$url .= '&description=' . $this->request->get['description'];
		}

		if (isset($this->request->get['category_id'])) {
			$url .= '&category_id=' . $this->request->get['category_id'];
		}

		if (isset($this->request->get['sub_category'])) {
			$url .= '&sub_category=' . $this->request->get['sub_category'];
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
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('product/search', $url)
		);

		if (isset($this->request->get['search'])) {
			$data['heading_title'] = $this->language->get('heading_title') .  ' - ' . $this->request->get['search'];
		} else {
			$data['heading_title'] = $this->language->get('heading_title');
		}

		$data['text_empty'] = $this->language->get('text_empty');
		$data['text_search'] = $this->language->get('text_search');
		$data['text_keyword'] = $this->language->get('text_keyword');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_sub_category'] = $this->language->get('text_sub_category');
		$data['text_quantity'] = $this->language->get('text_quantity');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_model'] = $this->language->get('text_model');
		$data['text_price'] = $this->language->get('text_price');
		$data['text_tax'] = $this->language->get('text_tax');
		$data['text_points'] = $this->language->get('text_points');
		$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
		$data['text_sort'] = $this->language->get('text_sort');
		$data['text_limit'] = $this->language->get('text_limit');

		$data['entry_search'] = $this->language->get('entry_search');
		$data['entry_description'] = $this->language->get('entry_description');

		$data['button_search'] = $this->language->get('button_search');
		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_buy'] = $this->language->get('button_buy');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		$data['button_list'] = $this->language->get('button_list');
		$data['button_grid'] = $this->language->get('button_grid');


		// lightshop
		$this->load->language('extension/theme/lightshop');
		$data['url'] = $url;
		$data['schema'] = $this->config->get('theme_lightshop_schema');
		$data['product_detail'] = $this->config->get('theme_lightshop_product_detail');
		$data['category_background'] = $this->config->get('theme_lightshop_category_background');
		$data['category_sorts'] = $this->config->get('theme_lightshop_category_sorts');
		$data['category_limits'] = $this->config->get('theme_lightshop_category_limits');
		$data['catalog_type'] = $this->config->get('theme_lightshop_catalog_type');
		
			$data['button_fastorder_sendorder'] = $this->language->get('button_lighshop_sendorder');
			$data['text_lightshop_buy_click'] = $this->language->get('text_lightshop_buy_click');
			$data['text_product_view_btn'] = $this->language->get('text_product_view_btn');
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
			
			$data['pс_view'] = $this->config->get('theme_lightshop_pс_view');
			$data['mobile_view'] = $this->config->get('theme_lightshop_mobile_view');

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

			
		$data['compare'] = $this->url->link('product/compare');

		$this->load->model('catalog/category');

		// 3 Level Category Search
		$data['categories'] = array();

		$categories_1 = $this->model_catalog_category->getCategories(0);

		foreach ($categories_1 as $category_1) {
			$level_2_data = array();

			$categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);

			foreach ($categories_2 as $category_2) {
				$level_3_data = array();

				$categories_3 = $this->model_catalog_category->getCategories($category_2['category_id']);

				foreach ($categories_3 as $category_3) {
					$level_3_data[] = array(
						'category_id' => $category_3['category_id'],
						'name'        => $category_3['name'],
					);
				}

				$level_2_data[] = array(
					'category_id' => $category_2['category_id'],
					'name'        => $category_2['name'],
					'children'    => $level_3_data
				);
			}

			$data['categories'][] = array(
				'category_id' => $category_1['category_id'],
				'name'        => $category_1['name'],
				'children'    => $level_2_data
			);
		}

		$data['products'] = array();

		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$filter_data = array(
				'filter_name'         => $search,
				'filter_tag'          => $tag,
				'filter_description'  => $description,
				'filter_category_id'  => $category_id,
				'filter_sub_category' => $sub_category,
				'sort'                => $sort,
				'order'               => $order,
				'start'               => ($page - 1) * $limit,
				'limit'               => $limit
			);

			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

			$results = $this->model_catalog_product->getProducts($filter_data);

			// lightshop
			$labelsInfo = array();
			if($this->config->get('theme_lightshop_label')){
				$labelsInfo = $this->config->get('theme_lightshop_label');
			}
			$data['labelsinfo'] = $labelsInfo ;
			$data['language_id'] = $this->config->get('config_language_id');
			$newest = array();
			$isDateTime = false;
			$sales = false;
			if(isset($labelsInfo['new']['period']) && $labelsInfo['new']['status']){
				$newest = $this->model_catalog_product->getNewestProducts($labelsInfo['new']['period']);	
			}
			if(isset($labelsInfo['sale']['status']) && $labelsInfo['sale']['status']){
				$sales = true;				
			}
			// lightshop end
			

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
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}


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
			
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => ($result['minimum'] > 0) ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'] . $url)
				);
			}


			// lightshop
			if ($isDateTime) {
				$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
				$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/locale/'.$this->config->get('config_language').'.js');
				$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
				$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');				
			}
			// lightshop end
			
			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/search', 'sort=p.sort_order&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/search', 'sort=pd.name&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/search', 'sort=pd.name&order=DESC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/search', 'sort=p.price&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/search', 'sort=p.price&order=DESC' . $url)
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/search', 'sort=rating&order=DESC' . $url)
				);

				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/search', 'sort=rating&order=ASC' . $url)
				);
			}

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/search', 'sort=p.model&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/search', 'sort=p.model&order=DESC' . $url)
			);

			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
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
					'href'  => $this->url->link('product/search', $url . '&limit=' . $value)
				);
			}

			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
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

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('product/search', $url . '&page={page}');

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			if ($page == 1) {
			    $this->document->addLink($this->url->link('product/search', '', true), 'canonical');
			} elseif ($page == 2) {
			    $this->document->addLink($this->url->link('product/search', '', true), 'prev');
			} else {
			    $this->document->addLink($this->url->link('product/search', $url . '&page='. ($page - 1), true), 'prev');
			}

			if ($limit && ceil($product_total / $limit) > $page) {
			    $this->document->addLink($this->url->link('product/search', $url . '&page='. ($page + 1), true), 'next');
			}

			if (isset($this->request->get['search']) && $this->config->get('config_customer_search')) {
				$this->load->model('account/search');

				if ($this->customer->isLogged()) {
					$customer_id = $this->customer->getId();
				} else {
					$customer_id = 0;
				}

				if (isset($this->request->server['REMOTE_ADDR'])) {
					$ip = $this->request->server['REMOTE_ADDR'];
				} else {
					$ip = '';
				}

				$search_data = array(
					'keyword'       => $search,
					'category_id'   => $category_id,
					'sub_category'  => $sub_category,
					'description'   => $description,
					'products'      => $product_total,
					'customer_id'   => $customer_id,
					'ip'            => $ip
				);

				$this->model_account_search->addSearch($search_data);
			}
		}

		$data['search'] = $search;
		$data['description'] = $description;
		$data['category_id'] = $category_id;
		$data['sub_category'] = $sub_category;

		$data['sort'] = $sort;
		$data['order'] = $order;
		$data['limit'] = $limit;

// lightshop		
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
						$viewSub = $viewSub[1];
						$data['viewSub'] = 'catalogue__products-list--'.$viewSub;
						$data['viewLayerM'] = 'main';
					}else{
						$data['viewSub'] = '';						
					}
					$data['view'] = 'main';

				}			
				

		if (isset($this->request->get['view'])) {
			
			$this->response->setOutput($this->load->view('product/category_'.$data['view'], $data));
			return ;
		}elseif(isset($this->request->get['popupdetail'])){
			
			$this->response->setOutput($this->load->view('product/category_popup', $data));
			return ;			
		}
// lightshop end

			

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('product/search', $data));
	}
}
