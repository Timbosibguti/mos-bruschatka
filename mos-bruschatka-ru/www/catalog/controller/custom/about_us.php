<?php
class ControllerCustomAboutUs extends Controller {
	public function index()
    {
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['map_contact'] = $this->load->controller('custom/components/map_contact');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('custom/about_us', $data));
	}
}
