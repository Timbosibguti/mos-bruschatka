<?php
class ControllerCustomComponentsDelivery extends Controller {
	public function index() {
        return $this->load->view('custom/components/delivery', $data);
	}
}