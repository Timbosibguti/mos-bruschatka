<?php
class ControllerCustomComponentsMapCustomers extends Controller {
	public function index() {
        return $this->load->view('custom/components/map_customers');
	}
}