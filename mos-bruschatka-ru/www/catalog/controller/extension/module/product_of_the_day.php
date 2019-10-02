<?php
class ControllerExtensionModuleProductOfTheDay extends Controller
{
    const MODULE_NAME = 'product_of_the_day';
    const PRODUCT_IMAGE_WIDTH = 192;
    const PRODUCT_IMAGE_HEIGHT = 152;
    const CACHE_LIFE = 86400;
    
    public function index($setting) 
    {
        if (!$setting['status'] && !$setting['product_id']) {
            return '';
        }

        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        $this->load->language('extension/module/' . self::MODULE_NAME);
        $this->load->language('product/product');

        $product = $this->model_catalog_product->getProduct($setting['product_id']);
        $discountPercent = (int) $this->model_catalog_product->getProductDiscounts($product['product_id'])[0]['price'];

        $data = $this->getLanguageData();
        $data['module_css_class'] = $setting['module_css_class'];
        $data['product_name'] = $product['name'];
        $data['product_description'] = $setting['product_description'];
        $data['today_bought_number'] = $this->resolveTodayBoughtNumber($setting['name'], 10, 20);
        $data['product_price'] = (int) $product['price'];
        $data['product_old_price'] = (int) ((100 * $product['price']) / (100 - $discountPercent));
        $data['product_discount'] = $discountPercent;
        $data['product_url'] = 	$this->url->link('product/product', 'product_id=' . $product['product_id']);
        $data['product_image'] = $this->model_tool_image->resize($product['image'], self::PRODUCT_IMAGE_WIDTH, self::PRODUCT_IMAGE_HEIGHT);

        return $this->load->view('extension/module/' . self::MODULE_NAME, $data);
    }

    private function getLanguageData()
    {
        $data = [];

        $data['heading_title'] = $this->language->get('heading_title');
        $data['button_cart'] = $this->language->get('button_cart');
        $data['button_view'] = $this->language->get('button_view');
        $data['placeholder_img'] = $this->language->get('placeholder_img');

        return $data;
    }

    /**
     * @param string $name
     * @param int $from
     * @param int $to
     * @return int
     */
    private function resolveTodayBoughtNumber($name, $from, $to)
    {
        $cacheFile = DIR_CACHE . self::MODULE_NAME . md5($name);

        if (file_exists($cacheFile) && ((time() - filemtime($cacheFile)) < self::CACHE_LIFE)) {
            $todayBoughtNumber = (int)file_get_contents($cacheFile);
        } else {
            $todayBoughtNumber = rand($from, $to);
            file_put_contents($cacheFile, $todayBoughtNumber);
        }

        return $todayBoughtNumber;
    }
}
