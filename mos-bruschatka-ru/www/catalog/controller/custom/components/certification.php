<?php
class ControllerCustomComponentsCertification extends Controller {
	public function index() {
		$data['placeholder_name'] = $this->language->get('placeholder_name');
		$data['placeholder_phone'] = $this->language->get('placeholder_phone');
		$data['placeholder_email'] = $this->language->get('placeholder_email');
		$data['placeholder_img'] = $this->language->get('placeholder_img');

		$data['privacy_info'] = $this->load->controller('common/privacy_info');
		
		return $this->load->view('custom/components/certification', $data);
	}
}