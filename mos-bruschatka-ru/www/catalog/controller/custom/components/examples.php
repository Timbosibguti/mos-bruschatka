<?php
class ControllerCustomComponentsExamples extends Controller {
	public function index() {
		$data['placeholder_name'] = $this->language->get('placeholder_name');
		$data['placeholder_phone'] = $this->language->get('placeholder_phone');
		$data['placeholder_email'] = $this->language->get('placeholder_email');
		$data['placeholder_img'] = $this->language->get('placeholder_img');

		$data['images'] = array();

		for($i = 1; $i < 5; $i++) {
			$temp = 'catalog/examples/ex' . $i . '.jpeg';
			$data['images'][] = $this->model_tool_image->resize($temp, 550, 350);
		}

		return $this->load->view('custom/components/examples', $data);
	}
}