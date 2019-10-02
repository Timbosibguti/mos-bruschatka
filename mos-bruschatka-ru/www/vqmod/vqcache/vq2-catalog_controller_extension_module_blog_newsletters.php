<?php
class ControllerExtensionModuleBlogNewsletters extends Controller {
	public function index() {

      // << Related Options / Связанные опции  
			$this->load->language('module/related_options');
			$data['text_ro_clear_options'] 			= $this->language->get('text_ro_clear_options');
			// >> Related Options / Связанные опции 
      
		$this->load->language('extension/module/blog_newsletters');

		$data['heading_title'] = $this->language->get('heading_title');
		$data['placeholder_email'] = $this->language->get('placeholder_email');
		$data['button_subscribe'] = $this->language->get('button_subscribe');
		
		return $this->load->view('extension/module/blog_newsletters', $data);
	}
}