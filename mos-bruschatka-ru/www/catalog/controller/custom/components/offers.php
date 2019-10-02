<?php
class ControllerCustomComponentsOffers extends Controller {
	public function index() {
		return $this->load->view('custom/components/offers');
	}
}