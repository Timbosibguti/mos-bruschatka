<?php
class ControllerCustomComponentsAssortiments extends Controller {
	public function index() {
        return $this->load->view('custom/components/assortiments', $data);
	}
}