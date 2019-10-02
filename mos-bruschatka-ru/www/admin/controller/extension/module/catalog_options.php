<?php
class ControllerExtensionModuleCatalogOptions extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/catalog_options');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('catalog_options', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_show_options'] = $this->language->get('entry_show_options');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
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

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/catalog_options', 'token=' . $this->session->data['token'], true)
		);

		$this->load->model('catalog/option');
		//$results = $this->model_catalog_option->getOptions();
		$sql = "SELECT * FROM `" . DB_PREFIX . "option` o LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE od.language_id = '" . (int)$this->config->get('config_language_id') . "' AND o.type = 'select'";
		$query = $this->db->query($sql);
		$results = $query->rows;
		foreach ($results as $result) {
			$data['options'][] = array(
				'option_id'  => $result['option_id'],
				'name'       => $result['name']
			);
		}

		$data['action'] = $this->url->link('extension/module/catalog_options', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->post['catalog_options_status'])) {
			$data['catalog_options_status'] = $this->request->post['catalog_options_status'];
		} else {
			$data['catalog_options_status'] = $this->config->get('catalog_options_status');
		}

		if (isset($this->request->post['catalog_options_show_options'])) {
			$data['catalog_options_show_options'] = $this->request->post['catalog_options_show_options'];
		} elseif ($this->config->get('catalog_options_show_options')) {
			$data['catalog_options_show_options'] = $this->config->get('catalog_options_show_options');
		} else {
			$data['catalog_options_show_options'] = array(0);
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/catalog_options', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/catalog_options')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}