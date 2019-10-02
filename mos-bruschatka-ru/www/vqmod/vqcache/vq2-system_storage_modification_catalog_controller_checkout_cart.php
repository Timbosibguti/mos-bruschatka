<?php

use Cart\Length;
class ControllerCheckoutCart extends Controller {
	public function index() {
		$this->load->language('checkout/cart');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home'),
			'text' => $this->language->get('text_home')
		);

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('checkout/cart'),
			'text' => $this->language->get('heading_title')
		);


		// lightshop

			if ($this->config->get($this->config->get('theme_lightshop_config_captcha_fo') . '_status')) {
				$data['captcha_fo'] = $this->load->controller('extension/captcha/' . $this->config->get('theme_lightshop_config_captcha_fo'));
			} else {
				$data['captcha_fo'] = '';
			}
			
		$this->load->language('extension/theme/lightshop'); 
		$data['schema'] = $this->config->get('theme_lightshop_schema');
			$data['button_fastorder_sendorder'] = $this->language->get('button_lighshop_sendorder');
			$data['text_lightshop_fast_order'] = $this->language->get('text_lightshop_fast_order');
			$data['text_fastorder_name'] = $this->language->get('text_lighshop_name');
			$data['text_fastorder_phone'] = $this->language->get('text_lighshop_phone');
			$data['text_fastorder_comment'] = $this->language->get('text_lighshop_comment');
			if ($this->config->get('theme_lightshop_buy_click_pdata')) {
				$this->load->language('extension/theme/lightshop');
				$this->load->model('catalog/information');

				$information_info = $this->model_catalog_information->getInformation($this->config->get('theme_lightshop_buy_click_pdata'));

				if ($information_info) {
					$data['text_lightshop_pdata'] = sprintf($this->language->get('text_lightshop_pdata'), $this->language->get('button_lighshop_sendorder'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('theme_lightshop_buy_click_pdata'), true), $information_info['title'], $information_info['title']);
				} else {
					$data['text_lightshop_pdata'] = '';
				}
			} else {
				$data['text_lightshop_pdata'] = '';
			}
			
			$data['buy_click'] = array();
			if($this->config->get('theme_lightshop_buy_click')){
				$data['buy_click'] = $this->config->get('theme_lightshop_buy_click');
				if ($this->customer->isLogged()) {
					$this->load->model('account/customer');
					$data['customer_info'] = $this->model_account_customer->getCustomer($this->customer->getId());
				}
			}
			$data['language_id'] = $this->config->get('config_language_id');

			$this->load->language('checkout/checkout');
			$data['entry_firstname'] = $this->language->get('entry_firstname');
			$data['entry_lastname'] = $this->language->get('entry_lastname');
			$data['entry_email'] = $this->language->get('entry_email');
			$data['entry_telephone'] = $this->language->get('entry_telephone');
			$data['entry_comment'] = $this->language->get('entry_comment');
		// lightshop end
		
            
		if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_recurring_item'] = $this->language->get('text_recurring_item');
			$data['text_next'] = $this->language->get('text_next');
			$data['text_next_choice'] = $this->language->get('text_next_choice');
			$data['text_model'] = $this->language->get('text_model');

			$data['placeholder_img'] = $this->language->get('placeholder_img');
			$data['placeholder_name'] = $this->language->get('placeholder_name');
			$data['placeholder_phone'] = $this->language->get('placeholder_phone');
			$data['placeholder_email'] = $this->language->get('placeholder_email');

			$data['column_image'] = $this->language->get('column_image');
			$data['column_name'] = $this->language->get('column_name');
			$data['column_model'] = $this->language->get('column_model');
			$data['column_quantity'] = $this->language->get('column_quantity');
			$data['column_price'] = $this->language->get('column_price');
			$data['column_total'] = $this->language->get('column_total');

			$data['button_update'] = $this->language->get('button_update');
			$data['button_remove'] = $this->language->get('button_remove');
			$data['button_shopping'] = $this->language->get('button_shopping');
			$data['button_checkout'] = $this->language->get('button_checkout');

			if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
				$data['error_warning'] = $this->language->get('error_stock');
			} elseif (isset($this->session->data['error'])) {
				$data['error_warning'] = $this->session->data['error'];

				unset($this->session->data['error']);
			} else {
				$data['error_warning'] = '';
			}

			if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
				$data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
			} else {
				$data['attention'] = '';
			}

			if (isset($this->session->data['success'])) {
				$data['success'] = $this->session->data['success'];

				unset($this->session->data['success']);
			} else {
				$data['success'] = '';
			}

			$data['action'] = $this->url->link('checkout/cart/edit', '', true);

			if ($this->config->get('config_cart_weight')) {
				$data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
			} else {
				$data['weight'] = '';
			}

			$this->load->model('tool/image');
			$this->load->model('tool/upload');

			$data['products'] = array();

			$products = $this->cart->getProducts();

      // << Related Options / Связанные опции 
					
					if (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')) {
						if ( !$this->model_module_related_options ) {
							$this->load->model('module/related_options');
						}
						
						if ( $this->model_module_related_options->installed() ) {
							$products = $this->model_module_related_options->cart_ckeckout_stock($products);
							foreach ($products as $product) {
								if (!$product['stock']) {
									$data['error_warning'] = $this->language->get('error_stock');
									break;
								}
							}
						}
					}
					
			// >> Related Options / Связанные опции 
      

			foreach ($products as $product) {
				$product_total = 0;

				foreach ($products as $product_2) {
					if ($product_2['product_id'] == $product['product_id']) {
						$product_total += $product_2['quantity'];
					}
				}

				if ($product['minimum'] > $product_total) {
					$data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
				}

				if ($product['image']) {
					
					$image = $this->config->get('theme_lightshop_image_cart_resize') ? $this->model_tool_image->lightshop_resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_cart_width'), $this->config->get($this->config->get('config_theme') . '_image_cart_height')) : $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_cart_width'), $this->config->get($this->config->get('config_theme') . '_image_cart_height')); // lightshop

            
				} else {
					$image = '';
				}

				if ($product['image']) {
					$big_image = $this->model_tool_image->resize($product['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
				} else {
					$big_image = '';
				}

				$option_data = array();

				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

						if ($upload_info) {
							$value = $upload_info['name'];
						} else {
							$value = '';
						}
					}

					$option_data[] = array(
						'name'  => $option['name'],
						'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
					);
				}

				// Display prices
				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$unit_price = $this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
					
					$price = $this->currency->format($unit_price, $this->session->data['currency']);
					$total = $this->currency->format($unit_price * $product['quantity'], $this->session->data['currency']);
				} else {
					$price = false;
					$total = false;
				}

				$recurring = '';

				if ($product['recurring']) {
					$frequencies = array(
						'day'        => $this->language->get('text_day'),
						'week'       => $this->language->get('text_week'),
						'semi_month' => $this->language->get('text_semi_month'),
						'month'      => $this->language->get('text_month'),
						'year'       => $this->language->get('text_year'),
					);

					if ($product['recurring']['trial']) {
						$recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
					}

					if ($product['recurring']['duration']) {
						$recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					} else {
						$recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					}
				}

				// Display manufacturer's logo
				$this->load->model('catalog/manufacturer');
				$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($product['manufacturer_id']);

				if($manufacturer_info['logo']) {
					$manufacturer_logo = $this->model_tool_image->resize($manufacturer_info['logo'], 20, 20);
				} else {
					$manufacturer_logo = '';
				}

				$data['products'][] = array(
					'cart_id'   => $product['cart_id'],
					'manufacturer_name' => $manufacturer_info['name'],
					'manufacturer_logo' => $manufacturer_logo,
					'thumb'     => $image,
					'big_thumb'     => $big_image,
					'name'      => $product['name'],
					'model'     => $product['model'],
					'option'    => $option_data,
					'recurring' => $recurring,
					'quantity'  => $product['quantity'],
					'stock'     => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
					'reward'    => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
					'price'     => $price,
					'total'     => $total,
					'href'      => $this->url->link('product/product', 'product_id=' . $product['product_id'])
				);
			}

			// Gift Voucher
			$data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $key => $voucher) {
					$data['vouchers'][] = array(
						'key'         => $key,
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'], $this->session->data['currency']),
						'remove'      => $this->url->link('checkout/cart', 'remove=' . $key)
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
			}

			$data['totals'] = array();

			foreach ($totals as $total) {
				$data['totals'][] = array(
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value'], $this->session->data['currency'])
				);
			}

			$data['continue'] = $this->url->link('common/home');

			$data['checkout'] = $this->url->link('checkout/checkout', '', true);

			$this->load->model('extension/extension');

			$data['modules'] = array();
			
			$files = glob(DIR_APPLICATION . '/controller/extension/total/*.php');

			if ($files) {
				foreach ($files as $file) {
					$result = $this->load->controller('extension/total/' . basename($file, '.php'));
					
					if ($result) {
						$data['modules'][] = $result;
					}
				}
			}

			$total_price = $this->cart->getTotal();
			$total_reduction = $total_price * 0.05;
			$total_price_with_reduction = $total_price - $total_reduction;
			$online_payment_reduction_percent = 2;
			$online_payment_reduction_price = ($total_price * $online_payment_reduction_percent) / 100;

			if($paymentMethod === 'card') {
				$total_price = $total_price - $online_payment_reduction_price;
			}

			$data['total_price'] = $this->currency->format($total_price, $this->session->data['currency']);
			$data['total_reduction'] = $this->currency->format($total_reduction, $this->session->data['currency']);
			$data['total_price_with_reduction'] = $this->currency->format($total_price_with_reduction, $this->session->data['currency']);
			$data['total_products'] = $this->cart->countProducts();
			$data['online_payment_reduction_percent'] = $online_payment_reduction_percent;
			$data['online_payment_reduction_price'] = $this->currency->format($online_payment_reduction_price, $this->session->data['currency']);

			$cart_nav_array = array('Формирование заказа', 'Укладка и сопутствующие товары', 'Доставка', 'Контакты и способ оплаты');
			$data['cart_nav_list'] = array();

			foreach($cart_nav_array as $key => $item) {
				$data['cart_nav_list'][] = array(
					'title' => $item,
					'step' => $key + 1
				);
			}

			if (isset($this->request->post['step'])) {
				$data['step'] = (int)$this->request->post['step'];
			} else {
				$data['step'] = 1;
			}

			$this->load->model('checkout/cart_user');
			$data['user'] = $this->model_checkout_cart_user->getUser();

			$data['additional'] = $this->load->controller('common/additional');
			$data['privacy_info'] = $this->load->controller('common/privacy_info');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('checkout/cart', $data));
		} else {
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_error'] = $this->language->get('text_empty');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			unset($this->session->data['success']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	public function add() {

      // << Related Options / Связанные опции 
			if ( isset($this->request->post['ro_not_required']) ) {
				$ro_not_required = explode(',', $this->request->post['ro_not_required']);
			}
			// >> Related Options / Связанные опции 
      
		$this->load->language('checkout/cart');

		$json = array();

		if (isset($this->request->post['product_id'])) {
			$product_id = (int)$this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		/* Additional */
		if(isset($this->request->post['additionals'])) {
			$needs = array_filter($this->request->post['additionals']);
			$this->load->model('checkout/cart_user');
			$this->model_checkout_cart_user->addNeeds($needs);
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			if (isset($this->request->post['quantity']) && ((int)$this->request->post['quantity'] >= $product_info['minimum'])) {
				$quantity = (int)$this->request->post['quantity'];
			} else {
				$quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
			}

			if (isset($this->request->post['option'])) {
				$option = array_filter($this->request->post['option']);
			} else {
				$option = array();
			}

			if (isset($this->request->post['additional'])) {
				$this->load->controller('checkout/cart_user', $this->request->post['additional']);
			}

			$product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);

			foreach ($product_options as $product_option) {

      // << Related Options / Связанные опции 
			if ( isset($ro_not_required) && in_array($product_option['product_option_id'], $ro_not_required) ) continue;
			// >> Related Options / Связанные опции 
      
				if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
					$json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
				}
			}

			if (isset($this->request->post['recurring_id'])) {
				$recurring_id = $this->request->post['recurring_id'];
			} else {
				$recurring_id = 0;
			}

			$recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);

			if ($recurrings) {
				$recurring_ids = array();

				foreach ($recurrings as $recurring) {
					$recurring_ids[] = $recurring['recurring_id'];
				}

				if (!in_array($recurring_id, $recurring_ids)) {
					$json['error']['recurring'] = $this->language->get('error_recurring_required');
				}
			}

			if (!$json) {
				$this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id);

				$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('checkout/cart'));

				// Unset all shipping and payment methods
				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);

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
				}

				
// lightshop
				$json['total'] = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
// lightshop end
            
			} else {
				$json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']));
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function pricesByPaymentMethod() {
		$json = array();

		if(isset($this->request->post['paymentMethod'])) {
			$paymentMethod = $this->request->post['paymentMethod'];
			$total_price = $this->cart->getTotal();
			$total_reduction = $total_price * 0.05;
			$total_price_with_reduction = $total_price - $total_reduction;
			$online_payment_reduction_percent = 2;
			$online_payment_reduction_price = ($total_price * $online_payment_reduction_percent) / 100;

			if($paymentMethod === 'card') {
				$total_price = $total_price - $online_payment_reduction_price;
			}

			$data['total_price'] = $this->currency->format($total_price, $this->session->data['currency']);
			$data['total_reduction'] = $this->currency->format($total_reduction, $this->session->data['currency']);
			$data['total_price_with_reduction'] = $this->currency->format($total_price_with_reduction, $this->session->data['currency']);
			$data['total_products'] = $this->cart->countProducts();
			$data['online_payment_reduction_percent'] = $online_payment_reduction_percent;
			$data['online_payment_reduction_price'] = $this->currency->format($online_payment_reduction_price, $this->session->data['currency']);

			$json['totalPrice'] = $data['total_price'];
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
 
	public function fastAdd() {
		$json = array();
		
		if(isset($this->request->post['product_id'])) {
			$this->cart->add($product_id = $this->request->post['product_id']);
		}

		$json['total_products'] = $this->cart->countProducts();

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function edit() {
		$this->load->language('checkout/cart');

		$json = array();

		// Update
		if (!empty($this->request->post['quantity'])) {
			foreach ($this->request->post['quantity'] as $key => $value) {
				$this->cart->update($key, $value);
			}

			$this->session->data['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			$this->response->redirect($this->url->link('checkout/cart', '', true));

			
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function remove() {
		$this->load->language('checkout/cart');

		$json = array();

		// Remove
		if (isset($this->request->post['key'])) {
			$this->cart->remove($this->request->post['key']);

			unset($this->session->data['vouchers'][$this->request->post['key']]);

			$json['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

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
			}

			
// lightshop
				$json['total'] = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
// lightshop end
            
		}

		$this->response->redirect($this->url->link('checkout/cart', '', true));

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function clear() {
		$this->cart->clear();
		$this->response->redirect($this->url->link('checkout/cart', '', true));
	}
}
