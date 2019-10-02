<?php
class ControllerCommonHeader extends Controller {
	public function index() {

      // Product Option Image PRO module <<
			
      if ( !$this->model_module_product_option_image_pro ) {
				$this->load->model('module/product_option_image_pro');
			}
      $data['poip_installed'] = $this->model_module_product_option_image_pro->installed();
			$data['poip_settings'] = $this->model_module_product_option_image_pro->getSettings();
			$data['poip_theme_name'] = $this->model_module_product_option_image_pro->getThemeName();
			$data['poip_inclide_file_name_default'] = $this->model_module_product_option_image_pro->getTemplateIncludeFileName('list', true);
			$data['poip_inclide_file_name_custom'] = $this->model_module_product_option_image_pro->getTemplateIncludeFileName('list');
			
      // >> Product Option Image PRO module
      
$data['ym_code'] = $this->config->get('yandex_metrika_code');
		// Analytics
		$this->load->model('extension/extension');

		$data['analytics'] = array();

		$analytics = $this->model_extension_extension->getExtensions('analytics');

		foreach ($analytics as $analytic) {
			if ($this->config->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $this->load->controller('extension/analytics/' . $analytic['code'], $this->config->get($analytic['code'] . '_status'));
			}
		}

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->document->addLink('https://assets.mos-bruschatka.ru/image/' . $this->config->get('config_icon'), 'icon');
		}

		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();

			// << Live Price

				if ( !$this->model_module_liveprice ) {
					$this->load->model('module/liveprice');
				}
				if ( $this->model_module_liveprice->installed() ) {
					$liveprice_custom_js = $this->model_module_liveprice->getPathToCustomJS();
					if ( $liveprice_custom_js ) {
						$this->document->addScript( $liveprice_custom_js );
					}
					$this->document->addScript( $this->model_module_liveprice->getPathToMainJS() );
					$data['liveprice_installed'] 	= true;
					$data['liveprice_settings'] 	= $this->config->get('liveprice_settings');
					$data['lp_theme_name'] 				= $this->model_module_liveprice->getThemeName();
				}
				
			// >> Live Price
			

				// << Related Options
				if ( !$this->model_module_related_options ) {
					$this->load->model('module/related_options');
				}
				
				if ( $this->model_module_related_options->installed() ) {
					$this->document->addScript( $this->model_module_related_options->getScriptPathWithVersion('view/extension/related_options/js/liveopencart.select_option_toggle.js') );
					$this->document->addScript( $this->model_module_related_options->getScriptPathWithVersion('view/extension/related_options/js/liveopencart.related_options.js') );
				}
				// >> Related Options
			
		$data['scripts'] = $this->document->getScripts();

    // OCFilter start
    $data['noindex'] = $this->document->isNoindex();
    // OCFilter end
      
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');

		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = 'https://assets.mos-bruschatka.ru/image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		$this->load->language('common/header');
		$data['og_url'] = (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1')) ? HTTPS_SERVER : HTTP_SERVER) . substr($this->request->server['REQUEST_URI'], 1, (strlen($this->request->server['REQUEST_URI'])-1));
		$data['og_image'] = $this->document->getOgImage();

		$data['text_home'] = $this->language->get('text_home');

		// Wishlist
		if ($this->customer->isLogged()) {
			$this->load->model('account/wishlist');

			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
		} else {
			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		}

		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', true), $this->customer->getFirstName(), $this->url->link('account/logout', '', true));

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_page'] = $this->language->get('text_page');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');
		$data['contact_link'] = $this->url->link('information/contact');

		$data['home'] = $this->url->link('common/home');
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/account', '', true);
		$data['register'] = $this->url->link('account/register', '', true);
		$data['login'] = $this->url->link('account/login', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['transaction'] = $this->url->link('account/transaction', '', true);
		$data['download'] = $this->url->link('account/download', '', true);
		$data['logout'] = $this->url->link('account/logout', '', true);
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', true);
		$data['contact'] = $this->url->link('information/contact');
		$data['telephone'] = $this->config->get('config_telephone');

		// lightshop
		$this->load->language('extension/theme/lightshop');
		$data['text_manufacturers'] = $this->language->get('text_manufacturers');
		$data['text_loader'] = $this->language->get('text_loader');
		$data['text_ls_logged'] = sprintf($this->language->get('text_ls_logged'), $this->customer->getFirstName(), $this->customer->getLastName());
		$data['text_register_account'] = $this->language->get('text_register_account');
		$data['outdated_browser'] = $this->language->get('outdated_browser');
		$data['text_search'] = $this->language->get('text_search');
		$data['text_forgotten'] = $this->language->get('text_forgotten');
		$data['forgotten'] = $this->url->link('account/forgotten', '', true);
		$data['header_type'] = $this->config->get('theme_lightshop_header_type');
		$data['js_footorhead'] = $this->config->get('theme_lightshop_js_footorhead');
		$data['open_graph'] = $this->config->get('theme_lightshop_og');
		$data['preloader'] = $this->config->get('theme_lightshop_preloader');
		$data['google_site_verification'] = $this->config->get('theme_lightshop_google_site_verification');
		$data['yandex_verification'] = $this->config->get('theme_lightshop_yandex_verification');
		$data['phone_1'] = html_entity_decode($this->config->get('theme_lightshop_phone_1' . $this->config->get('config_language_id')), ENT_QUOTES, 'UTF-8');
		$data['phone_2'] = html_entity_decode($this->config->get('theme_lightshop_phone_2' . $this->config->get('config_language_id')), ENT_QUOTES, 'UTF-8');
		$data['custom_css'] = html_entity_decode($this->config->get('theme_lightshop_css'), ENT_QUOTES, 'UTF-8');
		$data['theme_color'] = $this->config->get('theme_lightshop_color');
		$data['theme_fc_color'] = $this->config->get('theme_lightshop_color_2');
		$data['bootstrap_modal'] = $this->config->get('theme_lightshop_bootstrap_modal');
		$data['bootstrap_ttpo'] = $this->config->get('theme_lightshop_bootstrap_ttpo');
		$data['bootstrap_tabs'] = $this->config->get('theme_lightshop_bootstrap_tabs');
		$data['fontawesome'] = $this->config->get('theme_lightshop_fontawesome');
		$data['theme_color_1'] = $this->config->get('theme_lightshop_custom_color_1');
		$data['theme_color_2'] = $this->config->get('theme_lightshop_custom_color_2');
		list($r, $g, $b) = array_map('hexdec',str_split($this->config->get('theme_lightshop_custom_color_2'),2));
		$data['theme_color_3'] = $r . ', ' . $g . ', ' . $b . ', 0.3';
		$data['theme_fc_color_1'] = $this->config->get('theme_lightshop_custom_fc_color_1');
		$data['theme_fc_color_1_db'] = $this->getbrightness($this->config->get('theme_lightshop_custom_fc_color_1'));
		$data['theme_fc_color_2'] = $this->config->get('theme_lightshop_custom_fc_color_2');
		$data['theme_fc_color_2_db'] = $this->getbrightness($this->config->get('theme_lightshop_custom_fc_color_2'));
		$data['theme_fc_color_3'] = $this->config->get('theme_lightshop_custom_fc_color_3');
		$data['theme_fc_color_3_db'] = $this->getbrightness($this->config->get('theme_lightshop_custom_fc_color_3'));
		$data['theme_fc_color_4'] = $this->config->get('theme_lightshop_custom_fc_color_4');
		$data['theme_fc_color_4_db'] = $this->getbrightness($this->config->get('theme_lightshop_custom_fc_color_4'));
		$data['custom_js'] = html_entity_decode($this->config->get('theme_lightshop_js'), ENT_QUOTES, 'UTF-8');
		$data['cart_call'] = $this->config->get('theme_lightshop_cart_call');
		$data['fixed_header'] = $this->config->get('theme_lightshop_fixed_header');
		$data['type3_logo'] = $this->config->get('theme_lightshop_header_type3_logo');
		$data['type3_menu'] = $this->config->get('theme_lightshop_header_type3_menu');
		$data['container_width'] = $this->config->get('theme_lightshop_container_width');
		$data['header_text_logo'] = html_entity_decode($this->config->get('theme_lightshop_header_text_logo'), ENT_QUOTES, 'UTF-8');
		$data['text_items'] = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
		$data['text_islogged'] = sprintf($this->language->get('text_islogged'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true), $this->url->link('account/wishlist'));
		$data['text_empty_wish'] = $this->language->get('text_empty_wish');
		$data['text_lightshop_wish_head'] = $this->language->get('text_lightshop_wish_head');
		$data['text_lightshop_comp_head'] = $this->language->get('text_lightshop_comp_head');
		$data['text_empty_compare'] = $this->language->get('text_empty_compare');
		$data['text_compare_href'] = sprintf($this->language->get('text_compare_href'), $this->url->link('product/compare'));
		$data['text_wish_href'] = sprintf($this->language->get('text_wish_href'), $this->url->link('account/wishlist'));
		$data['text_lightshop_show_all'] = $this->language->get('text_lightshop_show_all');
		$data['text_header_category'] = $this->language->get('text_header_category');
		$data['text_show_more'] = $this->language->get('text_show_more');
		$data['text_account_title'] = $this->language->get('text_account_title');
		$data['text_account_login'] = $this->language->get('text_account_login');
		$data['text_account_register'] = $this->language->get('text_account_register');
		$data['text_account_check'] = $this->language->get('text_account_check');
		$data['text_account_submit'] = $this->language->get('text_account_submit');
		$data['text_account_password'] = $this->language->get('text_account_password');
		$data['text_header_callback'] = $this->language->get('text_header_callback');
		$data['address'] = nl2br($this->config->get('config_address'));

		$data['version'] = $this->config->get('theme_lightshop_version');

		$data['language_id'] = $this->config->get('config_language_id');


		$data['top_links'] = array();
		if($this->config->get('theme_lightshoplinks_array')){
			$data['top_links'] = $this->config->get('theme_lightshoplinks_array');
			$data['top_links'] = $data['top_links'][$this->config->get('config_language_id')];			
		}

		$this->load->model('catalog/lightshop');
		$catLinks = $this->model_catalog_lightshop->createCatLinks($this->config->get('config_language_id'));
		$data['top_links'] = array_merge ($data['top_links'],$catLinks);



		foreach($data['top_links'] as $key => $link){
			if(strpos(current($link),':') !== false ){ continue;}
			$data['top_links'][$key][key($link)] = $this->url->link(current($link));	
		}	


		$data['header_navs'] = array();
		$header_navs = $this->config->get('theme_lightshop_header_nav');

			if($header_navs){
				foreach($header_navs as $header_nav){

				if (isset($header_nav['type'][0])) {					
						if(isset($header_nav['type'][0]['links'])){ 
							foreach($header_nav['type'][0]['links'] as $key => $link){ 
								if(strpos($link,':') !== false ){ continue;}
								$header_nav['type'][0]['links'][$key] = $this->url->link($link);
							}					
					}else{
						$header_nav['type'][0]['links'] = array(); 
					}
				}
					if(isset($header_nav['type'][1]['links'])){ 
						foreach($header_nav['type'][1]['links'] as $key => $link){ 
							if(strpos($link,':') !== false ){ $header_nav['type'][1]['links'][$key] = current($data['top_links'][$key]); continue;}
							$header_nav['type'][1]['links'][$key] = $this->url->link($link); 
//							$header_nav['type'][1]['links'][$key] = current($data['top_links'][$key]); 
						}					
					}
					$data['header_navs'][$header_nav['sort']] = $header_nav;
				}				
			}

		ksort($data['header_navs']);

		//Основное меню
		$data['main_navs'] = array();
		$main_navs = $this->config->get('theme_lightshop_main_nav');



		require_once(DIR_APPLICATION . 'controller/common/header_add.php');


		
		//ПРАВЫЙ ЭЛЕМЕНТ ПОДМЕНЮ КАТЕГОРИИ
		$this->load->model('catalog/product');
		$this->load->model('catalog/manufacturer');
		$this->load->model('tool/image');		
		$data['main_recs'] = array();
		$data['main_prods'] = array();
		$data['main_manf'] = array();
		$main_recs = $this->config->get('theme_lightshop_main_rec');

			if(isset($main_recs)){
				foreach($main_recs as $main_rec){
					$data['main_recs'][$main_rec['category_id']] = $main_rec;		
					if(isset($main_rec['type'][0]) && (!$main_rec['settype'] || $main_rec['settype'] == 2) ){
					  if(isset($main_rec['type'][0]['links'])){
						foreach($main_rec['type'][0]['links'] as $prodId => $product){
							$product_info = $this->model_catalog_product->getProduct($prodId);
							if ($product_info['image']) {
								$thumb = $this->config->get('theme_lightshop_image_main_rec_resize') ? $this->model_tool_image->lightshop_resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_main_rec_width'), $this->config->get($this->config->get('config_theme') . '_image_main_rec_height')) : $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_main_rec_width'), $this->config->get($this->config->get('config_theme') . '_image_main_rec_height'));
							} else {
								$thumb = '';
							}
							if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
								$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
							} else {
								$price = false;
							}
							if ((float)$product_info['special']) {
								$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
							} else {
								$special = false;
							}
							$data['main_prods'][$main_rec['category_id']][] = array(
														'thumb'       => $thumb,
														'name'        => $product_info['name'],	
														'price'       => $price,
														'special'     => $special,
														'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])							
							);
						}
					  }
					  if(isset($main_rec['type'][0]['manf'])){
						foreach($main_rec['type'][0]['manf'] as $manfId => $product){
							$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($manfId);

							$data['main_manf'][$main_rec['category_id']][] = array(
														'name'        => $manufacturer_info['name'],
														'href'        => $this->url->link('product/product', 'manufacturer_id=' . $manufacturer_info['manufacturer_id'])							
							);
						}					  	
					  }

					}else{
						$data['main_html'][$main_rec['category_id']] = html_entity_decode($main_rec['type'][1]['html'], ENT_QUOTES, 'UTF-8');
					}
				}				
			}
		$data['manufacturerlinks'] = $this->url->link('product/manufacturer');

		$this->load->language('product/compare');
		$data['productscomp'] = $this->getCompareData();
		$data['countcomp'] = count($data['productscomp']);
		$data['islogged'] = false;
		$data['productswish'] = array();		
		if ($this->customer->isLogged() || $this->config->get('theme_lightshop_wishlist')) {
			$data['islogged'] = true;
		}
		$data['productswish'] = $this->getWishData(); 
		$data['count'] = count($data['productswish']);
		$data['counTotall'] =$data['countcomp']+$data['count']; 

		if (is_file(DIR_IMAGE . $this->config->get('theme_lightshop_header_logo'))) {
			$data['header_logo'] = $server . 'image/' . $this->config->get('theme_lightshop_header_logo');
		} else {
			$data['header_logo'] = '';
		}
		if (is_file(DIR_IMAGE . $this->config->get('theme_lightshop_fav_16'))) {
			$data['fav_16'] = $server . 'image/' . $this->config->get('theme_lightshop_fav_16');
		} else {
			$data['fav_16'] = '';
		}
		if (is_file(DIR_IMAGE . $this->config->get('theme_lightshop_fav_32'))) {
			$data['fav_32'] = $server . 'image/' . $this->config->get('theme_lightshop_fav_32');
		} else {
			$data['fav_32'] = '';
		}
		if (is_file(DIR_IMAGE . $this->config->get('theme_lightshop_fav_180'))) {
			$data['fav_180'] = $server . 'image/' . $this->config->get('theme_lightshop_fav_180');
		} else {
			$data['fav_180'] = '';
		}
		$data['callback_status'] = $this->config->get('theme_lightshop_callback_status');
		$data['schema'] = $this->config->get('theme_lightshop_schema');
		
		$data['max_subcat'] = $this->config->get('theme_lightshop_max_subcat');
		
// lightshop end

            

		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');


		$data['topcat'] = array();
            
		$data['categories'] = array();

// lightshop start
		$data['categories'] = $this->cache->get('category.categoriesdata.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.0');
		$data['topcat'] = $this->cache->get('category.categoriestopcat.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.0');
//		$data['categories'] = array();
	if (!$data['categories']) {
//lightshop end

            

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				$L3_chid = false;// <--lightshop add this
            

				foreach ($children as $child) {

// lightshop					
					$children2_data = array();
					$children2 = $this->model_catalog_category->getCategories($child['category_id']);
					foreach ($children2 as $child2) {					
            
					$filter_data = array(
						
							'filter_category_id'  => $child2['category_id'],
            
						'filter_sub_category' => true
					);

					
						// Level 3
						$children2_data[$child2['category_id']] = array(
							'name'  => $child2['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
							'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $child2['category_id'])
						);
					}					
					
//lightshop end					
					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);
					// Level 2
					if($children2_data){$L3_chid = true;}// <--lightshop add this
					
					$children_data[$child['category_id']] = array(// <--lightshop change this
            
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']),
						'children' => $children2_data // <--lightshop add this
            
					);
				}

				// Level 1
				
				$data['categories'][$category['category_id']] = array(// <--lightshop change this
            
					'name'     => $category['name'],

					'column'     => $category['column'],
            
					'children' => $children_data,

					'have_L3' => $L3_chid,// <--lightshop add this
            
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);

				$tid = 'c'.$category['category_id'];
				$data['topcat'][$tid] = $this->url->link('product/category', 'path=' . $category['category_id']);// <--lightshop change this
            
			}
		}
		

// lightshop start
	$this->cache->set('category.categoriesdata.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.0', $data['categories']);
	$this->cache->set('category.categoriestopcat.' . (int)$this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id') . '.0', $data['topcat']);
    }
//lightshop end	

            
		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');

		$data['callback'] = $this->load->controller('extension/module/callback');		
            

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} elseif (isset($this->request->get['information_id'])) {
				$class = '-' . $this->request->get['information_id'];
			} else {
				$class = '';
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}

		$this->load->model('setting/setting');
		$this->load->model('localisation/location');
		$this->load->model('setting/store');

		$store_id = $this->config->get('config_store_id');
		$ymcode = $this->model_setting_setting->getSetting('yandex_metrika', $store_id);
		$store_configs = $this->model_setting_setting->getSetting('config', $store_id);
		$lightshop_configs = $this->model_setting_setting->getSetting('theme_lightshop', $store_id);
		$location_info = $this->model_localisation_location->getLocation($store_configs['config_location'][0]);

        if( strpos( $store_configs['config_name'], 'ОПТ') !== false) {
            $version = 2;
        } else {
            $version = 1;
        }

		$analytics = array(
			'ym'	=> '<!-- Yandex.Metrika counter -->
						<script>
						(function(m,e,t,r,i,k,a){m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
						m[i].l=1*new Date();k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)})
						(window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");
				
						ym(' . $ymcode['yandex_metrika_code'] . ', "init", {
								clickmap:true,
								trackLinks:true,
								accurateTrackBounce:true,
								webvisor:true
						});
						</script>
						<noscript><div><img src="https://mc.yandex.ru/watch/' . $ymcode['yandex_metrika_code'] . '" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
						<!-- /Yandex.Metrika counter -->'
		);

		$stores = $this->model_setting_store->getStores();
		$data['locations'] = '';

		$data['locations'][0] = array(
			'name'		=> 'Москва',
			'href'		=> 'https://mos-bruschatka.ru/'
		);

		if($stores) {
			foreach($stores as $store) {
				if( strpos( $store['name'], 'ОПТ') == false) {
					$data['locations'][] = array(
						'name'				=> ltrim($store['name'], 'Магазин'),
						'href'				=> $store['url'],
					);
				}
			}
		}

		$data['store'] = array(
			'analytics'	=> $analytics,
			'name'		=> $store_configs['config_name'],
			'phone'		=> $location_info['telephone'],
			'email'		=> $store_configs['config_email'],
			'opening'	=> $location_info['open'],
			'address'	=> $location_info['address'],
			'short_address' => $this->getShortAddress($location_info['address']),
			'comments'	=> $location_info['comment'],
			'coords'	=> $location_info['geocode'],
			'version'   => $version,
			'prices_list' => $this->url->link('custom/download', 'type=pricelist'),
		);

		$data['placeholder_name'] = $this->language->get('placeholder_name');
		$data['placeholder_phone'] = $this->language->get('placeholder_phone');
		$data['placeholder_email'] = $this->language->get('placeholder_email');
		$data['placeholder_img'] = $this->language->get('placeholder_img');

		$data['privacy_info'] = $this->load->controller('common/privacy_info');
		$data['navbar'] = $this->load->controller('common/navbar');

		
		if (isset($this->request->get['mobiheader'])){
			$this->response->setOutput($this->load->view('common/mobiheader', $data));					
		}else{
			return $this->load->view('common/header'.$data['header_type'], $data);
		}
            
	}

	public function mobiheader() {
		$data = array();
		// Analytics
		$this->load->model('extension/extension');

		$data['analytics'] = array();

		$analytics = $this->model_extension_extension->getExtensions('analytics');

		foreach ($analytics as $analytic) {
			if ($this->config->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $this->load->controller('extension/analytics/' . $analytic['code'], $this->config->get($analytic['code'] . '_status'));
			}
		}

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
		}

		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();

			// << Live Price

				if ( !$this->model_module_liveprice ) {
					$this->load->model('module/liveprice');
				}
				if ( $this->model_module_liveprice->installed() ) {
					$liveprice_custom_js = $this->model_module_liveprice->getPathToCustomJS();
					if ( $liveprice_custom_js ) {
						$this->document->addScript( $liveprice_custom_js );
					}
					$this->document->addScript( $this->model_module_liveprice->getPathToMainJS() );
					$data['liveprice_installed'] 	= true;
					$data['liveprice_settings'] 	= $this->config->get('liveprice_settings');
					$data['lp_theme_name'] 				= $this->model_module_liveprice->getThemeName();
				}
				
			// >> Live Price
			

				// << Related Options
				if ( !$this->model_module_related_options ) {
					$this->load->model('module/related_options');
				}
				
				if ( $this->model_module_related_options->installed() ) {
					$this->document->addScript( $this->model_module_related_options->getScriptPathWithVersion('view/extension/related_options/js/liveopencart.select_option_toggle.js') );
					$this->document->addScript( $this->model_module_related_options->getScriptPathWithVersion('view/extension/related_options/js/liveopencart.related_options.js') );
				}
				// >> Related Options
			
		$data['scripts'] = $this->document->getScripts();

    // OCFilter start
    $data['noindex'] = $this->document->isNoindex();
    // OCFilter end
      
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');

		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		$this->load->language('common/header');
		$this->load->language('extension/theme/lightshop');
		$data['og_url'] = (isset($this->request->server['HTTPS']) ? HTTPS_SERVER : HTTP_SERVER) . substr($this->request->server['REQUEST_URI'], 1, (strlen($this->request->server['REQUEST_URI'])-1));
		$data['og_image'] = $this->document->getOgImage();

		$data['text_home'] = $this->language->get('text_home');

		// Wishlist
		if ($this->customer->isLogged()) {
			$this->load->model('account/wishlist');

			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
		} else {
			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		}

		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', true), $this->customer->getFirstName(), $this->url->link('account/logout', '', true));

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_page'] = $this->language->get('text_page');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');

		$data['home'] = $this->url->link('common/home');
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/account', '', true);
		$data['register'] = $this->url->link('account/register', '', true);
		$data['login'] = $this->url->link('account/login', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['transaction'] = $this->url->link('account/transaction', '', true);
		$data['download'] = $this->url->link('account/download', '', true);
		$data['logout'] = $this->url->link('account/logout', '', true);
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', true);
		$data['contact'] = $this->url->link('information/contact');
		$data['telephone'] = $this->config->get('config_telephone');
		
		// lightshop
		$data['text_ls_logged'] = sprintf($this->language->get('text_ls_logged'), $this->customer->getFirstName(), $this->customer->getLastName());
		$data['text_register_account'] = $this->language->get('text_register_account');
		$data['text_forgotten'] = $this->language->get('text_forgotten');
		$data['forgotten'] = $this->url->link('account/forgotten', '', true);
		$data['header_type'] = $this->config->get('theme_lightshop_header_type');
		$data['js_footorhead'] = $this->config->get('theme_lightshop_js_footorhead');
		$data['open_graph'] = $this->config->get('theme_lightshop_og');
		$data['preloader'] = $this->config->get('theme_lightshop_preloader');
		$data['google_site_verification'] = $this->config->get('theme_lightshop_google_site_verification');
		$data['yandex_verification'] = $this->config->get('theme_lightshop_yandex_verification');
		$data['phone_1'] = html_entity_decode($this->config->get('theme_lightshop_phone_1' . $this->config->get('config_language_id')), ENT_QUOTES, 'UTF-8');
		$data['phone_2'] = html_entity_decode($this->config->get('theme_lightshop_phone_2' . $this->config->get('config_language_id')), ENT_QUOTES, 'UTF-8');
		$data['custom_css'] = $this->config->get('theme_lightshop_css');
		$data['custom_js'] = $this->config->get('theme_lightshop_js');
		$data['header_text_logo'] = $this->config->get('theme_lightshop_header_text_logo');
		$data['text_items'] = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
		$data['text_header_category'] = $this->language->get('text_header_category');
		$data['text_show_more'] = $this->language->get('text_show_more');
// lightshop
		$data['language_id'] = $this->config->get('config_language_id');
		$data['header_navs'] = array();
		$header_navs = $this->config->get('theme_lightshop_header_nav');

			foreach($header_navs as $header_nav){  
				
				if (isset($header_nav['type'][0])) { 
					if(isset($header_nav['type'][0]['links'])){
						foreach($header_nav['type'][0]['links'] as $key => $link){
							if(strpos($link,':') !== false ){ continue;}
							$header_nav['type'][0]['links'][$key] = $this->url->link($link);
						}					
					}else{
						$header_nav['type'][0]['links'] = array(); 
					}
				}

					if(isset($header_nav['type'][1]['links'])){ 
						foreach($header_nav['type'][1]['links'] as $key => $link){ 
							if(strpos($link,':') !== false ){ $header_nav['type'][1]['links'][$key] = current($data['top_links'][$key]); continue;}
							$header_nav['type'][1]['links'][$key] = $this->url->link($link); 
//							$header_nav['type'][1]['links'][$key] = current($data['top_links'][$key]); 
						}					
					}
				$data['header_navs'][$header_nav['sort']] = $header_nav;
			}
		ksort($data['header_navs']);

		$data['top_links'] = array();
		if($this->config->get('theme_lightshoplinks_array')){
		$data['top_links'] = $this->config->get('theme_lightshoplinks_array');
		$data['top_links'] = $data['top_links'][$this->config->get('config_language_id')];
		}
		foreach($data['top_links'] as $key => $link){ 
			$data['top_links'][$key][key($link)] = $this->url->link(current($link));	
		}	

		//Основное меню
		$data['main_navs'] = array();
		$main_navs = $this->config->get('theme_lightshop_main_nav');
		if(isset($main_navs)){
				foreach($main_navs as $main_nav){
					$data['main_navs'][$main_nav['sort']] = $main_nav;
				}
			ksort($data['main_navs']);	
			foreach($data['main_navs'] as $key => $main_nav){ 	
				foreach($main_nav['type'] as $key1 => $typeLink){ 
					if (isset($main_nav['type'][$key1]['links'])){
						foreach($main_nav['type'][$key1]['links'] as $key2 => $link){ 
							$data['main_navs'][$key]['type'][$key1]['links'][$key2] = $this->url->link($link);	
						}							
					}	
				}	

			}				
		}

		
		//ПРАВЫЙ ЭЛЕМЕНТ ПОДМЕНЮ КАТЕГОРИИ
		$this->load->model('catalog/product');
		$this->load->model('tool/image');		
		$data['main_recs'] = array();
		$data['main_prods'] = array();
		$main_recs = $this->config->get('theme_lightshop_main_rec');

			if(isset($main_recs)){
				foreach($main_recs as $main_rec){
					$data['main_recs'][$main_rec['category_id']] = $main_rec;		
					if(!$main_rec['settype']){
						foreach($main_rec['type'][0]['links'] as $prodId => $product){
							$product_info = $this->model_catalog_product->getProduct($prodId);
							if ($product_info['image']) {
								$thumb = $this->model_tool_image->lightshop_resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_main_rec_width'), $this->config->get($this->config->get('config_theme') . '_image_main_rec_height'));
							} else {
								$thumb = '';
							}
							if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
								$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
							} else {
								$price = false;
							}
							if ((float)$product_info['special']) {
								$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
							} else {
								$special = false;
							}
							$data['main_prods'][$main_rec['category_id']][] = array(
														'thumb'       => $thumb,
														'name'        => $product_info['name'],	
														'price'       => $price,
														'special'     => $special,
														'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])							
							);
						}
					}
				}				
			}

//		var_dump($data['main_prods']);	die; 

//lightshop end

		
		if (is_file(DIR_IMAGE . $this->config->get('theme_lightshop_header_logo'))) {
			$data['header_logo'] = $server . 'image/' . $this->config->get('theme_lightshop_header_logo');
		} else {
			$data['header_logo'] = '';
		}
		if (is_file(DIR_IMAGE . $this->config->get('theme_lightshop_fav_16'))) {
			$data['fav_16'] = $server . 'image/' . $this->config->get('theme_lightshop_fav_16');
		} else {
			$data['fav_16'] = '';
		}
		if (is_file(DIR_IMAGE . $this->config->get('theme_lightshop_fav_32'))) {
			$data['fav_32'] = $server . 'image/' . $this->config->get('theme_lightshop_fav_32');
		} else {
			$data['fav_32'] = '';
		}
		if (is_file(DIR_IMAGE . $this->config->get('theme_lightshop_fav_180'))) {
			$data['fav_180'] = $server . 'image/' . $this->config->get('theme_lightshop_fav_180');
		} else {
			$data['fav_180'] = '';
		}
		$data['callback_status'] = $this->config->get('theme_lightshop_callback_status');
		$data['schema'] = $this->config->get('theme_lightshop_schema');
		
		// lightshop end

		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
// lightshop					
					$children2_data = array();
					$children2 = $this->model_catalog_category->getCategories($child['category_id']);
					foreach ($children2 as $child2) {					
						
						$filter_data = array(
							'filter_category_id'  => $child2['category_id'],
							'filter_sub_category' => true
						);
						// Level 3
						$children2_data[$child2['category_id']] = array(
							'name'  => $child2['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
							'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $child2['category_id'])
						);
					}					
					
//lightshop end					
					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);
					// Level 2
					$children_data[$child['category_id']] = array(// <--lightshop change this
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id']),
						'children' => $children2_data // <--lightshop add this
					);
				}

				// Level 1
				$data['categories'][$category['category_id']] = array(// <--lightshop change this
					'name'     => $category['name'],
					'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
				$data['topcat'][$tid] = $this->url->link('product/category', 'path=' . $category['category_id']);// <--lightshop change this
			}
		}

		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');		

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} elseif (isset($this->request->get['information_id'])) {
				$class = '-' . $this->request->get['information_id'];
			} else {
				$class = '';
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}		
		$this->response->setOutput($this->load->view('common/mobiheader', $data));		 
	}
	
// lightshop
	public function getCompareData() {
		$this->load->language('product/compare');
		$this->load->model('tool/image');
		$this->load->language('common/header');
		$this->load->language('extension/theme/lightshop');
		$json = array();

		

		if (!isset($this->session->data['compare'])) {
			$this->session->data['compare'] = array();
		}

		$this->load->model('catalog/product');

		$data = array();

		foreach ($this->session->data['compare'] as $key => $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);

			if ($product_info) {
				if ($product_info['image']) {
					$image = $this->config->get('theme_lightshop_image_compare_resize') ? $this->model_tool_image->lightshop_resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_compare_width'), $this->config->get($this->config->get('config_theme') . '_image_compare_height')) : $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_compare_width'), $this->config->get($this->config->get('config_theme') . '_image_compare_height')); // lightshop
				} else {
					$image = false;
				}

				$data[$product_id] = array(
					'product_id'   => $product_info['product_id'],
					'name'         => $product_info['name'],
					'thumb'        => $image,
					'href'         => $this->url->link('product/product', 'product_id=' . $product_id)
				);
			}
		}
		return $data;
	}
	
	public function getWishData() {
		$data = array();

		$this->load->language('account/wishlist');

		$this->load->model('account/wishlist');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');
		$this->load->language('extension/theme/lightshop');

		$results = $this->model_account_wishlist->getWishlistLb();

		foreach ($results as $result) {
			$product_info = $this->model_catalog_product->getProduct($result['product_id']);

			if ($product_info) {

				// lightshop
				if ($this->config->get('theme_lightshop_image_wishlist_resize')) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->lightshop_resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_wishlist_width'), $this->config->get($this->config->get('config_theme') . '_image_wishlist_height'));
					} else {
						$image = $this->model_tool_image->lightshop_resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_wishlist_width'), $this->config->get($this->config->get('config_theme') . '_image_wishlist_height'));
					}
					} else {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_wishlist_width'), $this->config->get($this->config->get('config_theme') . '_image_wishlist_height'));
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_wishlist_width'), $this->config->get($this->config->get('config_theme') . '_image_wishlist_height'));
					}
				}
				

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				if ((float)$product_info['special']) {
					$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				$data[$product_info['product_id']] = array(
					'product_id' => $product_info['product_id'],
					'thumb'      => $image,
					'name'       => $product_info['name'],
					'href'       => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
				);
			} 
		}
		return $data;
	}
	public function getwish() {
		$this->load->language('extension/theme/lightshop');
		$data['text_islogged'] = sprintf($this->language->get('text_islogged'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true), $this->url->link('account/wishlist'));
		$data['text_empty_wish'] = $this->language->get('text_empty_wish');
		$data['text_empty_compare'] = $this->language->get('text_empty_compare');
		$data['text_lightshop_wish_head'] = $this->language->get('text_lightshop_wish_head');
		$data['text_compare_href'] = sprintf($this->language->get('text_compare_href'), $this->url->link('product/compare'));
		$data['text_wish_href'] = sprintf($this->language->get('text_wish_href'), $this->url->link('account/wishlist'));
		$data['islogged'] = false;
		$data['productswish'] = array();
		
		if ($this->customer->isLogged() || $this->config->get('theme_lightshop_wishlist')) {
			$data['islogged'] = true;
		}

		$data['productswish'] = $this->getWishData();
		$data['count'] = count($data['productswish']);
		$this->response->setOutput($this->load->view('account/wish_head', $data));
	}

	
	public function getcompare() {
		$this->load->language('extension/theme/lightshop');
		$data['text_islogged'] = sprintf($this->language->get('text_islogged'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true), $this->url->link('account/wishlist'));
		$data['text_empty_wish'] = $this->language->get('text_empty_wish');
		$data['text_empty_compare'] = $this->language->get('text_empty_compare');
		$data['text_lightshop_comp_head'] = $this->language->get('text_lightshop_comp_head');
		$data['text_compare_href'] = sprintf($this->language->get('text_compare_href'), $this->url->link('product/compare'));
		$data['text_wish_href'] = sprintf($this->language->get('text_wish_href'), $this->url->link('account/wishlist'));
		$data['productscomp'] = $this->getCompareData();
		$data['countcomp'] = count($data['productscomp']);
		$this->response->setOutput($this->load->view('product/compare_head', $data));
	}
	
	public function getwishcompare() {
		$json = array();
		$productscomp = $this->getCompareData();
		$countcomp = count($productscomp);

		$productswish = $this->getWishData(); 
		$count = count($productswish);
		$json['counTotall'] = $countcomp+$count;
		$this->response->setOutput(json_encode($json)); 
	}

	public function getbrightness($color) {
		$tone = false;
		list($r, $g, $b) = array_map('hexdec',str_split($color,2)); 
		$Y = (0.3*$r) + (0.59*$g) + (0.11*$b);
		if ($Y > 128) {
			$tone = true;
		}
		return $tone ;
	}
// lightshop end
            

    private function getShortAddress($address)
    {
        $addressParts = explode(',', $address);

        return sprintf('%s %s', $addressParts[2], $addressParts[3]);
    }
}
