<?php
class ControllerCustomRequisites extends Controller {
	public function index() {
		$this->load->language('custom/requisites');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$data['privacy_info'] = $this->load->controller('common/privacy_info');
		$data['download_link'] = $this->url->link('custom/download', 'type=requisite');

		$this->response->setOutput($this->load->view('custom/requisites', $data));
	}
}
