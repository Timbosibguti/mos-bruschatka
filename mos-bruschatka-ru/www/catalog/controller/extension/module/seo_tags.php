<?php
class ControllerExtensionModuleSeoTags extends Controller
{
    const REGISTRY_CONTEXT_KEY = 'context';

    private $setting;

    public function index($setting)
    {
        $this->setting = $setting;

        $data = [];

        if (isset($this->setting['module_description'][$this->config->get('config_language_id')])) {

            if ($title = $this->getDecodedParamFromSetting('tag_title')) {
                $this->document->setTitle($title);
            }

            if ($keywords = $this->getDecodedParamFromSetting('tag_meta_keywords')) {
                $this->document->setKeywords($keywords);
            }

            if ($description = $this->getDecodedParamFromSetting('tag_meta_description')) {
                $this->document->setDescription($description);
            }

            if ($h1 = $this->getDecodedParamFromSetting('tag_h1')) {
                $data['h1'] = $h1;
            }

            return $this->load->view('extension/module/seo_tags', $data);
        }

        return null;
    }

    private function getDecodedParamFromSetting($paramName)
    {
        $parameterValue = html_entity_decode($this->setting['module_description'][$this->config->get('config_language_id')][$paramName], ENT_QUOTES, 'UTF-8');

        if (is_array($this->registry->get(self::REGISTRY_CONTEXT_KEY))) {
            return $this->renderValueByTemplate($this->registry->get(self::REGISTRY_CONTEXT_KEY), $parameterValue);
        }

        return $parameterValue;
    }

    private function renderValueByTemplate($data, $template)
    {
        $templateParameters = $this->getTemplateParameters($data);

        foreach ($templateParameters as $key => $value)
        {
            $template = str_replace($key, $value, $template);
        }

        return $template;
    }

    private function getTemplateParameters($data)
    {
        $templateParameters = [];

        foreach ($data as $key => $value) {
            $templateParameters['{' . $key . '}'] = $value;
        }

        return $templateParameters;
    }
}
