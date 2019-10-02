<?php
class ControllerExtensionModuleHits extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/hits');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('hits', $this->request->post);
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
		$data['entry_limit'] = $this->language->get('entry_limit');
		$data['entry_width'] = $this->language->get('entry_width');
		$data['entry_height'] = $this->language->get('entry_height');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['help_product'] = $this->language->get('help_product');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
        $data['entry_module_css_class'] = $this->language->get('entry_module_css_class');

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
				'href' => $this->url->link('extension/module/hits', 'token=' . $this->session->data['token'], true)
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('extension/module/hits', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true)
			);
		}
		
		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('extension/module/hits', 'token=' . $this->session->data['token'], true);
		} else {
			$data['action'] = $this->url->link('extension/module/hits', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true);
		}

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
		
		$data['token'] = $this->session->data['token'];

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}

		if (isset($this->request->post['show_button'])) {
			$data['show_button'] = $this->request->post['show_button'];
		} elseif (!empty($module_info)) {
			$data['show_button'] = $module_info['show_button'];
		} else {
			$data['show_button'] = false;
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}

		if (isset($this->request->post['module_css_class'])) {
			$data['module_css_class'] = $this->request->post['module_css_class'];
		} elseif (!empty($module_info)) {
			$data['module_css_class'] = $module_info['module_css_class'];
		} else {
			$data['module_css_class'] = '';
		}

		$this->load->model('catalog/filter');
		$this->load->model('catalog/product');
		$this->load->model('catalog/category');

        if (isset($this->request->post['hits'])) {
            $data['hits'] = $this->assembleHitsData($this->request->post['hits']);
        } elseif (!empty($module_info)) {
            $data['hits'] = $this->assembleHitsData($module_info['hits']);
		} else {
			$data['hits'] = array();
		}

		$filters = $this->model_catalog_filter->getFilters();
		$categoryGroups = $this->model_catalog_category->getAllCategories();

		if(is_array($filters)) {
			foreach ($filters as $filter) {
				$data['options'][] = array(
					'option_value'	=> 'filter-' . $filter['filter_id'],
					'option_name'	=> $filter['name']
				);
			}
		}

		if(is_array($categoryGroups)) {
			foreach ($categoryGroups as $categories) {
				foreach ($categories as $category) {
					$data['options'][] = array(
						'option_value'	=> 'category-' . $category['category_id'],
						'option_name'	=> $category['meta_h1']
					);
				}
			}
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/hits', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/hits')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		return !$this->error;
	}

	private function assembleHitsData($hits)
    {
        $hitsData = [];

        foreach ($hits as $hit) {
            $products = [];

            foreach ($hit['products'] as $product_id) {
                $hit_product_info = $this->model_catalog_product->getProduct((int)$product_id);

                $products[] = array(
                    'product_id'	=> $hit_product_info['product_id'],
                    'name'			=> $hit_product_info['name']
                );
            }

            $hitsData[] = array(
                'option_value'	=> $hit['option_value'],
                'option_name'	=> $this->resolveHitsDataOptionName($hit['option_value']),
                'classname'		=> $hit['classname'],
                'products'		=> $products,
            );
        }

        return $hitsData;
    }

    private function resolveHitsDataOptionName($optionValue)
    {
        $item = explode('-', $optionValue);
        $itemType = $item[0];
        $itemId = (int)(isset($item[1])) ? $item[1] : $item[0];

        if($itemType == 'category') {
            return $this->model_catalog_category->getCategory($itemId)['meta_h1'];
        } else {
            return $this->model_catalog_filter->getFilter($itemId)['name'];
        }
    }
}
