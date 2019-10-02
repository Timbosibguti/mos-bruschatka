<?php
class ControllerCustomComponentsAboutVideo extends Controller {
	public function index() {
		$data['about_video_active'] = false;
		
        return $this->load->view('custom/components/about_video', $data);
	}
}