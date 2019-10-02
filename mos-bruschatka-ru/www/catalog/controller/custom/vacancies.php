<?php
class ControllerCustomVacancies extends Controller {
	public function index() {
	
		$data['placeholder_name'] = $this->language->get('placeholder_name');
		$data['placeholder_phone'] = $this->language->get('placeholder_phone');
		$data['placeholder_email'] = $this->language->get('placeholder_email');
		$data['placeholder_email'] = $this->language->get('placeholder_email');
		$data['placeholder_img'] = $this->language->get('placeholder_img');
		$data['link_vacancy'] = $this->url->link('custom/vacancy');

		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('custom/vacancies', $data));
	}
}