<?php
class ControllerAccountVoucher extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('account/voucher');

		$this->load->language('extension/theme/lightshop');// lightshop
            

		$this->document->setTitle($this->language->get('heading_title'));

		if (!isset($this->session->data['vouchers'])) {
			$this->session->data['vouchers'] = array();
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->session->data['vouchers'][mt_rand()] = array(
				'description'      => sprintf($this->language->get('text_for'), $this->currency->format($this->request->post['amount'], $this->session->data['currency']), $this->request->post['to_name']),
				'to_name'          => $this->request->post['to_name'],
				'to_email'         => $this->request->post['to_email'],
				'from_name'        => $this->request->post['from_name'],
				'from_email'       => $this->request->post['from_email'],
				'voucher_theme_id' => $this->request->post['voucher_theme_id'],
				'message'          => $this->request->post['message'],
				'amount'           => $this->currency->convert($this->request->post['amount'], $this->session->data['currency'], $this->config->get('config_currency'))
			);

			$this->response->redirect($this->url->link('account/voucher/success'));
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_voucher'),
			'href' => $this->url->link('account/voucher', '', true)
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_description'] = $this->language->get('text_description');
		$data['text_agree'] = $this->language->get('text_agree');

		$data['entry_to_name'] = $this->language->get('entry_to_name');
		$data['entry_to_email'] = $this->language->get('entry_to_email');
		$data['entry_from_name'] = $this->language->get('entry_from_name');
		$data['entry_from_email'] = $this->language->get('entry_from_email');
		$data['entry_theme'] = $this->language->get('entry_theme');
		$data['entry_message'] = $this->language->get('entry_message');
		$data['entry_amount'] = $this->language->get('entry_amount');


		// lightshop
		if ($this->config->get('theme_lightshop_voucher_pdata')) {
			$this->load->language('extension/theme/lightshop');
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($this->config->get('theme_lightshop_voucher_pdata'));

			if ($information_info) {
				$data['text_lightshop_pdata_checkbox'] = sprintf($this->language->get('text_lightshop_pdata_checkbox'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('theme_lightshop_voucher_pdata'), true), $information_info['title'], $information_info['title']);
			} else {
				$data['text_lightshop_pdata_checkbox'] = '';
			}
		} else {
			$data['text_lightshop_pdata_checkbox'] = '';
		}
		// lightshop end
            
		$data['help_message'] = $this->language->get('help_message');
		$data['help_amount'] = sprintf($this->language->get('help_amount'), $this->currency->format($this->config->get('config_voucher_min'), $this->session->data['currency']), $this->currency->format($this->config->get('config_voucher_max'), $this->session->data['currency']));

		$data['button_continue'] = $this->language->get('button_continue');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['to_name'])) {
			$data['error_to_name'] = $this->error['to_name'];
		} else {
			$data['error_to_name'] = '';
		}

		if (isset($this->error['to_email'])) {
			$data['error_to_email'] = $this->error['to_email'];
		} else {
			$data['error_to_email'] = '';
		}

		if (isset($this->error['from_name'])) {
			$data['error_from_name'] = $this->error['from_name'];
		} else {
			$data['error_from_name'] = '';
		}

		if (isset($this->error['from_email'])) {
			$data['error_from_email'] = $this->error['from_email'];
		} else {
			$data['error_from_email'] = '';
		}

		if (isset($this->error['theme'])) {
			$data['error_theme'] = $this->error['theme'];
		} else {
			$data['error_theme'] = '';
		}

		if (isset($this->error['amount'])) {
			$data['error_amount'] = $this->error['amount'];
		} else {
			$data['error_amount'] = '';
		}


		// lightshop
		if (isset($this->error['error_pdata'])) {
			$data['error_pdata'] = $this->error['error_pdata'];
		} else {
			$data['error_pdata'] = '';
		}
		// lightshop end

            
		$data['action'] = $this->url->link('account/voucher', '', true);

		if (isset($this->request->post['to_name'])) {
			$data['to_name'] = $this->request->post['to_name'];
		} else {
			$data['to_name'] = '';
		}

		if (isset($this->request->post['to_email'])) {
			$data['to_email'] = $this->request->post['to_email'];
		} else {
			$data['to_email'] = '';
		}

		if (isset($this->request->post['from_name'])) {
			$data['from_name'] = $this->request->post['from_name'];
		} elseif ($this->customer->isLogged()) {
			$data['from_name'] = $this->customer->getFirstName() . ' '  . $this->customer->getLastName();
		} else {
			$data['from_name'] = '';
		}

		if (isset($this->request->post['from_email'])) {
			$data['from_email'] = $this->request->post['from_email'];
		} elseif ($this->customer->isLogged()) {
			$data['from_email'] = $this->customer->getEmail();
		} else {
			$data['from_email'] = '';
		}

		$this->load->model('extension/total/voucher_theme');

		$data['voucher_themes'] = $this->model_extension_total_voucher_theme->getVoucherThemes();

		if (isset($this->request->post['voucher_theme_id'])) {
			$data['voucher_theme_id'] = $this->request->post['voucher_theme_id'];
		} else {
			$data['voucher_theme_id'] = '';
		}

		if (isset($this->request->post['message'])) {
			$data['message'] = $this->request->post['message'];
		} else {
			$data['message'] = '';
		}

		if (isset($this->request->post['amount'])) {
			$data['amount'] = $this->request->post['amount'];
		} else {
			$data['amount'] = $this->currency->format($this->config->get('config_voucher_min'), $this->config->get('config_currency'), false, false);
		}

		if (isset($this->request->post['agree'])) {
			$data['agree'] = $this->request->post['agree'];
		} else {
			$data['agree'] = false;
		}


		// lightshop
		if (isset($this->request->post['pdata'])) {
			$data['pdata'] = $this->request->post['pdata'];
		} else {
			$data['pdata'] = '';
		}
		// lightshop end
            
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('account/voucher', $data));
	}

	public function success() {
		$this->load->language('account/voucher');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('account/voucher')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_message'] = $this->language->get('text_message');

		$data['button_continue'] = $this->language->get('button_continue');

		$data['continue'] = $this->url->link('checkout/cart');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('common/success', $data));
	}

	protected function validate() {
		if ((utf8_strlen($this->request->post['to_name']) < 1) || (utf8_strlen($this->request->post['to_name']) > 64)) {
			$this->error['to_name'] = $this->language->get('error_to_name');
		}

		if ((utf8_strlen($this->request->post['to_email']) > 96) || !preg_match($this->config->get('config_mail_regexp'), $this->request->post['to_email'])) {
			$this->error['to_email'] = $this->language->get('error_email');
		}

		if ((utf8_strlen($this->request->post['from_name']) < 1) || (utf8_strlen($this->request->post['from_name']) > 64)) {
			$this->error['from_name'] = $this->language->get('error_from_name');
		}

		if ((utf8_strlen($this->request->post['from_email']) > 96) || !preg_match($this->config->get('config_mail_regexp'), $this->request->post['from_email'])) {
			$this->error['from_email'] = $this->language->get('error_email');
		}

		if (!isset($this->request->post['voucher_theme_id'])) {
			$this->error['theme'] = $this->language->get('error_theme');
		}

		if (($this->currency->convert($this->request->post['amount'], $this->session->data['currency'], $this->config->get('config_currency')) < $this->config->get('config_voucher_min')) || ($this->currency->convert($this->request->post['amount'], $this->session->data['currency'], $this->config->get('config_currency')) > $this->config->get('config_voucher_max'))) {
			$this->error['amount'] = sprintf($this->language->get('error_amount'), $this->currency->format($this->config->get('config_voucher_min'), $this->session->data['currency']), $this->currency->format($this->config->get('config_voucher_max'), $this->session->data['currency']));
		}

		if (!isset($this->request->post['agree'])) {
			$this->error['warning'] = $this->language->get('error_agree');
		}


		// lightshop
		if ($this->config->get('theme_lightshop_voucher_pdata')) {
			$this->load->model('catalog/information');
			
			$information_info = $this->model_catalog_information->getInformation($this->config->get('theme_lightshop_voucher_pdata'));
			
			if ($information_info && !isset($this->request->post['pdata'])) {
				$this->error['error_pdata'] = sprintf($this->language->get('text_lightshop_error_pdata'), $information_info['title']);
			}
		}
		// lightshop end

            
		return !$this->error;
	}
}
