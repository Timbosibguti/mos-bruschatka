<?php
class ControllerCommonFooter extends Controller {
	public function index() {
		$this->load->language('common/footer');

		$this->load->model('setting/setting');
		$this->load->model('catalog/lightshopnews');
            

		$data['scripts'] = $this->document->getScripts('footer');

		// lightshop
		$this->load->language('extension/theme/lightshop');
		$data['scripts'] = $this->document->getScripts();
		$data['js_codes'] = $this->document->getScripts('js_code'); 
		$data['styles'] = $this->document->getStyles();
		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$data['version'] = $this->config->get('theme_lightshop_version');

		$data['language_id'] = $this->config->get('config_language_id');	

		$data['top_links'] = array();
		if($this->config->get('theme_lightshoplinks_array')){
			$data['top_links'] = $this->config->get('theme_lightshoplinks_array');
			$data['top_links'] = $data['top_links'][$this->config->get('config_language_id')];	
			foreach($data['top_links'] as $key => $link){ 
				if(strpos(current($link),':') !== false ){ continue;}
				$data['top_links'][$key][key($link)] = $this->url->link(current($link));	
			}		
		}
		$this->load->model('catalog/lightshop');
		$catLinks = $this->model_catalog_lightshop->createCatLinks($this->config->get('config_language_id'));
		$data['top_links'] = array_merge ($data['top_links'],$catLinks);
					
		$data['footer_navs'] = array();
		$footer_navs = $this->config->get('theme_lightshop_footer_nav');
		if(isset($footer_navs)){
			foreach($footer_navs as $footer_nav){
				
				if(isset($footer_nav['type'][0]['links'])){
					foreach($footer_nav['type'][0]['links'] as $key => $link){
						if(strpos($link,':') !== false ){$footer_nav['type'][0]['links'][$key] = current($data['top_links'][$key]); continue;}
						$footer_nav['type'][0]['links'][$key] = $this->url->link($link);
					}					
				}

				$data['footer_navs'][$footer_nav['sort']] = $footer_nav;
			}
		}
		ksort($data['footer_navs']);

		//Социальные сети
		$data['social_navs'] = array();
		$social_links = $this->model_setting_setting->getSetting('theme_lightshopsoclinks');
		$data['social_links'] = $social_links['theme_lightshopsoclinks_array'];
		$data['social_navs'] = $this->config->get('theme_lightshop_social_nav');		
		// lightshop end

            

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');

		$data['text_footer_subscribe_email'] = $this->language->get('text_footer_subscribe_email');
		$data['text_header_callback'] = $this->language->get('text_header_callback');
		$data['text_social_navs'] = $this->language->get('text_social_navs');
		$data['callback_status'] = $this->config->get('theme_lightshop_callback_status');
		$data['soc_stat'] = $this->config->get('theme_lightshop_footer_soc_stat');
		$data['phone_1'] = html_entity_decode($this->config->get('theme_lightshop_phone_1' . $this->config->get('config_language_id')), ENT_QUOTES, 'UTF-8');
		$data['phone_2'] = html_entity_decode($this->config->get('theme_lightshop_phone_2' . $this->config->get('config_language_id')), ENT_QUOTES, 'UTF-8');		
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
		$data['footer_type'] = $this->config->get('theme_lightshop_footer_type');
		$data['subscribe_status'] = $this->config->get('theme_lightshop_subscribe_status');
		$data['subscribe_title'] = $this->config->get('theme_lightshop_subscribe_title' . $this->config->get('config_language_id'));
		$data['subscribe_subtitle'] = $this->config->get('theme_lightshop_subscribe_subtitle' . $this->config->get('config_language_id'));
		$data['js_footorhead'] = $this->config->get('theme_lightshop_js_footorhead');
		$data['footer_copyright'] = html_entity_decode($this->config->get('theme_lightshop_footer_copyright' . $this->config->get('config_language_id')), ENT_QUOTES, 'UTF-8');
		$data['footer_text'] = html_entity_decode($this->config->get('theme_lightshop_footer_text' . $this->config->get('config_language_id')), ENT_QUOTES, 'UTF-8');
		$data['footer_t_logo'] = $this->config->get('theme_lightshop_footer_t_logo');
		$data['text_logo'] = html_entity_decode($this->config->get('theme_lightshop_footer_text_logo'), ENT_QUOTES, 'UTF-8');
		$data['scroll_to_top'] = $this->config->get('theme_lightshop_scrolltt_status');
		$data['scroll_to_top_pos'] = $this->config->get('theme_lightshop_scrolltt_pos');
		$data['text_lightshop_subscribe_btn'] = $this->language->get('text_lightshop_subscribe_btn');
		
			if ($this->config->get('theme_lightshop_subscribe_pdata')) {
				$this->load->model('catalog/information');

				$information_info = $this->model_catalog_information->getInformation($this->config->get('theme_lightshop_subscribe_pdata'));

				if ($information_info) {
					$data['text_lightshop_pdata'] = sprintf($this->language->get('text_lightshop_pdata'), $this->language->get('text_lightshop_subscribe_btn'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('theme_lightshop_subscribe_pdata'), true), $information_info['title'], $information_info['title']);
				} else {
					$data['text_lightshop_pdata'] = '';
				}
			} else {
				$data['text_lightshop_pdata'] = '';
			}
		
		if (is_file(DIR_IMAGE . $this->config->get('theme_lightshop_footer_logo'))) {
			$data['footer_logo'] = $server . 'image/' . $this->config->get('theme_lightshop_footer_logo');
		} else {
			$data['footer_logo'] = '';
		}
		$data['custom_css'] = $this->config->get('theme_lightshop_css');
		$data['custom_js'] = html_entity_decode($this->config->get('theme_lightshop_js'), ENT_QUOTES, 'UTF-8');
		$data['og_url'] = (isset($this->request->server['HTTPS']) ? HTTPS_SERVER : HTTP_SERVER) . substr($this->request->server['REQUEST_URI'], 1, (strlen($this->request->server['REQUEST_URI'])-1));
		$data['name'] = $this->config->get('config_name');
		$data['callback'] = $this->load->controller('extension/module/callback');

		$data['islogged'] = $this->customer->isLogged();
		$data['cookieagry'] = 0;
		if (isset($_COOKIE["cookieagry"])){
			$data['cookieagry'] = 1;
		}
		
		if ($this->config->get('theme_lightshop_cookies_pdata')) {
			$this->load->model('catalog/information');

			$information_cookies = $this->model_catalog_information->getInformation($this->config->get('theme_lightshop_cookies_pdata'));

			if ($information_cookies) {
				$data['text_lightshop_cookieagry_btn'] = sprintf($this->language->get('text_lightshop_cookieagry_btn'), html_entity_decode($information_cookies['description'], ENT_QUOTES, 'UTF-8'));
			} else {
				$data['text_lightshop_cookieagry_btn'] = '';
			}
		} else {
			$data['text_lightshop_cookieagry_btn'] = '';
		}
			
		// lightshop end

           

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}

		$data['contact'] = $this->url->link('information/contact');
		$data['return'] = $this->url->link('account/return/add', '', true);
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', true);
		$data['affiliate'] = $this->url->link('affiliate/account', '', true);
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['newsletter'] = $this->url->link('account/newsletter', '', true);
$data['yandex_metrika'] = $this->config->get('yandex_money_metrika_code') ? html_entity_decode($this->config->get('yandex_money_metrika_code'), ENT_QUOTES, 'UTF-8') : '';
            $data['yandex_money_metrika_active'] = $this->config->get('yandex_money_metrika_active') ? true : false;
            $data['yandex_money_kassa_show_in_footer'] = $this->config->get('yandex_money_kassa_enabled') && $this->config->get('yandex_money_kassa_show_in_footer');
            $data['yandex_money_product_info_url'] = 'index.php?route='.(version_compare(VERSION, "2.3.0", '>=')?"extension/":"").'payment/yandex_money/productInfo';
            

		// lightshop
		$data['home'] = $this->url->link('common/home');
		// lightshop end
            

		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
		}

		return $this->load->view('common/footer', $data);
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
            
}
