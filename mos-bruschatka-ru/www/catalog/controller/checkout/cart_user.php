<?php

class ControllerCheckoutCartUser extends Controller {
	public function index() {
		$json = array();

		if($_SERVER['REQUEST_METHOD'] === 'POST') {
			foreach($_POST as $input_name => $input_value) {
				$json['data'][$input_name] = $input_value;
	
				if($input_name == 'name') {
					if(!strlen($input_value) || !preg_match("/^[a-zA-Z'-А-Яа-я]+$/", $input_value) || empty($input_name)) {
						$json['error'][$input_name] = 'Bad name';
					}
				}
	
				if($input_name == 'phone') {
					if(empty($input_value)) {
						$json['error'][$input_name] = 'Bad phone number';
					}
				}
	
				if($input_name === 'delivery') {
					foreach($input_value as $del_input => $del_value) {
						if($del_input !== 'comment') {
							if(!strlen($del_value)) {
								$json['error']['delivery[' . $del_input . ']'] = true;
							}
						}
					}
				}
	
				if($input_name === 'email') {
					if(!preg_match($this->config->get('config_mail_regexp'), $input_value)) {
						$json['error'][$input_name] = 'E-майл не верно';
					}
				}
			}
		}

		if($json['data'] && !$json['error']) {
			$this->load->model('checkout/cart_user');
			$this->model_checkout_cart_user->addOrUpdateCartUser($json['data']);
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function submitOrder() {
		$json = array();
		$this->load->language('checkout/cart');
		$this->load->language('checkout/checkout');
		$this->load->model('checkout/cart_user');

		$user_info = $this->model_checkout_cart_user->getUser();
		$json['user'] = $user_info;

		if ($this->customer->isLogged()) {
			$this->load->model('account/customer');

			$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());

			$order_data['customer_id'] = $this->customer->getId();
			$order_data['customer_group_id'] = $customer_info['customer_group_id'];
			$order_data['firstname'] = $customer_info['firstname'];
			$order_data['lastname'] = $customer_info['lastname'];
			$order_data['email'] = $customer_info['email'];
			$order_data['telephone'] = $customer_info['telephone'];
			$order_data['fax'] = $customer_info['fax'];
			$order_data['custom_field'] = json_decode($customer_info['custom_field'], true);
		} else {
			$order_data['customer_id'] = 0;
			$order_data['customer_group_id'] = 0;
			$order_data['firstname'] = $user_info['name'];
			$order_data['lastname'] = '';
			$order_data['email'] = $user_info['email'];
			$order_data['telephone'] = $user_info['phone'];
			$order_data['fax'] = '';
			$order_data['custom_field'] = array();
			$this->session->data['guest']['firstname'] = $user_info['name'];
			$this->session->data['guest']['lastname'] = '';
		}

		$order_data['payment_firstname'] = $order_data['firstname'];
		$order_data['payment_lastname'] = '';
		$order_data['payment_company'] = '';
		$order_data['payment_address_1'] = $user_info['delivery']['oblast'] . $user_info['delivery']['city'] . $user_info['delivery']['street'] . $user_info['delivery']['street'];
		$order_data['payment_address_2'] = '';
		$order_data['payment_city'] = $user_info['delivery']['city'];
		$order_data['payment_postcode'] = '';
		$order_data['payment_zone'] = $user_info['delivery']['oblast'];
		$order_data['payment_zone_id'] = '';
		$order_data['payment_country'] = '';
		$order_data['payment_country_id'] = '';
		$order_data['payment_address_format'] = '';
		$order_data['payment_custom_field'] = '';
		$order_data['payment_method'] = 'Безналичный';
		$order_data['payment_code'] = '';
		$order_data['shipping_firstname'] = $order_data['firstname'];
		$order_data['shipping_lastname'] = '';
		$order_data['shipping_company'] = '';
		$order_data['shipping_address_1'] = $user_info['delivery']['oblast'] . $user_info['delivery']['city'] . $user_info['delivery']['street'] . $user_info['delivery']['street'];
		$order_data['shipping_address_2'] = '';
		$order_data['shipping_city'] = $user_info['delivery']['city'];
		$order_data['shipping_postcode'] = '';
		$order_data['shipping_zone'] = $user_info['delivery']['oblast'];
		$order_data['shipping_zone_id'] = '';
		$order_data['shipping_country'] = '';
		$order_data['shipping_country_id'] = '';
		$order_data['shipping_address_format'] = '';
		$order_data['shipping_custom_field'] = array();
		$order_data['shipping_method'] = 'Безналичный';
		$order_data['shipping_code'] = '';
		
		$order_data['products'] = array();

		foreach ($this->cart->getProducts() as $product) {
			$option_data = array();

			foreach ($product['option'] as $option) {
				$option_data[] = array(
					'product_option_id'       => $option['product_option_id'],
					'product_option_value_id' => $option['product_option_value_id'],
					'option_id'               => $option['option_id'],
					'option_value_id'         => $option['option_value_id'],
					'name'                    => $option['name'],
					'value'                   => $option['value'],
					'type'                    => $option['type']
				);
			}

			$order_data['products'][] = array(
				'product_id' => $product['product_id'],
				'name'       => $product['name'],
				'model'      => $product['model'],
				'option'     => $option_data,
				'download'   => $product['download'],
				'quantity'   => $product['quantity'],
				'subtract'   => $product['subtract'],
				'price'      => $product['price'],
				'total'      => $product['total'],
				'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
				'reward'     => $product['reward']
			);
		}

		// Gift Voucher
		$order_data['vouchers'] = array();

		if (!empty($this->session->data['vouchers'])) {
			foreach ($this->session->data['vouchers'] as $voucher) {
				$order_data['vouchers'][] = array(
					'description'      => $voucher['description'],
					'code'             => token(10),
					'to_name'          => $voucher['to_name'],
					'to_email'         => $voucher['to_email'],
					'from_name'        => $voucher['from_name'],
					'from_email'       => $voucher['from_email'],
					'voucher_theme_id' => $voucher['voucher_theme_id'],
					'message'          => $voucher['message'],
					'amount'           => $voucher['amount']
				);
			}
		}

		// Totals
		$this->load->model('extension/extension');

		$totals = array();
		$taxes = $this->cart->getTaxes();
		$total = 0;

		// Because __call can not keep var references so we put them into an array. 			
		$total_data = array(
			'totals' => &$totals,
			'taxes'  => &$taxes,
			'total'  => &$total
		);

		// Display prices
		if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
			$sort_order = array();

			$results = $this->model_extension_extension->getExtensions('total');

			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}

			array_multisort($sort_order, SORT_ASC, $results);

			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('extension/total/' . $result['code']);

					// We have to put the totals in an array so that they pass by reference.
					$this->{'model_extension_total_' . $result['code']}->getTotal($total_data);
				}
			}

			$sort_order = array();

			foreach ($totals as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $totals);
			$order_data['totals'] = $totals;
		}

		$order_data['comment'] = $user_info['delivery']['comment'];
		$order_data['total'] = $total_data['total'];
		$order_data['affiliate_id'] = 0;
		$order_data['commission'] = 0;
		$order_data['marketing_id'] = 0;
		$order_data['tracking'] = '';
		$order_data['language_id'] = $this->config->get('config_language_id');
		$order_data['currency_id'] = $this->currency->getId($this->session->data['currency']);
		$order_data['currency_code'] = $this->session->data['currency'];
		$order_data['currency_value'] = $this->currency->getValue($this->session->data['currency']);
		$order_data['ip'] = $this->request->server['REMOTE_ADDR'];
		$order_data['forwarded_ip'] = '';
		$order_data['user_agent'] = '';
		$order_data['accept_language'] = '';
		$order_data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
		$order_data['store_id'] = $this->config->get('config_store_id');
		$order_data['store_name'] = $this->config->get('config_name');
		$order_data['roistat_visit'] = isset($_COOKIE['roistat_visit']) ? $_COOKIE['roistat_visit'] : null;
		
		if ($order_data['store_id']) {
			$order_data['store_url'] = $this->config->get('config_url');
		} else {
			if ($this->request->server['HTTPS']) {
				$order_data['store_url'] = HTTPS_SERVER;
			} else {
				$order_data['store_url'] = HTTP_SERVER;
			}
		}

		$json['roistat_data'] = $order_data;
		
		$this->load->model('checkout/order');

		$this->session->data['order_id'] = $this->model_checkout_order->addOrder($order_data);
	
		$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], 1);
		if (isset($this->session->data['order_id'])) {
			$this->cart->clear();

			// Add to activity log
			if ($this->config->get('config_customer_activity')) {
				$this->load->model('account/activity');

				if ($this->customer->isLogged()) {
					$activity_data = array(
						'customer_id' => $this->customer->getId(),
						'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName(),
						'order_id'    => $this->session->data['order_id']
					);

					$this->model_account_activity->addActivity('order_account', $activity_data);
				} else {
					$activity_data = array(
						'name'     => $this->session->data['guest']['firstname'] . ' ' . $this->session->data['guest']['lastname'],
						'order_id' => $this->session->data['order_id']
					);

					$this->model_account_activity->addActivity('order_guest', $activity_data);
				}
			}

		}

		$json['success'] = '1';
		$json['total'] = 0;
		$json['redirect'] = $this->url->link('checkout/success');

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	function test_input($data) {
		$data = trim($data);
		$data = stripslashes($data);
		$data = htmlspecialchars($data);
		return $data;
	}
}