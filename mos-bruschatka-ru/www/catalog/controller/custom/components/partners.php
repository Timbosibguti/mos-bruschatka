<?php
class ControllerCustomComponentsPartners extends Controller {
	public function index() {
		$this->load->model('tool/image');
		
		$data['placeholder_name'] = $this->language->get('placeholder_name');
		$data['placeholder_phone'] = $this->language->get('placeholder_phone');
		$data['placeholder_email'] = $this->language->get('placeholder_email');
		$data['placeholder_img'] = $this->language->get('placeholder_img');

		$data['thumbs'] = array();

		foreach(array(1, 2, 3, 4, 5, 6, 7, 8) as $num) {
			$temp = 'catalog/partners/' . $num . '.png';
			$data['thumbs'][] = $this->model_tool_image->getImage($temp);
		}
		
		return $this->load->view('custom/components/partners', $data);
	}
}