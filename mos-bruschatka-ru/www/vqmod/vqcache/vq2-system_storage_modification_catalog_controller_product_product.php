<?php
class ControllerProductProduct extends Controller {
	private $error = array();

	public function index() {

			// << Live Price
			// secondary way (specific) for some BurnEngine themes
			if ( !empty($this->request->get['get_liveprice']) ) {
				return new Action('module/liveprice/get_price');
			}
			// >> Live Price
			

      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			// >> Related Options / Связанные опции 
      

      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			$data['text_ro_clear_options'] 			= $this->language->get('text_ro_clear_options');
			// >> Related Options / Связанные опции 
      
		$this->load->language('product/product');

		// lightshop
		$this->load->language('extension/theme/lightshop');
		$data['text_lightshop_points'] = $this->language->get('text_lightshop_points');
		$data['schema'] = $this->config->get('theme_lightshop_schema');
		$data['soc_share_code'] = html_entity_decode($this->config->get('theme_lightshop_soc_share_code'), ENT_QUOTES, 'UTF-8');
		$data['soc_share_prod'] = $this->config->get('theme_lightshop_soc_share_prod');
		$data['optMode'] = $this->config->get('theme_lightshop_product_opt_select');
		$this->load->model('catalog/lightshop');
		// lightshop end
            
		$this->load->model('catalog/category');
		$this->load->model('catalog/manufacturer');
		$this->load->model('catalog/product');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['path'])) {
			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

//var_dump($parts);die;
			$id = 0;
            

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],

						'breadList' => $this->breadList($id),// lightshop
						'cat_id' => $id,// lightshop
            
						'href' => $this->url->link('product/category', 'path=' . $path)
					);
				}

				$id = $path_id;
            
			}

			// Set the last category breadcrumb
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if ($category_info) {
				$url = '';

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
					'text' => $category_info['name'],

					'breadList' => $this->breadList($id),// lightshop
					'cat_id' => $id,// lightshop
            
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
				);
			}
		}

		if (isset($this->request->get['manufacturer_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_brand'),
				'href' => $this->url->link('product/manufacturer')
			);

			$url = '';

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

			if ($manufacturer_info) {
				$data['breadcrumbs'][] = array(
					'text' => $manufacturer_info['name'],
					'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
				);
			}
		}

		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
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
				'text' => $this->language->get('text_search'),
				'href' => $this->url->link('product/search', $url)
			);
		}

		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {

                $enableCreditInEpl = $this->config->get('yandex_money_kassa_payment_mode') === 'kassa'
                    && $this->config->get('yandex_money_kassa_use_installments_button');
                $enableCreditInShopSide = $this->config->get('yandex_money_kassa_payment_mode') === 'shop'
                    && $this->config->get('yandex_money_kassa_payment_method_installments');
                $showInstallmentsBlock = $this->config->get('yandex_money_kassa_enabled') && ($enableCreditInEpl || $enableCreditInShopSide)
                    && $this->config->get('yandex_money_kassa_add_installments_block');

                $data['yamoney_showInstallmentsBlock'] = $showInstallmentsBlock;
                $data['yamoney_shop_id'] = $this->config->get('yandex_money_kassa_shop_id');
                $data['yamoney_language_code'] = $this->language->get('code');
            
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
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
				'text' => $product_info['name'],
				'href' => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id'])
			);

			if ($product_info['meta_title']) {
				$this->document->setTitle($product_info['meta_title']);
			} else {
				$this->document->setTitle($product_info['name']);
			}

			$this->document->setDescription($product_info['meta_description']);
			$this->document->setKeywords($product_info['meta_keyword']);
			$this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');

			// lightshop
			if ($this->config->get('config_theme') != 'theme_lightshop') {
            
			$this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');

			}
			// lightshop end
            
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
			$this->document->addScript('catalog/view/javascript/cloudzoom.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/locale/'.$this->session->data['language'].'.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

			if ($product_info['meta_h1']) {
				$data['heading_title'] = $product_info['meta_h1'];
			} else {
				$data['heading_title'] = $product_info['name'];
			}


			
			// << Live Price
			if ( get_class() != 'ControllerProductFntProductDesign' ) {
				
				if ( !$this->model_module_liveprice ) {
					$this->load->model('module/liveprice');
				}
				$data['liveprice_installed'] = $this->model_module_liveprice->installed();
				
				$lp_product_id = 0;
				if ( isset($this->request->get['pid']) ) {
					$lp_product_id = $this->request->get['pid'];
				} elseif ( isset($this->request->get['product_id']) ) {
					$lp_product_id = $this->request->get['product_id'];
				} elseif ( isset($this->request->post['product_id']) ) {
					$lp_product_id = $this->request->post['product_id'];	
				} elseif ( isset($this->request->get['id']) ) {
					$lp_product_id = $this->request->get['id'];
				}
				
				$data['lp_product_id'] =  $lp_product_id; // in some cases it is needed even without correct product_id
				$data['lp_theme_name'] = $this->model_module_liveprice->getThemeName();
				$data['liveprice_settings'] = $this->config->get('liveprice_settings');
				$data['liveprice_scripts'] = array();
				
				$liveprice_custom_js = $this->model_module_liveprice->getPathToCustomJS();
				if ( $liveprice_custom_js ) {
					$data['liveprice_scripts'][] = $liveprice_custom_js;
					if ( $data['lp_theme_name'] == 'journal2' && __FUNCTION__ == 'index2' ) {
						$this->journal2->minifier->addScript( $liveprice_custom_js );
					} else {
						$this->document->addScript( $liveprice_custom_js );
					}
				}
				$liveprice_main_js = $this->model_module_liveprice->getPathToMainJS();
				$data['liveprice_scripts'][] = $liveprice_main_js;
				if ( $data['lp_theme_name'] == 'journal2' && __FUNCTION__ == 'index2' ) {
					$this->journal2->minifier->addScript( $liveprice_main_js );
				} else {
					$this->document->addScript( $liveprice_main_js );
				}
			}
			// >> Live Price
			
			

      // << Related Options / Связанные опции 
			if ( !$this->model_module_related_options ) {
				$this->load->model('module/related_options');
			}
			
			// $this->request->get['product'] - fnt_product_design;
			if ( isset($this->request->get['pid']) ) {
				$ro_product_id = $this->request->get['pid'];
			} elseif ( isset($this->request->get['product_id']) ) {
				$ro_product_id = $this->request->get['product_id'];
			} elseif ( isset($this->request->post['product_id']) ) {
				$ro_product_id = $this->request->post['product_id'];	
			} else {
				$ro_product_id = $this->request->get['product'];
			}
			
			$data['ro_installed']								= $this->model_module_related_options->installed();
			$data['ro_settings']								= $this->config->get('related_options');
			$data['ro_product_id']							= $ro_product_id;
			$data['text_ro_clear_options'] 			= $this->language->get('text_ro_clear_options');
			$data['entry_stock_control_error']  = $this->language->get('entry_stock_control_error');
			$data['ro_theme_name']							= $this->model_module_related_options->getThemeName();
			$data['ro_data'] 										= $this->model_module_related_options->get_ro_data($ro_product_id, true);
			
			$data['ros_to_select'] 							= $this->model_module_related_options->getROCombSelectedByDefault($ro_product_id, isset($this->request->get['search']) ? $this->request->get['search'] : '');
			
			if ( !$this->model_catalog_product ) {
				$this->load->model('catalog/product');
			}
			$ro_product = $this->model_catalog_product->getProduct($ro_product_id);
			$data['ro_product_model'] = empty($ro_product['model']) ? '' : $ro_product['model'];
			
			if ( $data['ro_theme_name'] == 'journal2' ) {
				$this->journal2->minifier->addScript( $this->model_module_related_options->getScriptPathWithVersion('view/extension/related_options/js/liveopencart.select_option_toggle.js') );
				$this->journal2->minifier->addScript( $this->model_module_related_options->getScriptPathWithVersion('view/extension/related_options/js/liveopencart.related_options.js') );
			}
			
			// >> Related Options / Связанные опции 
      
			$data['text_select'] = $this->language->get('text_select');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_reward'] = $this->language->get('text_reward');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_stock'] = $this->language->get('text_stock');
			$data['text_discount'] = $this->language->get('text_discount');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_option'] = $this->language->get('text_option');
			$data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
			$data['text_write'] = $this->language->get('text_write');
			$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true));
			$data['text_note'] = $this->language->get('text_note');
			$data['text_tags'] = $this->language->get('text_tags');
			$data['text_related'] = $this->language->get('text_related');
			$data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
			$data['text_loading'] = $this->language->get('text_loading');

			$data['entry_qty'] = $this->language->get('entry_qty');
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_review'] = $this->language->get('entry_review');
			$data['entry_rating'] = $this->language->get('entry_rating');
			$data['entry_good'] = $this->language->get('entry_good');
			$data['entry_bad'] = $this->language->get('entry_bad');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_buy'] = $this->language->get('button_buy');
			$data['button_view'] = $this->language->get('button_view');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_upload'] = $this->language->get('button_upload');
			$data['button_continue'] = $this->language->get('button_continue');

			$data['placeholder_name'] = $this->language->get('placeholder_name');
			$data['placeholder_phone'] = $this->language->get('placeholder_phone');
			$data['placeholder_email'] = $this->language->get('placeholder_email');
			$data['placeholder_img'] = $this->language->get('placeholder_img');

			$this->load->model('catalog/review');

			$data['tab_description'] = $this->language->get('tab_description');
			$data['tab_attribute'] = $this->language->get('tab_attribute');
			$data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);

			$data['product_id'] = (int)$this->request->get['product_id'];
			$data['manufacturer'] = $product_info['manufacturer'];
			$data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
			$data['model'] = $product_info['model'];
			$data['reward'] = $product_info['reward'];
			$data['points'] = $product_info['points'];
			$data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');

			if ($product_info['quantity'] <= 0) {
				$data['stock'] = $product_info['stock_status'];
			} elseif ($this->config->get('config_stock_display')) {
				$data['stock'] = $product_info['quantity'];
			} else {
				$data['stock'] = $this->language->get('text_instock');
			}

			$this->load->model('tool/image');

// lightshop
			$data['currency'] = 'RUB';
			if (isset($this->session->data['currency'])) {
				$data['currency'] = $this->session->data['currency'];
			}
			
			$this->load->language('checkout/checkout');
			$data['entry_firstname'] = $this->language->get('entry_firstname');
			$data['entry_lastname'] = $this->language->get('entry_lastname');
			$data['entry_email'] = $this->language->get('entry_email');
			$data['entry_telephone'] = $this->language->get('entry_telephone');
			$data['entry_comment'] = $this->language->get('entry_comment');
			$this->load->language('extension/theme/lightshop');
			$this->load->model('catalog/information');
			if ($this->config->get('theme_lightshop_buy_click_pdata')) {
				$click_pdata = $this->model_catalog_information->getInformation($this->config->get('theme_lightshop_buy_click_pdata'));
				if ($click_pdata) {
					$data['text_click_pdata'] = sprintf($this->language->get('text_lightshop_pdata'), $this->language->get('button_lighshop_sendorder'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('theme_lightshop_buy_click_pdata'), true), $click_pdata['title'], $click_pdata['title']);
				} else {
					$data['text_click_pdata'] = '';
				}
			} else {
				$data['text_click_pdata'] = '';
			}
			if ($this->config->get('theme_lightshop_review_pdata')) {	
				$review_pdata = $this->model_catalog_information->getInformation($this->config->get('theme_lightshop_review_pdata'));
				if ($review_pdata) {
					$data['text_review_pdata'] = sprintf($this->language->get('text_lightshop_pdata'), $this->language->get('button_continue'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('theme_lightshop_review_pdata'), true), $review_pdata['title'], $review_pdata['title']);
				} else {
					$data['text_review_pdata'] = '';
				}
			} else {
				$data['text_review_pdata'] = '';
			}


			$data['button_fastorder_sendorder'] = $this->language->get('button_lighshop_sendorder');

			$data['text_lightshop_products_text_more'] = $this->language->get('text_lightshop_products_text_more');
			$data['text_lightshop_products_review'] = $this->language->get('text_lightshop_products_review');
			
			$tempDesc = $this->descriptionExtra($data['description']);
			$data['description'] = $tempDesc['fulldesc'];	
			if (!$this->config->get('theme_lightshop_product_short_descr')) {
				$data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
			}
			$data['short_descr'] = $this->config->get('theme_lightshop_product_short_descr');
			$data['zoom'] = $this->config->get('theme_lightshop_product_zoom');
			$data['p_related_view'] = $this->config->get('theme_lightshop_p_related_view');
			$data['shortdescription'] = $tempDesc['shortdesc'];			
			$data['typeOptAtt'] = $this->config->get('theme_lightshop_product_att_select');
			$data['typeOptSelect'] = $this->config->get('theme_lightshop_product_opt_select');
			$data['typeOptCheckImg'] = $this->config->get('theme_lightshop_product_opt_checkbox_img');
			$data['typeOptRadioImg'] = $this->config->get('theme_lightshop_product_opt_radio_img');
			
			if ($this->config->get('theme_lightshop_image_popup_resize')) {
				if ($product_info['image']) {
					$data['popup'] = $this->model_tool_image->lightshop_resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
				} else {
					$data['popup'] = $this->model_tool_image->lightshop_resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
				}
			} else {

            

			if ($product_info['image']) {
				$data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
			} else {
				
					$data['popup'] = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
            
			}


			}
			if ($this->config->get('theme_lightshop_image_thumb_resize')) {
				if ($product_info['image']) {
					$data['thumb'] = $this->model_tool_image->lightshop_resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
					$this->document->setOgImage($data['thumb']);
				} else {
					$data['thumb'] = $this->model_tool_image->lightshop_resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));;
				}
			} else {
            
			if ($product_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
				$this->document->setOgImage($data['thumb']);
			} else {
				
					$data['thumb'] = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
					$this->document->setOgImage($data['thumb']);
            
			}


			}
			if ($this->config->get('theme_lightshop_image_additional_resize')) {
				if ($product_info['image']) {
					$data['additional'] = $this->model_tool_image->lightshop_resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'));
					$this->document->setOgImage($data['thumb']);
				} else {
					$data['additional'] = $this->model_tool_image->lightshop_resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'));;
				}
			} else {
				if ($product_info['image']) {
					$data['additional'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'));
					$this->document->setOgImage($data['thumb']);
				} else {
					$data['additional'] = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'));
					$this->document->setOgImage($data['thumb']);
				}				
			}
			
			$data['customTabs'] = $this->model_catalog_lightshop->getFields4Product($this->request->get['product_id']);

// lightshop end
            
			$data['images'] = array();


				// Product Option Image PRO module <<
				if ( !$this->model_module_product_option_image_pro ) {
					$this->load->model('module/product_option_image_pro');
				}
				//>> Product Option Image PRO module
      
			$results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);

			
				// Product Option Image PRO module <<
				
				if ( !$this->model_module_product_option_image_pro ) {
					$this->load->model('module/product_option_image_pro');
				}
				if ( $this->model_module_product_option_image_pro->getThemeName() == 'barbaratheme' && !empty($data['page_type']) && $data['page_type'] == 'quickview' ) {
					
					$poip_data = $this->model_module_product_option_image_pro->getDataForProductPage($results, array( 'popup_width' => $config_image_thumb_width, 'popup_height' => $config_image_thumb_height ));
				} else {
					$poip_data = $this->model_module_product_option_image_pro->getDataForProductPage($results);
				}
				if ( $poip_data ) {
					$data = array_merge($data, $poip_data['data']);
					$results = $poip_data['results'];
				}
			
				//>> Product Option Image PRO module
      

			foreach ($results as $result) {
				$data['images'][] = array(

				// Product Option Image PRO module <<
				'title' => isset($result['title']) ? $result['title'] : '',
				// >> Product Option Image PRO module
      
					
					'popup' =>  $this->config->get('theme_lightshop_image_popup_resize') ? $this->model_tool_image->lightshop_resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height')) : $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height')),
            
					
					'thumb' => $this->config->get('theme_lightshop_image_additional_resize') ? $this->model_tool_image->lightshop_resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height')) : $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height')),
					'additional' => $this->config->get('theme_lightshop_image_additional_resize') ? $this->model_tool_image->lightshop_resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height')) : $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'))
            
				);
			}

			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				$data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);

                $data['cost'] = sprintf('%.2f',$this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
            

				$data['price_schema'] = number_format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), 0, '', '');// lightshop
            
			} else {
				$data['price'] = false;

				$data['price_schema'] = false;// lightshop
            
			}

			if ((float)$product_info['special']) {
				$data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);

				$data['special_schema'] = number_format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), 0, '', '');// lightshop
            
			} else {
				$data['special'] = false;

				$data['special_schema'] = false;
            
			}

			$discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);
			$data['special'] = ($discounts) ? $discounts[0]['price'] : false;

			if ($this->config->get('config_tax')) {
				$data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
			} else {
				$data['tax'] = false;
			}

			$data['options'] = array();

			foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) {
				$product_option_value_data = array();

				foreach ($option['product_option_value'] as $option_value) {
					if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
						if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
							$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);

			// << Live Price
			
			if (($option_value['price_prefix'] == '*' || $option_value['price_prefix'] == '/' || $option_value['price_prefix'] == '%')
				&& (!isset($option_value['hide']) || !$option_value['hide'] ) ) {
				// special way
				$price = (float)$option_value['price'];
			
			/*	
			} else {
				//standard way
				$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false));
				*/
			}
			
			// >> Live Price
			
			
						} else {
							$price = false;
						}

						if($option_value['image'] == 'catalog/icons/squarre-gray.png') {
							$option_value['image'] = $product_info['image'];
						}

						$product_option_value_data[] = array(

			
			// << Product Option Image PRO module
      
			'poip_image'                   => (isset($option_value['poip_image']) && $option_value['poip_image'])
				? ( strpos($this->model_module_product_option_image_pro->getThemeName(), 'journal2') === 0 ? Journal2Utils::resizeImage($this->model_tool_image, $option_value['poip_image'], $this->journal2->settings->get('product_page_options_push_image_width', 30), $this->journal2->settings->get('product_page_options_push_image_height', 30), 'crop') : $this->model_tool_image->resize($option_value['poip_image'], 50, 50) )
				: '',
			
      // >> Product Option Image PRO module
			
			
							'product_option_value_id' => $option_value['product_option_value_id'],
							'option_value_id'         => $option_value['option_value_id'],
							'name'                    => $option_value['name'],
							'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height')) : '',
							'price'                   => $price,
							'price_prefix'            => $option_value['price_prefix']
						);
					}
				}

				$data['options'][] = array(
					'product_option_id'    => $option['product_option_id'],
					'product_option_value' => $product_option_value_data,
					'option_id'            => $option['option_id'],
					'description'          => $option['description'],
'description'          => html_entity_decode($option['description'], ENT_QUOTES, 'UTF-8'),
		'description_status'          => strip_tags($option['description']),
		
					'name'                 => $option['name'],
					'type'                 => $option['type'],
					'value'                => $option['value'],
					'required'             => $option['required']
				);
			}

			if ($product_info['minimum']) {
				$data['minimum'] = $product_info['minimum'];
			} else {
				$data['minimum'] = 1;
			}


			// lightshop
			$data['quantity'] = $product_info['quantity'];
			// lightshop end
            
			$data['review_status'] = $this->config->get('config_review_status');

			if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
				$data['review_guest'] = true;
			} else {
				$data['review_guest'] = false;
			}

			if ($this->customer->isLogged()) {
				$data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
			} else {
				$data['customer_name'] = '';
			}

			$data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
			$data['rating'] = $product_info['rating'];

			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'));
			} else {
				$data['captcha'] = '';
			}

			$data['share'] = $this->url->link('product/product', 'product_id=' . (int)$this->request->get['product_id']);

			$data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);


			// lightshop
			
			if ($this->config->get($this->config->get('theme_lightshop_config_captcha_fo') . '_status')) {
				$data['captcha_fo'] = $this->load->controller('extension/captcha/' . $this->config->get('theme_lightshop_config_captcha_fo'));
			} else {
				$data['captcha_fo'] = '';
			}

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
			$data['sales'] = $sales;
				if (in_array($product_id, $newest)) {
					$data['isnewest'] = true;
				} else {
					$data['isnewest'] = false;
				}			

				$data['discount'] = '';
				if($sales && $data['special']){
					if($labelsInfo['sale']['extra'] == 1){
						$discount = round((($product_info['price'] - $product_info['special'])/$product_info['price'])*100);
						$data['discount'] = $discount. ' %';
					}
					if($labelsInfo['sale']['extra'] == 2){
						$data['discount'] = $this->currency->format($this->tax->calculate(($product_info['price'] - $product_info['special']), $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					}					
				}	

			$data['buy_click'] = array();
			if($this->config->get('theme_lightshop_buy_click')){
				$data['buy_click'] = $this->config->get('theme_lightshop_buy_click');

				if ($this->customer->isLogged()) {
					$this->load->model('account/customer');
					$data['customer_info'] = $this->model_account_customer->getCustomer($this->customer->getId());
				}
			}



			$data['text_lightshop_buy_click'] = $this->language->get('text_lightshop_buy_click');			
				
			// lightshop end
            

				// << Related Options
				if ( !$this->model_module_related_options ) {
					$this->load->model('module/related_options');
				}
				// >> Related Options
			
			$data['products'] = array();
			$product_manufacturer_info = array();

			$results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);

			foreach ($results as $result) {

				// lightshop
				if ($this->config->get('theme_lightshop_image_related_resize')) {
            
				if ($result['image']) {

						$image = $this->model_tool_image->lightshop_resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
					} else {
						$image = $this->model_tool_image->lightshop_resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
					}
				} else {
					if ($result['image']) {
            
					$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				}


				}
				// lightshop end

            
				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
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

                $discounts = $this->model_catalog_product->getProductDiscounts($result['product_id']);
                $discount = ($discounts) ? $discounts[0]['price'] : false;

				$data['products'][] = array(

      // Product Option Image PRO module <<
      
      'option_images'  => $this->model_module_product_option_image_pro->getCategoryImagesForController( $result['product_id'], "related_products" ),
      // >> Product Option Image PRO module
      
					'product_id'  => $result['product_id'],

				// << Related Options
				'ro_settings' 	=> $this->config->get('related_options'),
				// model should be already loaded by model_catalog_product->getProducts or directly in the upper code
				'ro_data' 			=> $this->model_module_related_options ? $this->model_module_related_options->getRODataForProductList($result['product_id']) : '', 
				'ro_theme_name' => $this->model_module_related_options ? $this->model_module_related_options->getThemeName() : '',
				'ros_to_select' => $this->model_module_related_options ? $this->model_module_related_options->getROCombSelectedByDefault($result['product_id']) : '',
				// >> Related Options
			
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $discount,
					'tags'        => explode(',' , $result['tag']),
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}

			$data['tags'] = array();

			if ($product_info['tag']) {
				$tags = explode(',', $product_info['tag']);

				foreach ($tags as $tag) {
					$data['tags'][$tag] = $this->url->link('product/search', 'tag=' . trim($tag));
				}
			}


// lightshop
			if (!isset($_COOKIE["productsVieded[" . $product_id . "]"])){
				SetCookie("productsVieded[" . $product_id . "]",time(),time()+3600*24*30*12,"/");
			}
// lightshop end
            
			$data['recurrings'] = $this->model_catalog_product->getProfiles($this->request->get['product_id']);

			$this->model_catalog_product->updateViewed($this->request->get['product_id']);

			$product_info['category_meta_title'] = $category_info['meta_title'];
			$product_info['category_meta_description'] = $category_info['meta_description'];
			$product_info['price'] = (int)$product_info['price'];
			$this->registry->set('context', $product_info);

			$data['product_reviews'] = $this->load->controller('product/product/review', 'product_id=' . $this->request->get['product_id']);
			$data['additional'] = $this->load->controller('common/additional');
			$data['privacy_info'] = $this->load->controller('common/privacy_info');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$reduction = $product_info['price'] * 0.05;

			$data['reduction'] = $this->currency->format($reduction, $this->session->data['currency']);

			$this->load->model('setting/setting');
			$this->load->model('localisation/location');
			$store_id = $this->config->get('config_store_id');
			$store_info = $this->model_setting_setting->getSetting('config', $store_id);
			$location_info = $this->model_localisation_location->getLocation($store_info['config_location'][0]);
			
			if( strpos( $store_info['config_name'], 'ОПТ') !== false) {
				$version = 2;
				$title = 'Самые продаваемые модели плитки';
			} else {
				$version = 1;
				$title = 'Хиты тротуарной плитки';
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
				'title'     => $title
			);

			if($version == 2) {
				$this->response->setOutput($this->load->view('custom/modals/calculator', $data));
			} else {
				$this->response->setOutput($this->load->view('product/product', $data));
			}
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
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
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/product', $url . '&product_id=' . $product_id)
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
		$data['text_404'] = sprintf($this->language->get('text_404'), $this->url->link('information/contact', '', true), $this->url->link('product/search', '', true), $this->url->link('common/home', '', true));
		$this->response->setOutput($this->load->view('error/404', $data));
// lightshop end	
            
		}
	}

	public function review() {

      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			// >> Related Options / Связанные опции 
      

      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			$data['text_ro_clear_options'] 			= $this->language->get('text_ro_clear_options');
			// >> Related Options / Связанные опции 
      
		$this->load->language('product/product');
		$this->load->model('catalog/review');

		$data['text_no_reviews'] = $this->language->get('text_no_reviews');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}


		// lightshop
		$data['schema'] = $this->config->get('theme_lightshop_schema');
		// lightshop end
            
		$data['reviews'] = array();

		$review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

		$results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);

		foreach ($results as $result) {
			$data['reviews'][] = array(
				'author'     => $result['author'],
				'text'       => nl2br($result['text']),
				'rating'     => (int)$result['rating'],

				'date_added_schema' => date('Y-m-d', strtotime($result['date_added'])), // lightshop
            
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}

		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = 5;
		$pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));

		return $this->load->view('product/review', $data);
	}

	public function write() {

      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			// >> Related Options / Связанные опции 
      

      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			$data['text_ro_clear_options'] 			= $this->language->get('text_ro_clear_options');
			// >> Related Options / Связанные опции 
      
		$this->load->language('product/product');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}

			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}

			if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
				$json['error'] = $this->language->get('error_rating');
			}

			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

				if ($captcha) {
					$json['error'] = $captcha;
				}
			}

			if (!isset($json['error'])) {
				$this->load->model('catalog/review');

				$this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

				$json['success'] = $this->language->get('text_success');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getRecurringDescription() {

      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			// >> Related Options / Связанные опции 
      

      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			$data['text_ro_clear_options'] 			= $this->language->get('text_ro_clear_options');
			// >> Related Options / Связанные опции 
      
		$this->load->language('product/product');
		$this->load->model('catalog/product');

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		if (isset($this->request->post['recurring_id'])) {
			$recurring_id = $this->request->post['recurring_id'];
		} else {
			$recurring_id = 0;
		}

		if (isset($this->request->post['quantity'])) {
			$quantity = $this->request->post['quantity'];
		} else {
			$quantity = 1;
		}

		$product_info = $this->model_catalog_product->getProduct($product_id);
		$recurring_info = $this->model_catalog_product->getProfile($product_id, $recurring_id);

		$json = array();

		if ($product_info && $recurring_info) {
			if (!$json) {
				$frequencies = array(
					'day'        => $this->language->get('text_day'),
					'week'       => $this->language->get('text_week'),
					'semi_month' => $this->language->get('text_semi_month'),
					'month'      => $this->language->get('text_month'),
					'year'       => $this->language->get('text_year'),
				);

				if ($recurring_info['trial_status'] == 1) {
					$price = $this->currency->format($this->tax->calculate($recurring_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					$trial_text = sprintf($this->language->get('text_trial_description'), $price, $recurring_info['trial_cycle'], $frequencies[$recurring_info['trial_frequency']], $recurring_info['trial_duration']) . ' ';
				} else {
					$trial_text = '';
				}

				$price = $this->currency->format($this->tax->calculate($recurring_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);

				if ($recurring_info['duration']) {
					$text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				} else {
					$text = $trial_text . sprintf($this->language->get('text_payment_cancel'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				}

				$json['success'] = $text;
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

// lightshop

	public function custtabload() {
		$this->load->model('catalog/lightshop');

		$customTabs = $this->model_catalog_lightshop->getFields4Product($this->request->get['product_ids']);
		$data['customTab'] = $customTabs["popup"][$this->request->get['tab']];

		$this->response->setOutput($this->load->view('product/custtab_popup',$data));
	}

	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model'])) {
			$this->load->model('catalog/product');
//			$this->load->model('catalog/option');
			$this->load->model('tool/image');

			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}

			if (isset($this->request->get['filter_model'])) {
				$filter_model = $this->request->get['filter_model'];
			} else {
				$filter_model = '';
			}

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = 5;
			}

			$filter_data = array(
				'filter_name'  => $filter_name,
				'filter_model' => $filter_model,
				'start'        => 0,
				'limit'        => $limit
			);

			$results = $this->model_catalog_product->getProducts($filter_data);

			foreach ($results as $result) {
				$option_data = array();
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
/*
				$product_options = $this->model_catalog_product->getProductOptions($result['product_id']);

				foreach ($product_options as $product_option) {
					$option_info = $this->model_catalog_option->getOption($product_option['option_id']);

					if ($option_info) {
						$product_option_value_data = array();

						foreach ($product_option['product_option_value'] as $product_option_value) {
							$option_value_info = $this->model_catalog_option->getOptionValue($product_option_value['option_value_id']);

							if ($option_value_info) {
								$product_option_value_data[] = array(

			
			// << Product Option Image PRO module
      
			'poip_image'                   => (isset($option_value['poip_image']) && $option_value['poip_image'])
				? ( strpos($this->model_module_product_option_image_pro->getThemeName(), 'journal2') === 0 ? Journal2Utils::resizeImage($this->model_tool_image, $option_value['poip_image'], $this->journal2->settings->get('product_page_options_push_image_width', 30), $this->journal2->settings->get('product_page_options_push_image_height', 30), 'crop') : $this->model_tool_image->resize($option_value['poip_image'], 50, 50) )
				: '',
			
      // >> Product Option Image PRO module
			
			
									'product_option_value_id' => $product_option_value['product_option_value_id'],
									'option_value_id'         => $product_option_value['option_value_id'],
									'name'                    => $option_value_info['name'],
									'price'                   => (float)$product_option_value['price'] ? $this->currency->format($product_option_value['price'], $this->config->get('config_currency')) : false,
									'price_prefix'            => $product_option_value['price_prefix']
								);
							}
						}

						$option_data[] = array(
							'product_option_id'    => $product_option['product_option_id'],
							'product_option_value' => $product_option_value_data,
							'option_id'            => $product_option['option_id'],
							'name'                 => $option_info['name'],
							'type'                 => $option_info['type'],
							'value'                => $product_option['value'],
							'required'             => $product_option['required']
						);
					}
				}
*/

				$json[] = array(
					'product_id' => $result['product_id'],
					'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
					'model'      => $result['model'],
					'image'      => $image,
					'option'     => $option_data,
					'price'      => $price,
					'special'    => $special,
					'href' 		 => str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $result['product_id']))
				);
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
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
	public function descriptionExtra($description) {
		$data['fulldesc'] = $description;
		$data['shortdesc'] = '';
		$tag = html_entity_decode($this->config->get('theme_lightshop_product_short_tag'), ENT_QUOTES, 'UTF-8');
		$temp = explode($tag,$description);
		if(isset($temp[0])){
			$data['shortdesc'] = $temp[0];
			$data['fulldesc'] = str_replace($data['shortdesc'].$tag, "", $description);
		}
		return $data;
	}
// lightshop end
            
}
