<?php
class ControllerExtensionModuleContentFromFile extends Controller
{
    public function index($setting)
    {
        if (isset($setting['module_description'][$this->config->get('config_language_id')])) {
            $filepath = html_entity_decode($setting['module_description'][$this->config->get('config_language_id')]['path'], ENT_QUOTES, 'UTF-8');

            ob_start();
            require(DIR_CONTENT_FILES . trim($filepath, '/'));
            $data['html'] = ob_get_clean();
            
            return $this->load->view('extension/module/content_from_file', $data);
        }
    }
}
