<?php
class ControllerCustomComponentsTechnology extends Controller {
	public function index() {
        return $this->load->view('custom/components/technology', $data);
	}
}