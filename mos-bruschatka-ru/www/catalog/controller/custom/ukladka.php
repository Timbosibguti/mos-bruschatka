<?php
class ControllerCustomUkladka extends Controller
{
	public function index()
    {
		$data['map_contact'] = $this->load->controller('custom/components/map_contact');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('custom/ukladka', $data));
	}
}
