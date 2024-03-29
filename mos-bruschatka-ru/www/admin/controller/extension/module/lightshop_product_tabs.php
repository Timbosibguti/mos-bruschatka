<?php
class ControllerExtensionModuleLightshopProductTabs extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/lightshop_product_tabs');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->document->addStyle('view/stylesheet/lightshop/lightshop.css?v' . $this->config->get('theme_lightshop_version'));
		
		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('lightshop_product_tabs', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_product'] = $this->language->get('entry_product');
		$data['entry_category'] = $this->language->get('entry_category');
		$data['entry_limit'] = $this->language->get('entry_limit');
		$data['entry_width'] = $this->language->get('entry_width');
		$data['entry_height'] = $this->language->get('entry_height');
		$data['entry_status'] = $this->language->get('entry_status');

		$data['help_product'] = $this->language->get('help_product');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel'); 

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		if (!isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/module/lightshop_product_tabs', 'token=' . $this->session->data['token'], true)
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/module/lightshop_product_tabs', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true)
			);
		}

		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('extension/module/lightshop_product_tabs', 'token=' . $this->session->data['token'], true);
		} else {
			$data['action'] = $this->url->link('extension/module/lightshop_product_tabs', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true);
		}

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		if (isset($this->request->post['theme_lightshop_product_tabs'])) {
			$data['theme_lightshop_product_tabs'] = $this->request->post['theme_lightshop_product_tabs'];
		} elseif (isset($module_info['theme_lightshop_product_tabs'])) {
			$data['theme_lightshop_product_tabs'] = $module_info['theme_lightshop_product_tabs'];
		} else {
			$data['theme_lightshop_product_tabs'] = array();
		}

		$data['sorts'] = array(
			'p.sort_order' => 'По умолчанию',
			'p.date_added'       => 'Дата добавления', 
			'p.viewed'           => 'Кол-во просмотров',
			'discount'           => 'Наличие акции',
			'bestseller'         => 'Лидеры продаж',
			'random'              => 'Рандом',
//			'myviewed'           => 'Просмотренные',
		);		
		
		
		$data['token'] = $this->session->data['token'];

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}
		
		
		
		

		$this->load->model('catalog/product');
		$this->load->model('catalog/category');

		$data['products'] = array();

		if (!empty($this->request->post['product'])) {
			$products = $this->request->post['product'];
		} elseif (!empty($module_info['product'])) {
			$products = $module_info['product'];
		} else {
			$products = array();
		}
		$data['products'] = array();
		$data['categories'] = array();
	if(isset($module_info['theme_lightshop_product_tabs'])){
		foreach ($module_info['theme_lightshop_product_tabs'] as $row => $tabsInfo) {
			$data['categories'][$row] = array();
			$data['products'][$row] = array();
			if(isset($tabsInfo['products'])){
			   foreach($tabsInfo['products'] as $product_id){
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					$data['products'][$row][] = array(
						'product_id' => $product_info['product_id'],
						'name'       => $product_info['name']
					);
				}
			   }
			}
			if (isset($tabsInfo['categories'])){
				foreach($tabsInfo['categories'] as $category_id){
					$category_info = $this->model_catalog_category->getCategory($category_id);

					if ($category_info) {
						$data['categories'][$row][] = array(
							'category_id' => $category_info['category_id'],
							'name'       => $category_info['name']
						);
					}
				}				
			}
		}
	}
//var_dump($data['categories']);die;
		$data['theme_lightshop_product_tabs_targets'] = array(
									'0'	=> 'Все товары магазина',
									'1' 	=> 'Выбрать товары',
									'2' 	=> 'Товары из категорий',
									'3' 	=> 'Просмотренные'
									);

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = 1;
		}

		if (isset($this->request->post['view'])) {
			$data['view'] = $this->request->post['view'];
		} elseif (!empty($module_info) && isset($module_info['view'])) {
			$data['view'] = $module_info['view'];
		} else {
			$data['view'] = '';
		}

		if (isset($this->request->post['tp_limit'])) {
			$data['tp_limit'] = $this->request->post['tp_limit'];
		} elseif (!empty($module_info) && isset($module_info['tp_limit'])) {
			$data['tp_limit'] = $module_info['tp_limit'];
		} else {
			$data['tp_limit'] = 3;
		}



		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/lightshop_product_tabs', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/lightshop_product_tabs')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		return !$this->error;
	}
}
