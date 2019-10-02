<?php
class ControllerExtensionAnalyticsYandexMetrika extends Controller {
    public function index() {
		
		$admin = false;
		
		$user = false;
		
		if ($this->config->get('yandex_metrika_no_admin')) {
			$this->user = new Cart\User($this->registry);
			
			$admin = $this->user->isLogged();			
		}
		
		if ($this->config->get('yandex_metrika_no_users')) {
			$user = $this->customer->isLogged();
		}
			
		if (!$admin and !$user) {
			return html_entity_decode($this->config->get('yandex_metrika_code'), ENT_QUOTES, 'UTF-8');
		} 
	}
}