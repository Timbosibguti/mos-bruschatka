<?php
class ControllerExtensionModuleLightshopblog extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/lightshop_blog');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('lightshopblog', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_time'] = $this->language->get('text_time');

		$data['entry_status'] = $this->language->get('entry_status');

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
			'href' => $this->url->link('extension/module/lightshop_blog', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/lightshop_blog', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->post['lightshopblog_status'])) {
			$data['lightshopblog_status'] = $this->request->post['lightshopblog_status'];
		} else {
			$data['lightshopblog_status'] = $this->config->get('lightshopblog_status');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/lightshop_blog', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/lightshop_blog')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	public function install() {
		$this->load->model('extension/theme/lightshop');

		$this->model_extension_theme_lightshop->installBlog();

		$this->load->model('user/user_group');

		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'catalog/lightshop_blog');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'catalog/lightshop_blog');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'extension/module/lightshop_blog');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'extension/module/lightshop_blog'); 
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'catalog/lightshopblog_review');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'catalog/lightshopblog_review');  
	}

	public function uninstall() {
		$this->load->model('extension/theme/lightshop');

		$this->model_extension_theme_lightshop->uninstallBlog();
	}
}