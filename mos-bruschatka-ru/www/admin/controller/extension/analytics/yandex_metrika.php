<?php
class ControllerExtensionAnalyticsYandexMetrika extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/analytics/yandex_metrika');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('yandex_metrika', $this->request->post, $this->request->get['store_id']);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=analytics', true));
		}
		
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_help'] = $this->language->get('text_help');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_no_users'] = $this->language->get('text_no_users');
		$data['text_no_admin'] = $this->language->get('text_no_admin');
		
		$data['entry_code'] = $this->language->get('entry_code');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_no_admin'] = $this->language->get('entry_no_admin');
		$data['entry_no_users'] = $this->language->get('entry_no_users');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['code'])) {
			$data['error_code'] = $this->error['code'];
		} else {
			$data['error_code'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=analytics', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/analytics/yandex_metrika', 'token=' . $this->session->data['token'] . '&store_id=' . $this->request->get['store_id'], true)
		);

		$data['action'] = $this->url->link('extension/analytics/yandex_metrika', 'token=' . $this->session->data['token'] . '&store_id=' . $this->request->get['store_id'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=analytics', true);
		
		$data['token'] = $this->session->data['token'];

		if (isset($this->request->get['store_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$setting_info = $this->model_setting_setting->getSetting('yandex_metrika', $this->request->get['store_id']);
		}

		if (isset($this->request->post['yandex_metrika_code'])) {
			$data['yandex_metrika_code'] = $this->request->post['yandex_metrika_code'];
		} else {
			$data['yandex_metrika_code'] = $this->config->get('yandex_metrika_code');
		}
		
		if (isset($this->request->post['yandex_metrika_status'])) {
			$data['yandex_metrika_status'] = $this->request->post['yandex_metrika_status'];
		} else {
			$data['yandex_metrika_status'] = $this->config->get('yandex_metrika_status');
		}

		if (isset($this->request->post['yandex_metrika_no_admin'])) {
			$data['yandex_metrika_no_admin'] = $this->request->post['yandex_metrika_no_admin'];
		} elseif (isset($setting_info['yandex_metrika_no_admin'])) {
			$data['yandex_metrika_no_admin'] = $setting_info['yandex_metrika_no_admin'];
		} else {
			$data['yandex_metrika_no_admin'] = '';
		}
		
		if (isset($this->request->post['yandex_metrika_no_users'])) {
			$data['yandex_metrika_no_users'] = $this->request->post['yandex_metrika_no_users'];
		} elseif (isset($setting_info['yandex_metrika_no_users'])) {
			$data['yandex_metrika_no_users'] = $setting_info['yandex_metrika_no_users'];
		} else {
			$data['yandex_metrika_no_users'] = '';
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/analytics/yandex_metrika', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/analytics/yandex_metrika')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['yandex_metrika_code']) {
			$this->error['code'] = $this->language->get('error_code');
		}			

		return !$this->error;
	}
}
