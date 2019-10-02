<?php
class ControllerInformationContact extends Controller {
	public function index() {
		$this->load->language('information/contact');

		
		// lightshop
		
		if ($this->config->get('theme_lightshop_contact_meta_title' . $this->config->get('config_language_id'))) {
			$this->document->setTitle($this->config->get('theme_lightshop_contact_meta_title' . $this->config->get('config_language_id')));
		} else {
			$this->document->setTitle($this->language->get('heading_title'));
		}
		
		if ($this->config->get('theme_lightshop_contact_meta_description' . $this->config->get('config_language_id'))) {
			$this->document->setDescription($this->config->get('theme_lightshop_contact_meta_description' . $this->config->get('config_language_id')));
		}
		
		if ($this->config->get('theme_lightshop_contact_meta_keyword' . $this->config->get('config_language_id'))) {
			$this->document->setKeywords($this->config->get('theme_lightshop_contact_meta_keyword' . $this->config->get('config_language_id')));
		}
		
		// lightshop end

            

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('information/contact')
		);


		// lightshop
		$this->load->language('extension/theme/lightshop');
		$data['schema'] = $this->config->get('theme_lightshop_schema');
		$data['shop_email'] = $this->config->get('config_email');
		$data['text_lightshop_support'] = $this->language->get('text_lightshop_support');
		$data['text_lightshop_con_soc'] = $this->language->get('text_lightshop_con_soc');
		$data['phone_1'] = html_entity_decode($this->config->get('theme_lightshop_phone_1' . $this->config->get('config_language_id')), ENT_QUOTES, 'UTF-8');
		$data['phone_2'] = html_entity_decode($this->config->get('theme_lightshop_phone_2' . $this->config->get('config_language_id')), ENT_QUOTES, 'UTF-8');
		$this->load->model('setting/setting');
		$data['social_navs'] = array();
		$social_links = $this->model_setting_setting->getSetting('theme_lightshopsoclinks');
		$data['social_links'] = $social_links['theme_lightshopsoclinks_array'];
		$data['social_navs'] = $this->config->get('theme_lightshop_social_nav');	
		$data['zoom'] = $this->config->get('theme_lightshop_contact_zoom');
		$data['zoom_control'] = $this->config->get('theme_lightshop_contact_zoom_control');
		$data['api_key'] = $this->config->get('theme_lightshop_contact_api_key');
		$data['contact_map'] = $this->config->get('theme_lightshop_contact_map');
		if ($this->config->get('theme_lightshop_contact_pdata')) {
			$this->load->language('extension/theme/lightshop');
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($this->config->get('theme_lightshop_contact_pdata'));

			if ($information_info) {
				$data['text_lightshop_pdata'] = sprintf($this->language->get('text_lightshop_pdata'), $this->language->get('button_submit'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('theme_lightshop_contact_pdata'), true), $information_info['title'], $information_info['title']);
			} else {
				$data['text_lightshop_pdata'] = '';
			}
		} else {
			$data['text_lightshop_pdata'] = '';
		}
		// lightshop end

            
		$data['heading_title'] = $this->language->get('heading_title');
		$data['placeholder_name'] = $this->language->get('placeholder_name');
		$data['placeholder_phone'] = $this->language->get('placeholder_phone');

		$data['map_contact'] = $this->load->controller('custom/components/map_contact');
		$data['privacy_info'] = $this->load->controller('common/privacy_info');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('information/contact', $data));
	}
}