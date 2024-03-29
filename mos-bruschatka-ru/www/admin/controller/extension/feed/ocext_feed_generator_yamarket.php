<?php
class ControllerExtensionFeedOcextFeedGeneratorYaMarket extends Controller {
    
	private $this_version = '4.0.0.0';
        private $this_extension = 'ocext_feed_generator_yamarket';
        private $this_ocext_host = 'oc2101.ocext';
        private $error;
        public $debug = 0;


        public function index() {
            
		$this->load->language('extension/feed/ocext_feed_generator_yamarket');
                
                $setting_product_id = 0;
                if(isset($this->request->get['product_id'])){
                    $setting_product_id = (int)$this->request->get['product_id'];
                }
                $data['setting_product_id'] = $setting_product_id;
                
                $data['setting_type'] = 'template_setting';
                if($setting_product_id){
                    $data['setting_type'] = 'product_setting';
                }
                
		$this->document->setTitle($this->language->get('heading_title'));
                
                $this->load->model('extension/feed/ocext_feed_generator_yamarket');
                
                
                
		
		$this->load->model('setting/setting');	
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
                    
                        $url = '';
                    
                        if(isset($this->request->get['template_setting'])){
                            $this->model_extension_feed_ocext_feed_generator_yamarket->setSettings($this->request->post);
                            $this->session->data['success'] = $this->language->get('text_success');
                            
                            $this->response->redirect($this->url->link('extension/feed/ocext_feed_generator_yamarket', $url.'&token=' . $this->session->data['token'], 'SSL'));
                            
                        }elseif(isset ($this->request->get['general_setting'])){
                            
                            $this->model_setting_setting->editSetting('ocext_feed_generator_yamarket', $this->request->post);
                            $this->session->data['success'] = $this->language->get('text_success');
                            
                            $this->response->redirect($this->url->link('extension/feed/ocext_feed_generator_yamarket', $url.'&token=' . $this->session->data['token'], 'SSL'));
                            
                        }elseif(isset ($this->request->get['ym_filter_data'])){
                            
                            $delete = FALSE;
                            if(isset($this->request->post['ocext_feed_generator_yamarket_ym_filter_data_filter_data_group_id_delete']) && $this->request->post['ocext_feed_generator_yamarket_ym_filter_data_filter_data_group_id_delete']){
                                $delete = TRUE;
                            }
                            
                            if(!isset($this->request->post['ocext_feed_generator_yamarket_ym_filter_attributes'])){
                                $this->request->post['ocext_feed_generator_yamarket_ym_filter_attributes'] = array();
                            }
                            
                            if(!isset($this->request->post['ocext_feed_generator_yamarket_ym_filter_options'])){
                                $this->request->post['ocext_feed_generator_yamarket_ym_filter_options'] = array();
                            }
                            
                            if(!isset($this->request->post['ocext_feed_generator_yamarket_ym_filter_data_filter_data_group_id'])){
                                $filter_data_group_id = 0;
                            }else{
                                $filter_data_group_id = $this->request->post['ocext_feed_generator_yamarket_ym_filter_data_filter_data_group_id'];
                            }
                            
                            
                            $filter_data_name = $this->request->post['ocext_feed_generator_yamarket_ym_filter_data_filter_data_name'];
                            
                            if(!$filter_data_group_id){
                                $data['filter_datas'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getFilterDatas();
                                $filter_data_group_id = count($data['filter_datas'])+1;
                            }
                            if(!$filter_data_group_id){
                                $filter_data_group_id = 1;
                            }
                            
                            //потенциально большой объем в таблицу модуля
                            
                            $ocext_feed_generator_yamarket_ym_filter_attributes = array();
                            if(isset($this->request->post['ocext_feed_generator_yamarket_ym_filter_attributes'])){
                                $ocext_feed_generator_yamarket_ym_filter_attributes = $this->request->post['ocext_feed_generator_yamarket_ym_filter_attributes'];
                                $this->model_extension_feed_ocext_feed_generator_yamarket->setFilterData('ocext_feed_generator_yamarket_ym_filter_attributes',$ocext_feed_generator_yamarket_ym_filter_attributes,$filter_data_name,$filter_data_group_id,$delete);
                                
                            }
                            
                            //$ocext_feed_generator_yamarket_ym_filter_attributes = $this->request->post['ocext_feed_generator_yamarket_ym_filter_attributes'];
                            //$this->model_feed_ocext_feed_generator_yamarket->setFilterData('ocext_feed_generator_yamarket_ym_filter_attributes',$ocext_feed_generator_yamarket_ym_filter_attributes,$filter_data_name,$filter_data_group_id,$delete);
                            $ocext_feed_generator_yamarket_ym_filter_options = array();
                            if(isset($this->request->post['ocext_feed_generator_yamarket_ym_filter_options'])){
                                $ocext_feed_generator_yamarket_ym_filter_options = $this->request->post['ocext_feed_generator_yamarket_ym_filter_options'];
                                $this->model_extension_feed_ocext_feed_generator_yamarket->setFilterData('ocext_feed_generator_yamarket_ym_filter_options',$ocext_feed_generator_yamarket_ym_filter_options,$filter_data_name,$filter_data_group_id,$delete);
                            }
                            
                            $ocext_feed_generator_yamarket_ym_filter_manufacturers = array();
                            if(isset($this->request->post['ocext_feed_generator_yamarket_ym_filter_manufacturers'])){
                                $ocext_feed_generator_yamarket_ym_filter_manufacturers = $this->request->post['ocext_feed_generator_yamarket_ym_filter_manufacturers'];
                                $this->model_extension_feed_ocext_feed_generator_yamarket->setFilterData('ocext_feed_generator_yamarket_ym_filter_manufacturers',$ocext_feed_generator_yamarket_ym_filter_manufacturers,$filter_data_name,$filter_data_group_id,$delete);
                            }
                            
                            $ocext_feed_generator_yamarket_ym_filter_category = array();
                            if(isset($this->request->post['ocext_feed_generator_yamarket_ym_filter_category'])){
                                $ocext_feed_generator_yamarket_ym_filter_category = $this->request->post['ocext_feed_generator_yamarket_ym_filter_category'];
                                $this->model_extension_feed_ocext_feed_generator_yamarket->setFilterData('ocext_feed_generator_yamarket_ym_filter_category',$ocext_feed_generator_yamarket_ym_filter_category,$filter_data_name,$filter_data_group_id,$delete);
                            }
                            
                            //приоритет в конфигурацию
                            $this->model_setting_setting->editSetting('ocext_feed_generator_yamarket_ym_filter_prioritet', $this->request->post);
                            $this->session->data['success'] = $this->language->get('text_success');
                            
                            $this->response->redirect($this->url->link('extension/feed/ocext_feed_generator_yamarket', $url.'&token=' . $this->session->data['token'], 'SSL'));
                            
                        }elseif(isset($this->request->get['ym_categories'])){
                            $this->model_extension_feed_ocext_feed_generator_yamarket->updateYmCategories($this->request->post);
                            $this->session->data['success'] = $this->language->get('text_success');
                            
                            $this->response->redirect($this->url->link('extension/feed/ocext_feed_generator_yamarket', $url.'&token=' . $this->session->data['token'], 'SSL'));
                        }
                        
			
		}
                
                $this->load->model('extension/feed/ocext_feed_generator_yamarket');
                $data['template_setting'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getSettings($data['setting_type'],FALSE,$setting_product_id);
                
                if($data['template_setting']){

                    foreach ($data['template_setting'] as $key_template_setting => $value_template_setting) {

                        $data['template_setting'][$key_template_setting]['setting'] = json_decode($value_template_setting['setting'],TRUE);

                    }

                }
                
                $data['ocext_feed_generator_yamarket_status'] = 0;
                if($this->config->get('ocext_feed_generator_yamarket_status')){
                    $data['ocext_feed_generator_yamarket_status'] = $this->config->get('ocext_feed_generator_yamarket_status');
                }
                
                if($this->config->get('ocext_feed_generator_yamarket_ym_filter_prioritet')){
                    $data['ocext_feed_generator_yamarket_ym_filter_prioritet'] = $this->config->get('ocext_feed_generator_yamarket_ym_filter_prioritet');
                }else{
                    $data['ocext_feed_generator_yamarket_ym_filter_prioritet']['categories'] = 1;
                    $data['ocext_feed_generator_yamarket_ym_filter_prioritet']['manufacturers'] = 2;
                }
		
		
                
                

		$this->load->model('localisation/order_status');
		$fiter_order_status = array(); 
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses($fiter_order_status);
                
                $data['tab_template_setting'] = $this->language->get('tab_template_setting');
                $data['tab_general_setting'] = $this->language->get('tab_general_setting');
                $data['tab_template_setting_default'] = $this->language->get('tab_template_setting_default');
                $data['tab_template_setting_title_empty'] = $this->language->get('tab_template_setting_title_empty');
                
                $data['tab_ym_filter_data'] = $this->language->get('tab_ym_filter_data');
                $data['tab_ym_categories'] = $this->language->get('tab_ym_categories');
                
		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_content_top'] = $this->language->get('text_content_top');
		$data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$data['text_column_left'] = $this->language->get('text_column_left');
		$data['text_column_right'] = $this->language->get('text_column_right');
                $data['text_no_results'] = $this->language->get('text_no_results');
                
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
                $data['text_feed'] = $this->language->get('text_feed');
                $data['button_save'] = $this->language->get('button_save');
                $data['button_filter'] = $this->language->get('button_filter');
                $data['button_cancel'] = $this->language->get('button_cancel'); 
                
                $data['text_template_setting_sample_setting'] = $this->language->get('text_template_setting_sample_setting');
                $data['text_ym_filter_data_categories'] = $this->language->get('text_ym_filter_data_categories');
                $data['text_ym_filter_data_manufacturers'] = $this->language->get('text_ym_filter_data_manufacturers');
                $data['text_ym_filter_data_attributes'] = $this->language->get('text_ym_filter_data_attributes');
                $data['text_ym_filter_data_options'] = $this->language->get('text_ym_filter_data_options');
                $data['text_ym_filter_data_prioritet'] = $this->language->get('text_ym_filter_data_prioritet');
                $data['text_ym_filter_data_filter_datas'] = $this->language->get('text_ym_filter_data_filter_datas');
                $data['text_ym_filter_data_new_filter'] = $this->language->get('text_ym_filter_data_new_filter');
                $data['text_ym_filter_data_new_filter_name'] = $this->language->get('text_ym_filter_data_new_filter_name');
                
                $data['text_ym_categories_filter_ym_category_last_child'] = $this->language->get('text_ym_categories_filter_ym_category_last_child');
                $data['text_ym_categories_filter_status'] = $this->language->get('text_ym_categories_filter_status');
                $data['text_ym_categories_filter_status_'] = $this->language->get('text_ym_categories_filter_status_');
                $data['text_ym_categories_filter_status_1'] = $this->language->get('text_ym_categories_filter_status_1');
                $data['text_ym_categories_filter_status_2'] = $this->language->get('text_ym_categories_filter_status_2');
                $data['text_ym_categories_filter_category_id'] = $this->language->get('text_ym_categories_filter_category_id');
                $data['text_ym_categories_filter_category_id_'] = $this->language->get('text_ym_categories_filter_category_id_');
                $data['text_ym_categories_filter_category_id_1'] = $this->language->get('text_ym_categories_filter_category_id_1');
                $data['text_ym_status_1'] = $this->language->get('text_ym_status_1');
                $data['text_ym_status_0'] = $this->language->get('text_ym_status_0');
                $data['column_ym_category_path'] = $this->language->get('column_ym_category_path');
                $data['column_ym_category_last_child'] = $this->language->get('column_ym_category_last_child');
                $data['column_category_id'] = $this->language->get('column_category_id');
                $data['column_ym_status'] = $this->language->get('column_ym_status');
                $data['text_general_setting_status'] = $this->language->get('text_general_setting_status');
                $data['text_general_setting_enable'] = $this->language->get('text_general_setting_enable');
                $data['text_general_setting_disable'] = $this->language->get('text_general_setting_disable');
                $data['text_general_setting_name'] = $this->language->get('text_general_setting_name');
                $data['text_general_setting_company'] = $this->language->get('text_general_setting_company');
                $data['text_general_setting_yml_currencies'] = $this->language->get('text_general_setting_yml_currencies');
                $data['text_general_setting_platform'] = $this->language->get('text_general_setting_platform');
                $data['text_general_setting_version'] = $this->language->get('text_general_setting_version');
                $data['text_general_setting_user_email'] = $this->language->get('text_general_setting_user_email');
                $data['text_general_setting_user_key'] = $this->language->get('text_general_setting_user_key');
                $data['text_general_setting_filename_export'] = $this->language->get('text_general_setting_filename_export');
                $data['text_general_setting_path_token_export'] = $this->language->get('text_general_setting_path_token_export');
                $data['text_general_setting_copy'] = $this->language->get('text_general_setting_copy');
                $data['text_general_setting_count_custom_elements'] = $this->language->get('text_general_setting_count_custom_elements');
                $data['text_general_setting_count_delivery_options'] = $this->language->get('text_general_setting_count_delivery_options');
                
                $data['text_general_setting_status'] = 'Статус модуля';
                $data['text_general_setting_filter_data_template'] = $this->language->get('text_general_setting_filter_data_template');
                $data['text_general_setting_filter_data_file_and_link'] = $this->language->get('text_general_setting_filter_data_file_and_link');
                $data['text_general_setting_filter_data_empty'] = $this->language->get('text_general_setting_filter_data_empty');
                $data['text_general_setting_content_language_id'] = $this->language->get('text_general_setting_content_language_id');
                
                $data['tab_welcome_extecom'] = $this->language->get('tab_welcome_extecom');
                
                
                
                
                $data['filter_datas'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getFilterDatas();
                $data['filter_datas'][0] = $this->language->get('text_ym_filter_data_new_filter');
                $data['filter_data_group_id'] = '';
            
                
                $data['yml_currencies'] = array(
                    0 => $this->language->get('text_need_select'),
                    'EUR' => 'EUR',
                    'KZT' => 'KZT',
                    'RUB' => 'RUB',
                    'UAH' => 'UAH',
                    'USD' => 'USD'
                );
                
                $this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();
                $data['content_language_id'] = array();
                if($languages){
                    foreach ($languages as $language) {
                        $data['content_language_id'][$language['language_id']] = $language['name'];
                    }
                }
                
                $data['ocext_feed_generator_yamarket_general_setting'] = $this->config->get('ocext_feed_generator_yamarket_general_setting');
                
                if(!isset($data['ocext_feed_generator_yamarket_general_setting']['name'])){
                    $data['ocext_feed_generator_yamarket_general_setting']['name'] = '';
                }
                
                if(!isset($data['ocext_feed_generator_yamarket_general_setting']['count_custom_elements'])){
                    $data['ocext_feed_generator_yamarket_general_setting']['count_custom_elements'] = 5;
                }
                
                if(!isset($data['ocext_feed_generator_yamarket_general_setting']['count_delivery_options'])){
                    $data['ocext_feed_generator_yamarket_general_setting']['count_delivery_options'] = 5;
                }
                
                if(!isset($data['ocext_feed_generator_yamarket_general_setting']['company'])){
                    $data['ocext_feed_generator_yamarket_general_setting']['company'] = '';
                }
                
                if(!isset($data['ocext_feed_generator_yamarket_general_setting']['version'])){
                    $data['ocext_feed_generator_yamarket_general_setting']['version'] = VERSION;
                }
                
                if(!isset($data['ocext_feed_generator_yamarket_general_setting']['platform'])){
                    $data['ocext_feed_generator_yamarket_general_setting']['platform'] = 'OpenCart';
                }
                
                if(!isset($data['ocext_feed_generator_yamarket_general_setting']['user_email'])){
                    $data['ocext_feed_generator_yamarket_general_setting']['user_email'] = '';
                }
                
                if(!isset($data['ocext_feed_generator_yamarket_general_setting']['user_key'])){
                    $data['ocext_feed_generator_yamarket_general_setting']['user_key'] = '';
                }
                
                $data['filter_datas_general_setting'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getFilterDatas();
                
                foreach ($data['filter_datas_general_setting'] as $filter_data_group_id => $filter_data_name) {
                    
                    if(!isset($data['ocext_feed_generator_yamarket_general_setting']['filter_data'][$filter_data_group_id]['yml_currencies'])){
                        $data['ocext_feed_generator_yamarket_general_setting']['filter_data'][$filter_data_group_id]['yml_currencies'] = 0;
                    }

                    if(!isset($data['ocext_feed_generator_yamarket_general_setting']['filter_data'][$filter_data_group_id]['filename_export'])){
                        $data['ocext_feed_generator_yamarket_general_setting']['filter_data'][$filter_data_group_id]['filename_export'] = 'ocext_yml_feed';
                    }

                    $data['text_general_setting_empty_token'][$filter_data_group_id] = '';

                    if(!isset($data['ocext_feed_generator_yamarket_general_setting']['filter_data'][$filter_data_group_id]['path_token_export'])){
                        $data['ocext_feed_generator_yamarket_general_setting']['filter_data'][$filter_data_group_id]['path_token_export'] = rand(0, 100000);
                        $data['text_general_setting_empty_token'][$filter_data_group_id] = $this->language->get('text_general_setting_empty_token');
                    }
                    
                    if(!isset($data['ocext_feed_generator_google_general_setting']['filter_data'][$filter_data_group_id]['content_language_id'])){
                        $data['ocext_feed_generator_google_general_setting']['filter_data'][$filter_data_group_id]['content_language_id'] = $this->config->get('config_language_id');
                    }
                    
                }
                
                
                
                
                $data['token'] = $this->session->data['token'];
                
                $data['debug'] = $this->debug; 
                
                //запрос со страницы продукта - настройки продукта
                if($setting_product_id){
                    
                    return $this->load->view('extension/feed/feed_generator/ocext_feed_generator_yamarket_product_setting.tpl', $data);
                    
                }
                
                $this->load->model('catalog/category');
		$filter_categories_data = array();
		$results = $this->model_catalog_category->getCategories($filter_categories_data);
		$data['categories'] = array();
		foreach ($results as $result) {
			$data['categories'][] = array(
				'category_id' => $result['category_id'], 
				'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
			);
		}
                
                $warning = '';
                if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
                }elseif($warning){
                        $data['error_warning'] = $warning;
                } else {
			$data['error_warning'] = '';
		}
                if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

                $url = '';
                
                $ym_categories_page = 1;
                if (isset($this->request->get['ym_categories_page'])) {
                    $ym_categories_page = $this->request->get['ym_categories_page'];
                    $url .= '&ym_categories_page='.$this->request->get['ym_categories_page'];
                }
                
                $filter_category_id = NULL;
                $data['filter_category_id'] = '';
                if (isset($this->request->post['filter_category_id']) && $this->request->post['filter_category_id']!='') {
                    $url .= '&filter_category_id='.$this->request->post['filter_category_id'];
                    $filter_category_id = $this->request->post['filter_category_id'];
                    $data['filter_category_id'] = $this->request->post['filter_category_id'];
                }
                
                $ym_category_last_child = NULL;
                $data['ym_category_last_child'] = '';
                if (isset($this->request->post['ym_category_last_child']) && $this->request->post['ym_category_last_child']) {
                    $url .= '&ym_category_last_child='.$this->request->post['ym_category_last_child'];
                    $ym_category_last_child = $this->request->post['ym_category_last_child'];
                    $data['ym_category_last_child'] = $this->request->post['ym_category_last_child'];
                }
                
                $filter_ym_status = '0';
                $data['filter_ym_status'] = '0';
                if (isset($this->request->post['filter_ym_status'])) {
                    $url .= '&filter_ym_status='.$this->request->post['filter_ym_status'];
                    $filter_ym_status = $this->request->post['filter_ym_status'];
                    $data['filter_ym_status'] = $this->request->post['filter_ym_status'];
                }
                
                $config_limit_admin_pagination = $this->config->get('config_limit_admin');
                if($this->config->get('config_limit_admin')>5){
                    $config_limit_admin_pagination = 5;
                }
                
                $filter = array(
			'category_id'      => $filter_category_id,
			'ym_category_last_child'	   => $ym_category_last_child,
			'status'  => $filter_ym_status,
			'start'                => ($ym_categories_page - 1) * $config_limit_admin_pagination,
			'limit'                => $config_limit_admin_pagination
		);
                
                $data['ym_categories'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getYmCategoriesFromDb($filter);
		$ym_categories_total = $this->model_extension_feed_ocext_feed_generator_yamarket->getYmCategoriesFromDbTotal($filter);
                $pagination = new Pagination();
                $pagination->total = $ym_categories_total;
                $pagination->page = $ym_categories_page;
                $pagination->limit = $config_limit_admin_pagination;
                $pagination->text = $this->language->get('text_pagination');
                $pagination->url = $this->url->link('extension/feed/ocext_feed_generator_yamarket', 'token=' . $this->session->data['token'] . $url . '&ym_categories_page={page}', 'SSL');
                $data['pagination'] = $pagination->render();
                $data['results'] = sprintf($this->language->get('text_pagination'), ($ym_categories_total) ? (($ym_categories_page - 1) * $config_limit_admin_pagination) + 1 : 0, ((($ym_categories_page - 1) * $config_limit_admin_pagination) > ($ym_categories_total - $config_limit_admin_pagination)) ? $ym_categories_total : ((($ym_categories_page - 1) * $config_limit_admin_pagination) + $config_limit_admin_pagination), $ym_categories_total, ceil($ym_categories_total / $config_limit_admin_pagination));
                
                
                
  		$data['breadcrumbs'] = array();
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_feed'),
			'href'      => $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/feed/ocext_feed_generator_yamarket', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
                
                $data['open_tab'] = 'tab-template-setting';
                if( isset($this->request->get['general_setting'])){
                    $data['open_tab']='tab-general-setting';
                }elseif( isset($this->request->get['ym_categories_filter']) || isset($this->request->get['ym_categories_page'])){
                    $data['open_tab']='tab-ym-categories';
                }
                
                $url = '';
                $data['action_general_setting'] = $this->url->link('extension/feed/ocext_feed_generator_yamarket', $url.'&general_setting=1&token=' . $this->session->data['token'], 'SSL');
                $data['action_template_setting'] = $this->url->link('extension/feed/ocext_feed_generator_yamarket', $url.'&template_setting=1&token=' . $this->session->data['token'], 'SSL');
                $data['action_ym_filter_data'] = $this->url->link('extension/feed/ocext_feed_generator_yamarket', $url.'&ym_filter_data=1&token=' . $this->session->data['token'], 'SSL');
                $data['action_ym_categories_filter'] = $this->url->link('extension/feed/ocext_feed_generator_yamarket', $url.'&ym_categories_filter=1&token=' . $this->session->data['token'], 'SSL');
                $data['action_ym_categories'] = $this->url->link('extension/feed/ocext_feed_generator_yamarket', $url.'&ym_categories=1&token=' . $this->session->data['token'], 'SSL');
                
                
                $data['cancel'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
                
		if (version_compare(VERSION, '2.2') < 0) {
			$this->response->setOutput($this->load->view('extension/feed/ocext_feed_generator_yamarket.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('extension/feed/ocext_feed_generator_yamarket', $data));
		}
                
	}
        
        public function getTemplateSetting() {
            
            $setting_id = (int)$this->request->get['setting_id'];
            $data['setting_id'] = $setting_id;
            
            $setting_type = $this->request->get['setting_type'];
            $data['setting_type'] = $setting_type;
            
            $setting_product_id = 0;
            if(isset($this->request->get['setting_product_id'])){
                $setting_product_id = (int)$this->request->get['setting_product_id'];
            }
            $data['setting_product_id'] = $setting_product_id;
            
            $sample_setting_id = 0;
            if(isset($this->request->get['sample_setting_id'])){
                $sample_setting_id = (int)$this->request->get['sample_setting_id'];
            }
            $data['sample_setting_id'] = $sample_setting_id;
            
            $this->load->model('extension/feed/ocext_feed_generator_yamarket');
            
            if($sample_setting_id){
                
                $data['template_setting'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getSettings(FALSE,$sample_setting_id);
                
            }else{
                
                $data['template_setting'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getSettings($setting_type,$setting_id);
                
            }
            
            
            if($data['template_setting']){

                foreach ($data['template_setting'] as $value_template_setting) {

                    $data['template_setting']['setting'] = json_decode($value_template_setting['setting'],TRUE);

                }

            }else{
                
                $data['template_setting']['setting'] = array();
                
            }
            
            
                
            $data['all_template_setting'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getSettings();

            if($data['all_template_setting']){

                foreach ($data['all_template_setting'] as $key_template_setting => $value_template_setting) {

                    $data['all_template_setting'][$key_template_setting]['setting'] = json_decode($value_template_setting['setting'],TRUE);

                }

            }
            
            $data['offer_description_parts'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getOfferNameParts(TRUE);
            
            $this->load->model('localisation/stock_status');
            $fiter_stock_status = array(); 
            $stock_statuses = $this->model_localisation_stock_status->getStockStatuses($fiter_stock_status);
            $data['stock_statuses'] = array();
            if($stock_statuses){
                foreach ($stock_statuses as $stock_status_row) {
                    $data['stock_statuses'][$stock_status_row['stock_status_id']] = $stock_status_row;
                }
            }
            
            $this->load->model('localisation/currency');
            $fiter_currencies = array(); 
            $data['currencies'] = $this->model_localisation_currency->getCurrencies($fiter_currencies);
            
            $data['ocext_feed_generator_yamarket_general_setting'] = $this->config->get('ocext_feed_generator_yamarket_general_setting');
                
            if(!isset($data['ocext_feed_generator_yamarket_general_setting']['count_custom_elements'])){
                $data['ocext_feed_generator_yamarket_general_setting']['count_custom_elements'] = 5;
            }
            
            if(!isset($data['ocext_feed_generator_yamarket_general_setting']['count_delivery_options'])){
                $data['ocext_feed_generator_yamarket_general_setting']['count_delivery_options'] = 5;
            }
            
            if(!isset($data['ocext_feed_generator_yamarket_general_setting']['text_capitalize'])){
                $data['ocext_feed_generator_yamarket_general_setting']['text_capitalize'] = 0;
            }
            
            $this->load->language('extension/feed/ocext_feed_generator_yamarket');
            $data['tab_template_setting_default'] = $this->language->get('tab_template_setting_default');
            $data['text_setting_offer_name'] = $this->language->get('text_setting_offer_name');
            $data['text_setting_title'] = $this->language->get('text_setting_title');
            $data['text_setting_name_name'] = $this->language->get('text_setting_name_name');
            $data['text_setting_name_meta_title'] = $this->language->get('text_setting_name_meta_title');
            $data['text_setting_name_seo_title'] = $this->language->get('text_setting_name_meta_title');
            $data['text_setting_name_meta_h1'] = 'Meta H1 товара';
            $data['text_setting_name_seo_h1'] = 'SEO H1 товара';
            $data['text_setting_name_disable'] = 'Не выгружать';
            $data['text_setting_name_composite'] = $this->language->get('text_setting_name_composite');
            $data['text_setting_name_composite_help'] = $this->language->get('text_setting_name_composite_help');
            $data['text_setting_name_composite_element_meta_title'] = $this->language->get('text_setting_name_composite_element_meta_title');
            $data['text_setting_name_composite_element_product_id'] = $this->language->get('text_setting_name_composite_element_product_id');
            $data['text_setting_name_composite_element_model'] = $this->language->get('text_setting_name_composite_element_model');
            $data['text_setting_name_composite_element_composite'] = $this->language->get('text_setting_name_composite_element_composite');
            $data['text_setting_name_composite_element_sku'] = $this->language->get('text_setting_name_composite_element_sku');
            $data['text_setting_name_composite_element_upc'] = $this->language->get('text_setting_name_composite_element_upc');
            $data['text_setting_name_composite_element_ean'] = $this->language->get('text_setting_name_composite_element_ean');
            $data['text_setting_name_composite_element_jan'] = $this->language->get('text_setting_name_composite_element_jan');
            $data['text_setting_name_composite_element_isbn'] = $this->language->get('text_setting_name_composite_element_isbn');
            $data['text_setting_name_composite_element_mpn'] = $this->language->get('text_setting_name_composite_element_mpn');
            $data['text_setting_name_composite_element_location'] = $this->language->get('text_setting_name_composite_element_location');
            $data['text_setting_name_composite_element_manufacturer_id'] = $this->language->get('text_setting_name_composite_element_manufacturer_id');
            $data['text_setting_name_composite_element_price'] = $this->language->get('text_setting_name_composite_element_price');
            $data['text_setting_name_composite_element_weight'] = $this->language->get('text_setting_name_composite_element_weight');
            $data['text_setting_name_composite_element_length_width_height'] = $this->language->get('text_setting_name_composite_element_length_width_height');
            $data['text_setting_name_composite_element_category_id'] = $this->language->get('text_setting_name_composite_element_category_id');
            $data['text_setting_name_composite_element_option_id'] = $this->language->get('text_setting_name_composite_element_option_id');
            $data['text_setting_name_composite_element_attribute_id'] = $this->language->get('text_setting_name_composite_element_attribute_id');
            $data['text_setting_name_composite_element_self'] = $this->language->get('text_setting_name_composite_element_self');
            $data['text_setting_name_composite_element_name'] = $this->language->get('text_setting_name_composite_element_name');
            $data['text_setting_offer_composite_category_id'] = $this->language->get('text_setting_offer_composite_category_id');
            $data['text_setting_offer_composite_attribute_id_empty'] = $this->language->get('text_setting_offer_composite_attribute_id_empty');
            $data['text_setting_offer_composite_option_id_empty'] = $this->language->get('text_setting_offer_composite_option_id_empty');
            $data['text_setting_name_composite_num_element_first'] = $this->language->get('text_setting_name_composite_num_element_first');
            $data['text_setting_name_composite_num_element_next'] = $this->language->get('text_setting_name_composite_num_element_next');
            $data['text_setting_name_composite_element_composite_sort_order'] = $this->language->get('text_setting_name_composite_element_composite_sort_order');
            $data['text_setting_name_composite_element_composite_status'] = $this->language->get('text_setting_name_composite_element_composite_status');
            $data['text_template_setting_sample_setting'] = $this->language->get('text_template_setting_sample_setting');
            $data['text_setting_vendor'] = $this->language->get('text_setting_vendor');
            $data['text_setting_price_from'] = $this->language->get('text_setting_price_from');
            $data['text_setting_price_to'] = $this->language->get('text_setting_price_to');
            $data['text_setting_product_id_to'] = $this->language->get('text_setting_product_id_to');
            $data['text_setting_product_id_from'] = $this->language->get('text_setting_product_id_from');
            $data['text_setting_pickup'] = $this->language->get('text_setting_pickup');
            $data['text_setting_market_category'] = $this->language->get('text_setting_market_category');
            $data['text_setting_disable_this_product'] = $this->language->get('text_setting_disable_this_product');
            $data['text_setting_text_capitalize'] = $this->language->get('text_setting_text_capitalize');
            
            $data['text_setting_bid_field'] = $this->language->get('text_setting_bid_field');
            $data['text_setting_bid_field_to_db_1'] = $this->language->get('text_setting_bid_field_to_db_1');
            $data['text_setting_bid_field_to_db_2'] = $this->language->get('text_setting_bid_field_to_db_2');
            $data['text_setting_bid_field_to_db_3'] = $this->language->get('text_setting_bid_field_to_db_3');
            $data['text_setting_bid_field_to_db_4'] = $this->language->get('text_setting_bid_field_to_db_4');
            $data['text_setting_cbid_field'] = $this->language->get('text_setting_cbid_field');
            $data['text_setting_cbid_field_to_db_1'] = $this->language->get('text_setting_cbid_field_to_db_1');
            $data['text_setting_cbid_field_to_db_2'] = $this->language->get('text_setting_cbid_field_to_db_2');
            $data['text_setting_cbid_field_to_db_3'] = $this->language->get('text_setting_cbid_field_to_db_3');
            $data['text_setting_cbid_field_to_db_4'] = $this->language->get('text_setting_cbid_field_to_db_4');
            $data['text_setting_param_to_url'] = $this->language->get('text_setting_param_to_url');
            $data['text_setting_param_to_url_name'] = $this->language->get('text_setting_param_to_url_name');
            $data['text_setting_param_to_url_value'] = $this->language->get('text_setting_param_to_url_value');
            
            $data['text_setting_custom_elements'] = $this->language->get('text_setting_custom_elements');
            $data['text_setting_custom_elements_name_element'] = $this->language->get('text_setting_custom_elements_name_element');
            $data['text_setting_custom_elements_field_element'] = $this->language->get('text_setting_custom_elements_field_element');
            
            
            $data['text_delete'] = $this->language->get('text_delete');
            $data['text_setting_description'] = $this->language->get('text_setting_description');
            $data['text_setting_description_description']    = $this->language->get('text_setting_description_description');
            $data['text_setting_description_meta_keyword']    = $this->language->get('text_setting_description_meta_keyword');
            $data['text_setting_description_meta_title']    = $this->language->get('text_setting_description_meta_title');
            $data['text_setting_description_seo_h1']    = $this->language->get('text_setting_description_seo_h1');
            $data['text_setting_description_meta_description']    = $this->language->get('text_setting_description_meta_description');
            $data['text_setting_description_option_id']    = $this->language->get('text_setting_description_option_id');
            $data['text_setting_description_attribute_id']    = $this->language->get('text_setting_description_attribute_id');
            $data['text_setting_description_0'] = $this->language->get('text_disable');
            $data['text_enable'] = $this->language->get('text_enable');
            $data['text_disable'] = $this->language->get('text_disable');
            $data['text_setting_vendor_model'] = $this->language->get('text_setting_vendor_model');
            $data['text_setting_vendor'] = $this->language->get('text_setting_vendor');
            $data['text_setting_vendorCode'] = $this->language->get('text_setting_vendorCode');
            $data['text_setting_model'] = $this->language->get('text_setting_model');
            $data['text_disable'] = $this->language->get('text_disable');
            $data['text_enable'] = $this->language->get('text_enable');
            $data['text_need_select'] = $this->language->get('text_need_select');
            $data['text_select'] = $this->language->get('text_select');
            $data['text_all_data'] = $this->language->get('text_all_data');
            $data['text_setting_pickup'] = $this->language->get('text_setting_pickup');
            $data['text_setting_delivery_options'] = $this->language->get('text_setting_delivery_options');
            $data['text_setting_delivery_options_help'] = $this->language->get('text_setting_delivery_options_help');
            $data['text_setting_sales_notes'] = $this->language->get('text_setting_sales_notes');
            $data['text_setting_sales_notes_on_available_false'] = $this->language->get('text_setting_sales_notes_on_available_false');
            $data['text_setting_sales_notes_select'] = $this->language->get('text_setting_sales_notes_select');
            $data['text_setting_sales_notes_on_available_true'] = $this->language->get('text_setting_sales_notes_on_available_true');
            $data['text_setting_sales_notes_select_on_available_true'] = $this->language->get('text_setting_sales_notes_select_on_available_true');
            
            
            $data['text_setting_divide_on_option'] = $this->language->get('text_setting_divide_on_option');
            $data['text_setting_price_currencies_from'] = $this->language->get('text_setting_price_currencies_from');
            $data['text_setting_price_currencies_to'] = $this->language->get('text_setting_price_currencies_to');
            $data['text_setting_currencies_empty'] = $this->language->get('text_setting_currencies_empty');
            $data['text_setting_store'] = $this->language->get('text_setting_store');
            $data['text_setting_delivery'] = $this->language->get('text_setting_delivery');
            $data['text_setting_offer_available_true'] = $this->language->get('text_setting_offer_available_true');
            $data['text_setting_offer_available_false'] = $this->language->get('text_setting_offer_available_false');
            $data['text_setting_offer_stock_statuses_empty'] = $this->language->get('text_setting_offer_stock_statuses_empty');
            $data['text_setting_offer_stock_statuses_all_out_of_stock'] = $this->language->get('text_setting_offer_stock_statuses_all_out_of_stock');
            $data['text_setting_country_of_origin'] = $this->language->get('text_setting_country_of_origin');
            $data['text_setting_barcode'] = $this->language->get('text_setting_barcode');
            $data['text_setting_description'] = $this->language->get('text_setting_description');
            $data['text_setting_description_description']    = $this->language->get('text_setting_description_description');
            $data['text_setting_description_meta_keyword']    = $this->language->get('text_setting_description_meta_keyword');
            $data['text_setting_description_meta_title']    = $this->language->get('text_setting_description_meta_title');
            $data['text_setting_description_meta_description']    = $this->language->get('text_setting_description_meta_description');
            $data['text_setting_description_meta_h1']    = 'Meta H1 товара';
             
            $data['text_setting_description_option_id']    = $this->language->get('text_setting_description_option_id');
            $data['text_setting_description_attribute_id']    = $this->language->get('text_setting_description_attribute_id');
            $data['text_setting_expiry'] = $this->language->get('text_setting_expiry');
            $data['text_setting_weight'] = $this->language->get('text_setting_weight');
            $data['text_setting_dimensions'] = $this->language->get('text_setting_dimensions');
            $data['text_setting_typePrefix'] = $this->language->get('text_setting_typePrefix');
            $data['text_setting_cpa'] = $this->language->get('text_setting_cpa');
            $data['text_setting_rec'] = $this->language->get('text_setting_rec');
            $data['text_setting_fee_select'] = $this->language->get('text_setting_fee_select');
            $data['text_setting_fee_input'] = $this->language->get('text_setting_fee_input');
            $data['text_setting_zero_price'] = $this->language->get('text_setting_zero_price');
            $data['text_setting_divide_on_option_prefix'] = $this->language->get('text_setting_divide_on_option_prefix');
            $data['text_setting_divide_on_option_available_by_option_quantity'] = $this->language->get('text_setting_divide_on_option_available_by_option_quantity');
            $data['text_setting_divide_on_option_add_to_name'] = $this->language->get('text_setting_divide_on_option_add_to_name');
            $data['text_setting_divide_on_option_add_to_model'] = $this->language->get('text_setting_divide_on_option_add_to_model');
            
            
            $data['text_setting_manufacturer_warranty'] = $this->language->get('text_setting_manufacturer_warranty');
            $data['text_setting_adult'] = $this->language->get('text_setting_adult');
            $data['text_setting_age'] = $this->language->get('text_setting_age');
            $data['text_setting_age_unit_year'] = $this->language->get('text_setting_age_unit_year');
            $data['text_setting_age_unit_month'] = $this->language->get('text_setting_age_unit_month');
            $data['text_setting_oldprice'] = $this->language->get('text_setting_oldprice');
            $data['text_setting_ymlprice'] = $this->language->get('text_setting_ymlprice');
            $data['text_setting_count_pictures'] = $this->language->get('text_setting_count_pictures');
            $data['text_setting_no_pictures'] = $this->language->get('text_setting_no_pictures');
            $data['text_setting_pictures_sizes'] = $this->language->get('text_setting_pictures_sizes');
            $data['text_setting_status'] = $this->language->get('text_setting_status');
            $data['text_setting_dispublic_quantity'] = $this->language->get('text_setting_dispublic_quantity');
            $data['text_setting_available_by_quantity'] = $this->language->get('text_setting_available_by_quantity');
            $data['text_setting_url_whis_path'] = $this->language->get('text_setting_url_whis_path');
            
            
            $data['text_need_select'] = $this->language->get('text_need_select');
            $data['text_setting_attribute_sintaxis'] = $this->language->get('text_setting_attribute_sintaxis');
            $data['entry_template_setting_attribute_sintaxis_0'] = $this->language->get('entry_template_setting_attribute_sintaxis_0');
            $data['entry_template_setting_attribute_sintaxis_1'] = $this->language->get('entry_template_setting_attribute_sintaxis_1');
            $data['debug'] = $this->debug;
            $this->response->setOutput($this->load->view('extension/feed/feed_generator/ocext_feed_generator_yamarket_setting_form.tpl', $data));
            
        }
        
        public function getSettingFields() {
            $this->load->language('extension/feed/ocext_feed_generator_yamarket');
            $data['text_setting_name_composite'] = $this->language->get('text_setting_name_composite');
            $data['text_setting_name_composite_help'] = $this->language->get('text_setting_name_composite_help');
            $data['text_setting_name_composite_new_element'] = $this->language->get('text_setting_name_composite_new_element');
            $data['text_setting_name_composite_num_element'] = $this->language->get('text_setting_name_composite_num_element');
            $data['text_setting_name_composite_element_meta_title'] = $this->language->get('text_setting_name_composite_element_meta_title');
            $data['text_setting_name_composite_element_product_id'] = $this->language->get('text_setting_name_composite_element_product_id');
            $data['text_setting_name_composite_element_model'] = $this->language->get('text_setting_name_composite_element_model');
            $data['text_setting_name_composite_element_sku'] = $this->language->get('text_setting_name_composite_element_sku');
            $data['text_setting_name_composite_element_upc'] = $this->language->get('text_setting_name_composite_element_upc');
            $data['text_setting_name_composite_element_ean'] = $this->language->get('text_setting_name_composite_element_ean');
            $data['text_setting_name_composite_element_jan'] = $this->language->get('text_setting_name_composite_element_jan');
            $data['text_setting_name_composite_element_isbn'] = $this->language->get('text_setting_name_composite_element_isbn');
            $data['text_setting_name_composite_element_mpn'] = $this->language->get('text_setting_name_composite_element_mpn');
            $data['text_setting_name_composite_element_location'] = $this->language->get('text_setting_name_composite_element_location');
            $data['text_setting_name_composite_element_manufacturer_id'] = $this->language->get('text_setting_name_composite_element_manufacturer_id');
            $data['text_setting_name_composite_element_price'] = $this->language->get('text_setting_name_composite_element_price');
            $data['text_setting_name_composite_element_weight'] = $this->language->get('text_setting_name_composite_element_weight');
            $data['text_setting_name_composite_element_length_width_height'] = $this->language->get('text_setting_name_composite_element_length_width_height');
            $data['text_setting_name_composite_element_category_id'] = $this->language->get('text_setting_name_composite_element_category_id');
            $data['text_setting_name_composite_element_option_id'] = $this->language->get('text_setting_name_composite_element_option_id');
            $data['text_setting_name_composite_element_attribute_id'] = $this->language->get('text_setting_name_composite_element_attribute_id');
            $data['text_setting_name_composite_element_self'] = $this->language->get('text_setting_name_composite_element_self');
            $data['text_setting_name_composite_element_name'] = $this->language->get('text_setting_name_composite_element_name');
            $data['text_setting_offer_composite_category_id'] = $this->language->get('text_setting_offer_composite_category_id');
            $data['text_setting_offer_composite_attribute_id_empty'] = $this->language->get('text_setting_offer_composite_attribute_id_empty');
            $data['text_setting_offer_composite_option_id_empty'] = $this->language->get('text_setting_offer_composite_option_id_empty');
            $data['text_setting_name_composite_element_composite'] = $this->language->get('text_setting_name_composite_element_composite');
            $data['text_setting_name_composite_element_composite_sort_order'] = $this->language->get('text_setting_name_composite_element_composite_sort_order');
            $data['text_setting_name_composite_element_composite_status'] = $this->language->get('text_setting_name_composite_element_composite_status');
            $data['text_setting_name_composite_element_text_field'] = $this->language->get('text_setting_name_composite_element_text_field');
            $data['text_setting_name_composite_element_keywords'] = $this->language->get('text_setting_name_composite_element_keywords');
            $data['text_setting_name_composite_element_description_whis_html'] = $this->language->get('text_setting_name_composite_element_description_whis_html');
            
            
            $data['text_disable'] = $this->language->get('text_disable');
            
            $this->load->model('extension/feed/ocext_feed_generator_yamarket');
            $data['name_field'] = $this->request->get['name_field'];
            $divide_on_option_option_id = FALSE;
            if($data['name_field']=='divide_on_option_option_id'){
                $divide_on_option_option_id = TRUE;
            }
            
            $data['content_parts'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getContentParts($data['name_field'],$divide_on_option_option_id);
            $data['setting_fields'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getSettingFields($data['content_parts']);
            $data['attributes'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getAttributes();
            $data['options'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getOptions();
            
            
            
            $setting_id = (int)$this->request->get['setting_id'];
            $data['setting_id'] = $setting_id;
            
            $setting_type = $this->request->get['setting_type'];
            $data['setting_type'] = $setting_type;
            
            $sample_setting_id = 0;
            if(isset($this->request->get['sample_setting_id'])){
                $sample_setting_id = (int)$this->request->get['sample_setting_id'];
            }
            $data['sample_setting_id'] = $sample_setting_id;
            
            $this->load->model('extension/feed/ocext_feed_generator_yamarket');
            
            if($sample_setting_id){
                
                $data['template_setting'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getSettings(FALSE,$sample_setting_id);
                
            }else{
                
                $data['template_setting'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getSettings($setting_type,$data['setting_id']);
                
            }
            
            if($data['template_setting']){

                foreach ($data['template_setting'] as $value_template_setting) {

                    $data['template_setting']['setting'] = json_decode($value_template_setting['setting'],TRUE);

                }

            }else{
                
                $data['template_setting']['setting'] = array();
                
            }
            
            $data['debug'] = $this->debug;
            $this->response->setOutput($this->load->view('extension/feed/feed_generator/ocext_feed_generator_yamarket_setting_fields.tpl', $data));
        }

        private function validate() {
            
		if (!$this->user->hasPermission('modify', 'extension/feed/ocext_feed_generator_yamarket')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
                
	}
        
        public function setSettings() {
            $this->load->language('extension/feed/ocext_feed_generator_yamarket');
            $json['message'] = 'error';
            $json['text'] = $this->language->get('error_permission');
            
            //$title 
            if(isset($this->request->post['setting']['title']) && isset($this->request->post['setting']['setting_product_id']) && $this->request->post['setting']['setting_product_id']){
                
                $this->request->post['setting']['title'] = trim($this->request->post['setting']['title']);
                if(!$this->request->post['setting']['title']){
                    $title = "Product ".$this->request->post['setting']['setting_product_id'];
                    $this->request->post['setting']['title'] = $title;
                }
                
            }
            
            if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
                
                $this->load->model('extension/feed/ocext_feed_generator_yamarket');
                $this->model_extension_feed_ocext_feed_generator_yamarket->setSettings($this->request->post);
                $json['message'] = 'success';
                
            }
            $this->response->setOutput(json_encode($json));
            
        }
        
        public function getYmFilterData() {
            
            $this->load->model('extension/feed/ocext_feed_generator_yamarket');
            $this->load->language('extension/feed/ocext_feed_generator_yamarket');
            
            $data['ym_categories'] = array();
            $data['ym_manufacturers'] = array();
            $data['ym_options'] = array();
            $data['ym_attributes'] = array();
            
            
            $filter_data_group_id = 0;
            if(isset($this->request->get['filter_data_group_id'])){
                
                $filter_data_group_id = $this->request->get['filter_data_group_id'];
                
            }
            $data['filter_data_group_id'] = $filter_data_group_id;
            
            $data['filter_datas'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getFilterDatas();
            
            if(isset($this->request->get['categories'])){
                $this->load->model('catalog/category');
                $data['categories'] = $this->model_catalog_category->getCategories(0);
                $data['ym_categories'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getFilterData('ocext_feed_generator_yamarket_ym_filter_category',FALSE,$filter_data_group_id);
            }elseif(isset($this->request->get['manufacturers'])){
                $this->load->model('catalog/manufacturer');
                $data['manufacturers'] = $this->model_catalog_manufacturer->getManufacturers();
                $data['ym_manufacturers'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getFilterData('ocext_feed_generator_yamarket_ym_filter_manufacturers',FALSE,$filter_data_group_id);
            }elseif(isset($this->request->get['options'])){
                $data['options'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getOptions();
                $data['ym_options'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getFilterData('ocext_feed_generator_yamarket_ym_filter_options',FALSE,$filter_data_group_id);
            }elseif(isset($this->request->get['attributes'])){
                $data['attributes'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getAttributes();
                $data['ym_attributes'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getFilterData('ocext_feed_generator_yamarket_ym_filter_attributes',FALSE,$filter_data_group_id);
            }
            
            
            $data['tab_template_setting'] = $this->language->get('tab_template_setting');
            $data['text_ym_categories_categories_empty'] = $this->language->get('text_ym_categories_categories_empty');
            $data['text_ym_filter_data_manufacturers_empty'] = $this->language->get('text_ym_filter_data_manufacturers_empty');
            $data['text_ym_filter_data_options_empty'] = $this->language->get('text_ym_filter_data_options_empty');
            $data['text_ym_filter_data_attributes_empty'] = $this->language->get('text_ym_filter_data_attributes_empty');
            $data['text_ym_filter_data_templates_setting_empty'] = $this->language->get('text_ym_filter_data_templates_setting_empty');
            $data['text_ym_filter_data_templates_setting_0'] = $this->language->get('text_ym_filter_data_templates_setting_0');
            $data['text_ym_filter_data_categories_name'] = $this->language->get('text_ym_filter_data_categories_name');
            $data['text_ym_filter_data_manufacturers_name'] = $this->language->get('text_ym_filter_data_manufacturers_name');
            $data['text_template_setting_offer_composite_attribute_id_empty'] = $this->language->get('text_template_setting_offer_composite_attribute_id_empty');
            $data['text_template_setting_offer_composite_option_id_empty'] = $this->language->get('text_template_setting_offer_composite_option_id_empty');
            $data['text_ym_filter_data_all_data'] = $this->language->get('text_ym_filter_data_all_data');
            
            $data['text_categories_empty'] = $this->language->get('text_categories_empty');
            $data['text_manufacturers_empty'] = $this->language->get('text_manufacturers_empty');
            $data['text_attributes_empty'] = $this->language->get('text_attributes_empty');
            $data['text_options_empty'] = $this->language->get('text_options_empty');
            
            
            
            $data['setting_type'] = 'template_setting';
            $this->load->model('extension/feed/ocext_feed_generator_yamarket');
            $data['templates_setting'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getSettings($data['setting_type'],FALSE,0);

            if($data['templates_setting']){

                foreach ($data['templates_setting'] as $key_template_setting => $value_template_setting) {

                    $data['templates_setting'][$key_template_setting]['setting'] = json_decode($value_template_setting['setting'],TRUE);

                }

            }
            $this->response->setOutput($this->load->view('extension/feed/feed_generator/ocext_feed_generator_yamarket_ym_filter_data.tpl', $data));
        }
        
        public function settingFieldsYamarketGetOptOrAtr() {
            $this->load->model('extension/feed/ocext_feed_generator_yamarket');
            $data['attributes'] = array();
            $data['options'] = array();
            if(isset($this->request->get['value_selected']) && $this->request->get['value_selected']=='option_id'){
                $data['options'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getOptions();
            }elseif(isset($this->request->get['value_selected']) && $this->request->get['value_selected']=='attribute_id'){
                $data['attributes'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getAttributes();
            }
            
            $data['name_field'] = $this->request->get['name_field'];
            
            $setting_id = (int)$this->request->get['setting_id'];
            $data['setting_id'] = $setting_id;
            
            $setting_type = $this->request->get['setting_type'];
            $data['setting_type'] = $setting_type;
            
            $sample_setting_id = 0;
            if(isset($this->request->get['sample_setting_id'])){
                $sample_setting_id = (int)$this->request->get['sample_setting_id'];
            }
            $data['sample_setting_id'] = $sample_setting_id;
            
            $this->load->model('extension/feed/ocext_feed_generator_yamarket');
            
            if($sample_setting_id){
                
                $data['template_setting'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getSettings(FALSE,$sample_setting_id);
                
            }else{
                
                $data['template_setting'] = $this->model_extension_feed_ocext_feed_generator_yamarket->getSettings($setting_type,$data['setting_id']);
                
            }
            
            if($data['template_setting']){

                foreach ($data['template_setting'] as $value_template_setting) {

                    $data['setting'] = json_decode($value_template_setting['setting'],TRUE);

                }

            }else{
                
                $data['setting'] = array();
                
            }
            
            $data['debug'] = $this->debug;
            $this->response->setOutput($this->load->view('extension/feed/feed_generator/ocext_feed_generator_yamarket_setting_fields_opt_atr.tpl', $data));
            
        }
        
        public function getCategories() {
            
            $this->load->language('extension/feed/ocext_feed_generator_yamarket');
            $this->load->model('extension/feed/ocext_feed_generator_yamarket');
            $data['text_ym_categories_categories_empty'] = $this->language->get('text_ym_categories_categories_empty');
            $data['entry_set_template_all_data'] = $this->language->get('text_ym_filter_data_all_data');
            
            
            $filter = array();
            $category_not_empty = 1;
            $data['filter_name'] = '';
            if($this->request->get['filter_name']){
                $filter['filter_name'] = $this->request->get['filter_name'];
                $category_not_empty = '';
                $data['filter_name'] = 1;
            }
            $this->load->model('catalog/category');
            $data['categories'] = $this->model_catalog_category->getCategories($filter);
            $filter_ym_categories = array(
                    'category_id'      => $category_not_empty,
                    'ym_category_last_child'	   => '',
                    'status'  => '',
                    'start'                => 0,
                    'limit'                => 10000
            );
            $ym_categories = $this->model_extension_feed_ocext_feed_generator_yamarket->getYmCategoriesFromDb($filter_ym_categories);
            
            if($ym_categories){
                foreach ($ym_categories as $ym_category) {
                    if($ym_category['category_id']){
                        $ym_category['category_id'] = json_decode($ym_category['category_id'],TRUE);
                        foreach ($ym_category['category_id'] as $category_id) {
                            $data['ym_categories'][$category_id][$ym_category['ym_category_id']] = $category_id;
                        }
                    }
                }
            }
            
            $data['ym_category_id'] = (int)$this->request->get['ym_category_id'];
            $this->response->setOutput($this->load->view('extension/feed/feed_generator/ocext_feed_generator_yamarket_ym_categories_categories.tpl', $data));
        }
        
        public function getNotifications() {
                $module_name = 'extension/feed/ocext_feed_generator_yamarket';
		sleep(1);
		$this->load->language($module_name);
		$response = $this->getNotificationsCurl();
		$json = array();
		if ($response===false) {
			$json['message'] = '';
			$json['error'] = $this->language->get( 'error_notifications' );
		} else {
			$json['message'] = $response;
			$json['error'] = '';
		}
		$this->response->setOutput(json_encode($json));
	}
        
        protected function curl_get_contents($url) {
            if(function_exists('curl_version')){
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_HEADER, 0);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
                $output = curl_exec($ch);
                curl_close($ch);
                return $output;
            }else{
                $output['ru'] = 'Проверка версии недоступна. Включите php расширение - CURL на Вашем хостинге';
                $output['en'] = 'You can not check the version. Enable php extension - CURL on your hosting';
                $language_code = $this->config->get( 'config_admin_language' );
                if(isset($output[$language_code])){
                    return $output[$language_code];
                }else{
                    return $output['en'];
                }
            }
	}
        
	public function getNotificationsCurl() {
		$language_code = $this->config->get( 'config_admin_language' );
		$result = $this->curl_get_contents("http://www.".$this->this_ocext_host.".com/index.php?route=information/check_update_version&license=".HTTP_SERVER."&version_opencart=".VERSION."&version_ocext=".$this->this_version."&extension=".$this->this_extension."&language_code=$language_code");
		if (stripos($result,'<html') !== false) {
			return '';
		}
		return $result;
	}
        
        public function getWelcomeWindow(){
            
            if(function_exists('curl_version')){
                
                $language_code = $this->config->get( 'config_admin_language' );
                $url = "https://api.e-distributer.com/v1/welcome/?license=".HTTP_SERVER."&version_opencart=".VERSION."&version_ocext=".$this->this_version."&extension=".$this->this_extension."&language_code=".$language_code;
                $curl = curl_init($url);
                $curloptions = array(
                    CURLOPT_CUSTOMREQUEST  =>"GET",  
                    CURLOPT_POST           =>FALSE,      
                    CURLOPT_USERPWD     =>":",
                    CURLOPT_RETURNTRANSFER => TRUE,  
                    CURLOPT_HEADER         => FALSE,
                );
                curl_setopt_array($curl, $curloptions);
                curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false); 
                $welcome = curl_exec($curl);
                $errmsg  = curl_error($curl);
                curl_close($curl);
                if(!$errmsg){
                    
                    echo $welcome;
                    
                }
                
            }else{
                
                echo "РУС: Расширение php CURL выключено. Включите расширение, чтобы получать важную информацию об этом продукте<br>ENG: Extension php CURL off. Turn the extension to receive important information on this product<br>DE: Extension php CURL off. Turn the extension to receive important information on this product<br>FR: Extension cURL de PHP off. Tournez l'extension pour recevoir des informations importantes sur ce produit";
                
            }
            
            exit();
            
        }
        
}
?>
