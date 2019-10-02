<?php
class ControllerCommonAdditional extends Controller {
	public function index() {
		$this->load->language('common/additional');
		$this->load->model('checkout/cart_user');

		$data['needs'] = $this->model_checkout_cart_user->getUser()['needs'];

		$data['placeholder_img'] = $this->language->get('placeholder_img');

		return $this->load->view('common/additional', $data);
	}
}
