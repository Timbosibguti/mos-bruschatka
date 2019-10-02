<?php

require_once(DIR_SYSTEM . 'engine/BaseAdminModuleController.php');

final class ControllerExtensionModuleProductOfTheDay extends BaseAdminModuleController
{
    const MODULE_NAME = 'product_of_the_day';

    protected function getModuleName()
    {
        return self::MODULE_NAME;
    }

    protected function getModuleSpecificData($data)
    {
        $data['lang'] = array_merge($this->getLanguageData(), $data['lang']);

        $data = $this->handleField('product_name', $data);
        $data = $this->handleField('product_id', $data);
        $data = $this->handleField('product_description', $data);

        return $data;
    }

    /**
     * @return array
     */
    private function getLanguageData()
    {
        $data = [];

        $data['entry_product'] = $this->language->get('entry_product');
        $data['entry_module_css_class'] = $this->language->get('entry_module_css_class');
        $data['entry_description'] = $this->language->get('entry_description');

        return $data;
    }
}
