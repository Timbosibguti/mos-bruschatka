<?php
class ControllerExtensionModuleHits extends Controller {
	public function index($setting) {

      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			$data['text_ro_clear_options'] 			= $this->language->get('text_ro_clear_options');
			// >> Related Options / Связанные опции 
      
		$this->load->language('extension/module/hits');

      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			$data['text_ro_clear_options'] 			= $this->language->get('text_ro_clear_options');
			// >> Related Options / Связанные опции 
      
		$this->load->language('product/product');

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_tax'] = $this->language->get('text_tax');
		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		$data['button_view'] = $this->language->get('button_view');
		$data['placeholder_img'] = $this->language->get('placeholder_img');

		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
		$this->load->model('catalog/filter');
		$this->load->model('tool/image');


      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			$data['text_ro_clear_options'] 			= $this->language->get('text_ro_clear_options');
			// >> Related Options / Связанные опции 
      
		$this->load->language('product/product');

		$data['show_button'] = $setting['show_button'] ? $setting['show_button'] : false;
		$data['forms'] = array();
		$data['module_css_class'] = $setting['module_css_class'];
		
		if($setting['status'] && $setting['hits']) {
			foreach ($setting['hits'] as $hit) {
				$products = array();

				foreach ($hit['products'] as $product_id) {
					$product = $this->model_catalog_product->getProduct((int)$product_id);

					if($product['image']) {
						$image = $this->model_tool_image->resize($product['image'], 240, 180);
					} else {
						$image = 'placeholder.jpg';
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

                    $discounts = $this->model_catalog_product->getProductDiscounts((int)$product_id);
                    $discount_percent = ($discounts) ? $discounts[0]['price'] : false;
		
					if ($this->config->get('config_review_status')) {
						$rating = $product['rating'];
					} else {
						$rating = false;
					}

					if ($product['quantity'] <= 0) {
						$stock = $product['stock_status'];
					} elseif ($this->config->get('config_stock_display')) {
						$stock = $product['quantity'];
					} else {
						$stock = $this->language->get('text_instock');
					}

                    $options = $this->model_catalog_product->getProductOptions($product['product_id']);
                    $options_default_values = $this->assembleOptionsValues($options);

					$products[] = array(
						'product_id'	=> $product['product_id'],
						'name'			=> $product['name'],
						'price'			=> $price,
						'quantity'		=> $product['quantity'],
						'special'       => $discount_percent,
						'tags'          => explode(',' , $product['tag']),
						'stock'			=> $stock,
						'href'			=> $this->url->link('product/product', 'product_id=' . $product['product_id']),
						'thumb'			=> $image,
						'thumb_height'	=> 180,
						'thumb_width'	=> 240,
						'rating'        => $rating,
						'minimum'		=> ($product['minimum'] > 0) ? $product['minimum'] : 1,
                        'options'       => $options_default_values,
					);
				}

				$data['forms'][] = array(
					'name'		=> $this->resolveHitsDataOptionName($hit['option_value']),
					'css_class'	=> $hit['classname'],
					'products'	=> $products
				);
			}
		}

		return $this->load->view('extension/module/hits', $data);
	}

	private function resolveHitsDataOptionName($optionValue)
	{
		$item = explode('-', $optionValue);
		$itemType = $item[0];
		$itemId = (int)(isset($item[1])) ? $item[1] : $item[0];

		if($itemType == 'category') {
			return $this->model_catalog_category->getCategory($itemId)['meta_h1'];
		} else {
			return $this->model_catalog_filter->getFilterDescription($itemId)['name'];
		}
	}

    private function assembleOptionsValues($options)
    {
        $optionsValues = [];

        foreach ($options as $option) {
            foreach ($option['product_option_value'] as $optionValue) {
                if (!$optionValue['subtract'] || ($optionValue['quantity'] > 0)) {
                    $optionsValues['option[' .  $option['product_option_id'] . ']'] = $optionValue['product_option_value_id'];

                    break;
                }
            }
        }

        return $optionsValues;
    }
}
