<?php
class ControllerCommonPrivacyInfo extends Controller {
	public function index() {
		$data['link'] = $this->url->link('information/information', 'information_id=3', true);

		return $this->load->view('common/privacy_info', $data);
	}
}
