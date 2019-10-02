<?php
class ControllerExtensionFeedOcextFeedGeneratorYaMarket extends Controller {
	private $shop = array();
	private $currencies = array();
	private $categories = array();
	private $offers = array();
        private $prices = array();
        private $parse_yml = array();
        private $delivery_option = array();
        private $general_setting = array();
        private $setting_yml = array();
        private $eol = "\n";
        private $debug = 0;
        private $l_data = array();
        
        
        public function index() {
            
                $error = array();                                                                                                                                                                                                                                                                                                                                                                   eval(base64_decode('JHRoaXMtPmNoZWNrbGljZW5zZSgpOw=='));//OCext.com: do not delete this line | не удаляйте эту строку
            
                if (!$this->config->get('ocext_feed_generator_yamarket_status')) {
                    $error[] = 'Модуль выключен';
                }
                
                $general_setting = $this->config->get('ocext_feed_generator_yamarket_general_setting');
                
                if(!isset($general_setting['user_key']) || !$general_setting['user_key']){
                    $error[] = 'Не указан лицензионный ключ. Отправьте запрос на welcome@ocext.com, в котором укажите сайт, где приобретался модуль, номер заказа и email аккаунта';
                }
                
                if(!isset($general_setting['user_email']) || !$general_setting['user_email']){
                    $error[] = 'Не указан лицензионный email покупателя. В настройках модуля укажите email, который отправлялся при запросе лицензинного ключа';
                }
                
                if(!file_exists($_SERVER["DOCUMENT_ROOT"].'/system/library/vendor/ocext/ocext_feed_generator_yamarket_license.php')){
                    $error[] = 'Неверно лицензионный ключ. Отправьте запрос на welcome@ocext.com, в котором укажите сайт, где приобретался модуль, номер заказа и email аккаунта';
                }
                
                $token_get = '';
                
                $filter_data_group_id = '';
                
                if(isset($this->request->get['token'])){
                    
                    $token_get = $this->request->get['token'];
                    
                    if(isset($general_setting['filter_data'])){
                        
                        foreach ($general_setting['filter_data'] as $filter_data) {
                            
                            if(isset($this->setting_yml['path_token']) && isset($filter_data[$this->setting_yml['path_token']]) && $filter_data[$this->setting_yml['path_token']] ===$token_get){
                                
                                $general_setting['path_token_export'] = $token_get;
                                $general_setting['filename_export'] = $filter_data['filename_export'];
                                $general_setting['yml_currencies'] = $filter_data['yml_currencies'];
                                $filter_data_group_id = $filter_data['filter_data_group_id'];
                                
                                if(!isset($filter_data['content_language_id']) || !$filter_data['content_language_id']){
                                    
                                    $content_language_id = $this->config->get('config_language_id');
                                    
                                }else{
                                    
                                    $content_language_id = $filter_data['content_language_id'];
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                if(!isset($general_setting['path_token_export']) || !$general_setting['path_token_export']){
                    $error[] = 'Не задан защитный параметр ссылки - token';
                }
                
                if(isset($general_setting['path_token_export']) && $token_get!=$general_setting['path_token_export']){
                    $error[] = 'Неверный защитный параметр ссылки - token';
                }
                
                
                if(!isset($general_setting['yml_currencies']) || !$general_setting['yml_currencies']){
                    $error[] = 'Не указана валюта - обязательный параметр';
                }else{
                    $this->setCurrencyAttributes($general_setting['yml_currencies']);
                }
                
                if(!isset($general_setting['name']) || !$general_setting['name']){
                    $error[] = 'Не указано краткое название магазина';
                }else{
                    $this->setShopAttributes('name', $general_setting['name']);
                }
                
                if(!isset($general_setting['company']) || !$general_setting['company']){
                    $error[] = 'Не указано название компании';
                }else{
                    $this->setShopAttributes('company', $general_setting['company']);
                }
                
                if(!$error){
                    //создаем список категорий
                    $categories_end_offers = $this->getCategoriesAndOffers($filter_data_group_id,$content_language_id,$this->setting_yml);
                    if(!$categories_end_offers){
                        $error[] = 'Не найдены категории и/или товары. Невозможно создать файл без категорий и/или товаров';
                    }
                }
                
                if(!$this->config->get('config_secure')){
                    $this->setShopAttributes('url', HTTP_SERVER);
                }else{
                    $this->setShopAttributes('url', HTTPS_SERVER);
                }
                
                
                if(isset($general_setting['platform']) && $general_setting['platform']){
                    $this->setShopAttributes('platform', $this->config->get('ayeogs_platform'));
                }
                
                if(isset($general_setting['version']) && $general_setting['version']){
                    $this->setShopAttributes('version', $general_setting['version']);
                }
                
                if($error){
                    $this->sendErrorXML($error);
                    return;
                }
                
                foreach ($categories_end_offers['categories'] as $category) {
                    $this->setCategoryAttrubite($category['name'], $category['category_id'], $category['parent_id']);
                }
                
                $this->delivery_option = $this->getShopDeliveryOptionAttrubite($categories_end_offers['offers']);
                
                $this->general_setting = $general_setting;
                
                foreach ($categories_end_offers['offers'] as $product) {
                    $this->getOfferAttrubite($product);
                }
                
                if(!$this->debug && isset($this->setting_yml['status_validation']) && isset($this->parse_yml[$this->setting_yml['status_validation']]) && $this->parse_yml[$this->setting_yml['status_validation']]){
                    $this->response->addHeader('Content-Type: application/xml');
                    $this->response->setOutput($this->getYml());
                }
	}
        
        public function getShopDeliveryOptionAttrubite($products) {
            
            $data = array();
            if($products){
                foreach ($products as $product) {
                    if(isset($product['setting']) && $product['setting'] && $product['setting']['delivery-options']['status']){
                        
                        $weight = '';
                        $stock_status_id = '';
                        $price = '';
                        
                        
                        if(isset($product['weight']) && $product['weight']>0){
                            $weight = (float)$weight;
                        }
                        if(isset($product['weight']) && $product['weight']>0){
                            $stock_status_id = $product['stock_status_id'];
                        }
                        if(isset($product['price'])){
                            $price = $product['price'];
                        }
                        
                        $delivery_options = $this->getDeliveryOption($product['setting'],$price,$weight,$stock_status_id);
                        
                        if($delivery_options){
                            $data['delivery-options'] = $delivery_options;
                        }
                    }
                }
            }
            return $data;
            
        }
        
        public function getOfferAttrubite($product) {
            $data = array();
            $template_setting = array();
            $skip_this_offer = FALSE;
            
            if(isset($product['setting']) && $product['setting']){
                $template_setting = $product['setting'];
            }
            
            $data['id'] = $product['product_id'];
            
            if($product['product_id_by_option_id']){
                
                $data['id'] = $product['product_id_by_option_id'];
                
            }
            
            if(isset($template_setting['product_id_from']) && $template_setting['product_id_from']!='' && $product['product_id']<$template_setting['product_id_from']){
                $skip_this_offer = TRUE;
            }
            
            if(isset($template_setting['product_id_to']) && $template_setting['product_id_to']!='' &&  $product['product_id']>$template_setting['product_id_to']){
                $skip_this_offer = TRUE;
            }
            
            if(isset($template_setting['disable_this_product']) && $template_setting['disable_this_product']){
                $skip_this_offer = TRUE;
            }
            
            if(isset($template_setting['url_whis_path']) && $template_setting['url_whis_path']){
                $data['url'] = $this->url->link('product/product', 'path='.$this->getPathWhisCategories($product['category_id']).'&product_id='.$product['product_id']);
            }else{
                $data['url'] = $this->url->link('product/product', 'product_id='.$product['product_id']);
            }
            
            $data['url'] .= $product['option_url_param'];
            
            
            
            //цены
            
            $product['price'] = $this->getPrice($product['price'],$product,$template_setting);
            
            if($product['special_price']>0){
                $product['special_price'] = $this->getPrice($product['special_price'],$product,$template_setting);
            }
            if($product['discount_special_price']>0){
                $product['discount_special_price'] = $this->getPrice($product['discount_special_price'],$product,$template_setting);
            }
            
            if(isset($template_setting['oldprice']) && $template_setting['oldprice'] && ($product['special_price'] || $product['discount_special_price']) > 0){
                if($product['special_price']>0 && $product['special_price'] < $product['price'] ){
                    
                    $data['oldprice'] = $product['price'];
                    $data['price'] = $product['special_price'];
                    $product['oldprice'] = $product['price'];
                    $product['price'] = $product['special_price'];
                    
                }elseif( $product['discount_special_price']>0 && $product['discount_special_price'] < $product['price']  ){
                    
                    $data['oldprice'] = $product['price'];
                    $data['price'] = $product['discount_special_price'];
                    $product['oldprice'] = $product['price'];
                    $product['price'] = $product['discount_special_price'];
                    
                }else{
                    
                    $data['price'] = $product['price'];
                    
                }
            }
            
            if(isset($template_setting['price_currencies_to'])){
                $decimal_place = (int)$this->currency->getDecimalPlace($template_setting['price_currencies_to']);
            }else{
                $decimal_place = (int)$this->currency->getDecimalPlace(0);
            }
            
            $data['price'] = round($product['price'],$decimal_place);
            
            if(isset($data['oldprice']) && $data['oldprice'] && isset($product['oldprice']) && $product['oldprice']){
                
                $data['oldprice'] = round($product['oldprice'],$decimal_place);
                
            }
                    
            if(isset($this->parse_yml['zero']) && isset($template_setting[$this->parse_yml['zero']]) && !$template_setting[$this->parse_yml['zero']] && $data['price']==0){
                $skip_this_offer = TRUE;
            }
            
            if(isset($template_setting['price_from']) && $template_setting['price_from']!='' && $template_setting['price_from']>$data['price']){
                $skip_this_offer = TRUE;
            }
            
            if(isset($template_setting['price_to']) && $template_setting['price_to']!='' && $data['price'] > $template_setting['price_to']){
                $skip_this_offer = TRUE;
            }
            
            if((!$data['price'] || $data['price']==0.0) && (!isset($template_setting['zero_price']) || !$template_setting['zero_price']) ){
                $skip_this_offer = TRUE;
            }else{
                //используется для составных заголовков
                $this->prices[$product['product_id']] = $data['price'];
            }
            //валюта
            $data['currencyId'] = $this->currencies[0]['id'];
            //категория
            $data['categoryId'] = $product['category_id'];
            
            if(isset($product['market_category']) && $product['market_category']){
                //категория market_category
                $data['market_category'] = $product['market_category'];
            }
            
            //изображения
            $data['picture'] = $this->getPictureAttributes($product,$template_setting);
            
            //если без картинок не выгружать, и картинок нет, то это предложение не делаем
            if(isset($template_setting['no_pictures']) && !$template_setting['no_pictures'] && !$data['picture']){
                $skip_this_offer = TRUE;
            }
            
            
            if(isset($template_setting['store']) && $template_setting['store']){
                $data['store'] = 'true';
            }else{
                $data['store'] = 'false';
            }
            //
            if(isset($template_setting['pickup']) && $template_setting['pickup']){
                $data['pickup'] = 'true';
            }else{
                $data['pickup'] = 'false';
            }
            
            //
            if(isset($template_setting['delivery']) && $template_setting['delivery']){
                $data['delivery'] = 'true';
            }else{
                $data['delivery'] = 'false';
            }
            
            if(!isset($template_setting['delivery'])){
                
                $data['delivery'] = 'true';
                
            }
            
            //delivery-options
            if(isset($template_setting['delivery-options']['status']) && $template_setting['delivery-options']['status']){
                
                $w = '';
                if(isset($product['weight']) && $product['weight']>0){
                    $w = (float)$w;
                }
                $ssi = '';
                if(isset($product['stock_status_id']) && $product['stock_status_id']>0){
                    $ssi = $product['stock_status_id'];
                }
                $p = '';
                if(isset($product['price'])){
                    $p = $product['price'];
                }
                
                $delivery_options = $this->getDeliveryOption($template_setting,$p,$w,$ssi);
                if($delivery_options){
                    $data['delivery-options'] = $delivery_options;
                }
            }
            
            
            
            if((isset($template_setting['offer_name']['field']['status'])  && $template_setting['offer_name']['field']['status']) ){
                
                //название товара
                $data['name'] = $this->getNameAttribute($product,$template_setting,'offer_name');
                
            }elseif(!isset($template_setting['offer_name']['field']['status'])){
                
                $data['name'] = $this->prepareField($product['name']);
                
            }
                  
            if(isset($template_setting['divide_on_option_add_to_name']) && $template_setting['divide_on_option_add_to_name'] && isset($data['name']) && isset($product['option_add_model_name']) && $product['option_add_model_name']){
                $data['name'] .= ' '.$this->prepareField($product['option_add_model_name']);
            }
            
            if(isset($template_setting['text_capitalize']) && $template_setting['text_capitalize'] && isset($data['name'])){
                $data['name'] = mb_convert_case($data['name'], MB_CASE_TITLE, "UTF-8");
            }
            
            //вендор
            if(isset($template_setting['vendor']['field']['status'])){
                $data['vendor'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['vendor']['field']['status'],'vendor');
            }
            
            if(isset($template_setting['vendorCode']['field']['status'])){
                $data['vendorCode'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['vendorCode']['field']['status'],'vendorCode');
            }
            
            //если вендор модель, выход без вендора
            if(isset($template_setting['vendor.model']) && $template_setting['vendor.model'] && ( !isset($data['vendor']) || !$data['vendor'] )){
                //return;
                $data['type'] = 'vendor.model';
            }elseif(isset ($template_setting['vendor.model']) && $template_setting['vendor.model']){
                $data['type'] = 'vendor.model';
            }
            
            //описание
            if(isset($template_setting['offer_description']['field']) && $template_setting['offer_description']['field']){
                $data['description'] = $this->getDescriptionAttribute($product, $template_setting);
            }
            
            //manufacturer_warranty
            if(isset($template_setting['manufacturer_warranty']) && $template_setting['manufacturer_warranty']){
                $data['manufacturer_warranty'] = 'true';
            }
            
            //country_of_origin
            if(isset($template_setting['country_of_origin'])){
                $data['country_of_origin'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['country_of_origin']['field']['status'],'country_of_origin');
            }
            
            //barcode
            if(isset($template_setting['barcode'])){
                $data['barcode'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['barcode']['field']['status'],'barcode');
            }
            
            //expiry
            if(isset($template_setting['expiry'])){
                $data['expiry'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['expiry']['field']['status'],'expiry');
            }
            
            //weight
            if(isset($template_setting['weight'])){
                $data['weight'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['weight']['field']['status'],'weight');
            }
            
            //weight
            if(isset($template_setting['dimensions'])){
                $data['dimensions'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['dimensions']['field']['status'],'dimensions');
            }
            
            //age
            if(isset($template_setting['age']['field']['status']) && $template_setting['age']['field']['status']){
                if($template_setting['age']['unit']){
                    $data['age']['value'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['age']['field']['status'],'age');
                    $data['age']['unit'] = $template_setting['age']['unit'];
                }
            }
            
            //typePrefix
            if(isset($template_setting['typePrefix']) && $template_setting['typePrefix']){
                $data['typePrefix'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['typePrefix']['field']['status'],'typePrefix');
            }
            
            //cpa
            if(isset($template_setting['cpa']) && $template_setting['cpa']){
                $data['cpa'] = '1';
            }
            
            //rec
            if(isset($template_setting['rec']) && $template_setting['rec'] && $product['rec']){
                $data['rec'] = implode(',', $product['rec']);
            }
            
            //adult
            if(isset($template_setting['adult']) && $template_setting['adult']){
                $data['adult'] = 'true';
            }
            
            //available
            $stock_status_id = $product['stock_status_id'];
            $quantity = (int)$product['quantity'];
            $minimum = (int)$product['minimum'];
            $data['available'] = 'false';
            
            
            if(isset($template_setting['available_by_quantity']) && $template_setting['available_by_quantity']){
                
                if(!$quantity || $quantity<$minimum){
                    $data['available'] = 'false';
                }elseif($quantity || $quantity>=$minimum){
                    $data['available'] = 'true';
                }
                
            }else{
                
                if(isset ($template_setting['available_true']) && $template_setting['available_true']==$stock_status_id){
                    $data['available'] = 'true';
                }elseif(isset ($template_setting['available_false'][$stock_status_id])){
                    $data['available'] = 'false';
                }
                
            }
            
            
            
            
            
            //fee в селекторе
            if(isset($template_setting['fee_select']['field']['status']) && $template_setting['fee_select']['field']['status']){
                $data['fee'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['fee_select']['field']['status'],'fee_select');
            }elseif(isset($template_setting['fee_input']) && $template_setting['fee_input']){
                $data['fee'] = $this->prepareField($template_setting['fee_input']);
            }
            
            if(!isset($template_setting['model']['field']['status']) || (isset($template_setting['model']['field']['status'])  && $template_setting['model']['field']['status']) ){
                
                //модель
                $data['model'] = $this->getNameAttribute($product,$template_setting,'model');
                
            }
            
            if(isset($template_setting['divide_on_option_add_to_model']) && $template_setting['divide_on_option_add_to_model'] && isset($data['model']) && isset($product['option_add_model_name']) && $product['option_add_model_name']){
                $data['model'] .= ' '.$this->prepareField($product['option_add_model_name']);
            }
            
            if(isset($template_setting['text_capitalize']) && $template_setting['text_capitalize'] && isset($data['model'])){
                $data['model'] = mb_convert_case($data['model'], MB_CASE_TITLE, "UTF-8");
            }
            
            if(isset($template_setting['dispublic_quantity']) && !$template_setting['dispublic_quantity'] && $data['available']=='false' ){
                $skip_this_offer = TRUE;
            }
            
            //sales_notes в селекторе
            if(isset($template_setting['sales_notes_select']['field']['status']) && $template_setting['sales_notes_select']['field']['status']){
                $data['sales_notes'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['sales_notes_select']['field']['status'],'sales_notes_select');
            }elseif(isset($template_setting['sales_notes']) && $template_setting['sales_notes']){
                $data['sales_notes'] = $this->prepareField($template_setting['sales_notes']);
            }
            
            if(isset($template_setting['sales_notes_select_on_available_true']['field']['status']) && $template_setting['sales_notes_select_on_available_true']['field']['status'] && $data['available'] == 'true'){
                $data['sales_notes'] = $this->getNameAttributeForType($product,$template_setting,$template_setting['sales_notes_select_on_available_true']['field']['status'],'sales_notes_select_on_available_true');
            }elseif(isset($template_setting['sales_notes_on_available_true']) && $template_setting['sales_notes_on_available_true'] && $data['available'] == 'true'){
                $data['sales_notes'] = $this->prepareField($template_setting['sales_notes_on_available_true']);
            }
            
            if(isset($template_setting['sales_notes_on_available_false']) && $template_setting['sales_notes_on_available_false'] && $data['available'] == 'false'){
                $data['sales_notes'] = $this->prepareField($template_setting['sales_notes']);
            }elseif(isset($template_setting['sales_notes_on_available_false']) && $template_setting['sales_notes_on_available_false'] && $data['available'] == 'true'){
                $data['sales_notes'] = '';
            }
            
            //param
            $param_atributes = array();
            if($product['ym_attributes']){
                $param_atributes = $this->getParamAttribute($product['ym_attributes'],$template_setting);
            }
            
            $param_options = array();
            if($product['ym_options']){
                $param_options = $this->getParamOption($product['ym_options']);
                
                if($param_options){
                    
                    $param_options_temp = $param_options;
                    
                    $param_options = array();
                    
                    foreach ($param_options_temp as $param_option_value) {
                        $param_options[$param_option_value['name'].'_'.$param_option_value['value']] = $param_option_value;
                    }
                    
                }
            }
            
            if($param_options || $param_atributes){
                $data['param'] = array_merge($param_options,$param_atributes);
            }
            
            if(isset($template_setting['text_capitalize']) && $template_setting['text_capitalize'] && isset($data['param'])){
                
                $param_name = $data['param'];
                
                $data['param'] = array();
                
                foreach ($param_name as $key_param => $value_param) {
                    $data['param'][ $key_param ]['name'] = mb_convert_case($value_param['name'], MB_CASE_TITLE, "UTF-8");
                    $data['param'][ $key_param ]['value'] = mb_convert_case($value_param['value'], MB_CASE_TITLE, "UTF-8");
                    if(isset($value_param['unit'])){
                        
                        $data['param'][ $key_param ]['unit'] = $value_param['unit'];
                        
                    }
                }
                
            }
            
            $param_to_url = array();
            
            //дополнительные элементы
            if(isset($this->general_setting['count_custom_elements'])){
                
                $count_custom_elements = (int)$this->general_setting['count_custom_elements'];
                
                if($count_custom_elements){
                    
                    for($i=0;$i<$count_custom_elements;$i++){
                        
                        $name_element_key = 'custom_elements_name_'.$i;
                        
                        $field_element_key = 'custom_elements_field_'.$i;
                        
                        if(isset($template_setting[$name_element_key]) && $template_setting[$name_element_key] && isset($template_setting[$field_element_key]) && $template_setting[$field_element_key]['field']['status']){
                            
                            $data['custom_elements'][$template_setting[$name_element_key]] = $this->getNameAttributeForType($product,$template_setting,$template_setting[$field_element_key]['field']['status'],$field_element_key);
                            
                        }
                        
                    }
                    
                    for($i=0;$i<$count_custom_elements;$i++){
                        
                        $name_element_key = 'param_to_url_name_'.$i;
                        
                        $field_element_key = 'param_to_url_value_'.$i;
                        
                        if(isset($template_setting[$name_element_key]) && $template_setting[$name_element_key]!='' && isset($template_setting[$field_element_key]) && $template_setting[$field_element_key]['field']['status']){
                            
                            $param_to_url[] = $template_setting[$name_element_key].'='.$this->getNameAttributeForType($product,$template_setting,$template_setting[$field_element_key]['field']['status'],$field_element_key);
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if($param_to_url){
                
                $data['url'] .= '&'.implode('&', $param_to_url);
                
            }
            
            $data['bid'] = '';
            
            for($i=0;$i<5;$i++){
                        
                $name_element_key = 'bid_field_to_db_'.$i;

                $field_element_key = 'bid_field_to_db_oper_'.($i-1);

                if($i==0 && isset($template_setting[$name_element_key]['field']['status']) && $template_setting[$name_element_key]['field']['status']){

                    $data['bid'] = $this->getNameAttributeForType($product,$template_setting,$template_setting[$name_element_key]['field']['status'],$name_element_key);;

                }
                
                if(isset($template_setting[$field_element_key]) && isset($template_setting[$name_element_key]['field']['status']) && $template_setting[$name_element_key]['field']['status']){
                    
                    if($template_setting[$field_element_key]=='+'){
                        
                        $data['bid'] = $data['bid'] + $this->getNameAttributeForType($product,$template_setting,$template_setting[$name_element_key]['field']['status'],$name_element_key);;
                        
                    }elseif($template_setting[$field_element_key]=='-'){
                        
                        $data['bid'] = $data['bid'] - $this->getNameAttributeForType($product,$template_setting,$template_setting[$name_element_key]['field']['status'],$name_element_key);;
                        
                    }elseif($template_setting[$field_element_key]=='*'){
                        
                        $data['bid'] = $data['bid'] * $this->getNameAttributeForType($product,$template_setting,$template_setting[$name_element_key]['field']['status'],$name_element_key);;
                        
                    }elseif($template_setting[$field_element_key]=='/'){
                        
                        $data['bid'] = $data['bid'] / $this->getNameAttributeForType($product,$template_setting,$template_setting[$name_element_key]['field']['status'],$name_element_key);;
                        
                    }
                    
                }
                
            }
            
            if($data['bid']>0){
                
                $data['bid'] = round($data['bid']*100);
                
            }
            
            $data['cbid'] = '';
            
            for($i=0;$i<5;$i++){
                        
                $name_element_key = 'cbid_field_to_db_'.$i;

                $field_element_key = 'cbid_field_to_db_oper_'.($i-1);

                if($i==0 && isset($template_setting[$name_element_key]['field']['status']) && $template_setting[$name_element_key]['field']['status']){

                    $data['cbid'] = $this->getNameAttributeForType($product,$template_setting,$template_setting[$name_element_key]['field']['status'],$name_element_key);;

                }
                
                if(isset($template_setting[$field_element_key]) && isset($template_setting[$name_element_key]['field']['status']) && $template_setting[$name_element_key]['field']['status']){
                    
                    if($template_setting[$field_element_key]=='+'){
                        
                        $data['cbid'] = $data['cbid'] + $this->getNameAttributeForType($product,$template_setting,$template_setting[$name_element_key]['field']['status'],$name_element_key);;
                        
                    }elseif($template_setting[$field_element_key]=='-'){
                        
                        $data['cbid'] = $data['cbid'] - $this->getNameAttributeForType($product,$template_setting,$template_setting[$name_element_key]['field']['status'],$name_element_key);;
                        
                    }elseif($template_setting[$field_element_key]=='*'){
                        
                        $data['cbid'] = $data['cbid'] * $this->getNameAttributeForType($product,$template_setting,$template_setting[$name_element_key]['field']['status'],$name_element_key);;
                        
                    }elseif($template_setting[$field_element_key]=='/'){
                        
                        $data['cbid'] = $data['cbid'] / $this->getNameAttributeForType($product,$template_setting,$template_setting[$name_element_key]['field']['status'],$name_element_key);;
                        
                    }
                    
                }
                
            }
            
            if($data['cbid']>0){
                
                $data['cbid'] = round($data['cbid']*100);
                
            }
            
            if(!$skip_this_offer){
                $this->setOffer($data);
            }
            
            return;
        }
        
        public function getParamOption($ym_options) {
            $result = array();
            foreach ($ym_options as $key => $value) {
                $name = $this->prepareField($value['name']);
                $value['unit'] = $this->prepareField($value['unit']);
                $unit = '';
                if($value['unit']){
                    $unit = $value['unit'];
                }
                if(isset($value['product_option_value']) && $value['product_option_value']){
                    foreach ($value['product_option_value'] as $key => $product_option_value) {
                        if(!$unit){
                            $result[] = array('name'=>  $name,'value'=>  $this->prepareField($product_option_value['name']));
                        }else{
                            $result[] = array('name'=>  $name,'value'=>  $this->prepareField($product_option_value['name']),'unit'=>$unit);
                        }
                    }
                }
            }
            return $result;
        }
        
        public function getParamAttribute($ym_attributes,$template_setting=array()) {
            $result = array();
            foreach ($ym_attributes as $key => $value) {
                $value['unit'] = $this->prepareField($value['unit']);
                $unit = '';
                if($value['unit']){
                    $unit = $value['unit'];
                }
                if(isset($value['attribute']) && $value['attribute']){
                    foreach ($value['attribute'] as $key => $attribute) {
                        
                        
                         if(isset($template_setting['attribute_sintaxis']) && $template_setting['attribute_sintaxis']){
                    
                            $name_attribute = $this->prepareField($attribute['name']);
                            $value_attribute = $this->prepareField($attribute['text']);

                        }else{

                            $name_attribute = $this->prepareField($value['name']);
                            $value_attribute = $this->prepareField($attribute['name'].' '.$attribute['text']);

                        }
                        
                        
                        if(!$unit){
                            $result[] = array('name'=>  $name_attribute,'value'=>  $value_attribute);
                        }else{
                            $result[] = array('name'=>  $name_attribute,'value'=>  $value_attribute,'unit'=>$unit);
                        }
                    }
                }
            }
            return $result;
        }
        
        public function getNameAttributeForType($product,$template_setting,$composite_types,$field_name) {
            
            $result = '';
            switch ($composite_types){
                case 'attribute_id':
                    $attributes_parts = explode('___', $template_setting[$field_name]['field'][$composite_types]);
                    $attribute_group_id = $attributes_parts[0];
                    $attribute_id = $attributes_parts[1];
                    if($product['all_attributes']){
                        foreach ($product['all_attributes'] as $group_attributes) {
                            if($group_attributes['attribute_group_id'] == $attribute_group_id && $group_attributes['attribute']){
                                foreach ($group_attributes['attribute'] as $attribute_group_value) {
                                    if($attribute_group_value['attribute_id']==$attribute_id){
                                        $result = trim($this->prepareField($attribute_group_value['text']));
                                    }
                                }

                            }
                        }
                    }
                    break;
                case 'option_id':
                    $option_id = $template_setting[$field_name]['field'][$composite_types];
                    if($product['all_options']){
                        foreach ($product['all_options'] as $option) {
                            if($option['option_id'] == $option_id){

                                $name_option = trim($this->prepareField($option['name']));
                                $name_option_vields = array();
                                foreach ($option['product_option_value'] as $product_option_value) {
                                    $name_option_vields[] = trim($this->prepareField($product_option_value['name']));
                                }
                                $result = implode(' ', $name_option_vields);
                            }
                        }
                    }
                    break;
                case 'manufacturer_id':
                    $product['manufacturer'] = $this->prepareField($product['manufacturer']);
                    if($product['manufacturer']){
                        $result = $product['manufacturer'];
                    }
                    break;

                case 'price':
                    $result = $this->prices[$product['product_id']];
                    break;

                case 'weight':
                    if((float)$product['weight']>0){
                        $result = (float)$this->weight->format($product['weight'],$product['weight_class_id']);
                    }
                    break;

                case 'length_width_height':
                    $length_width_height = array();
                    if((float)$product['length']>0){
                        $length_width_height[] = (float)$this->length->format($product['length'],$product['length_class_id']);
                    }
                    if((float)$product['width']>0){
                        $length_width_height[] = (float)$this->length->format($product['width'],$product['length_class_id']);
                    }
                    if((float)$product['height']>0){
                        $length_width_height[] = (float)$this->length->format($product['height'],$product['length_class_id']);
                    }
                    if($length_width_height){
                        $result = implode('/', $length_width_height);
                    }
                    break;
                case 'category_id':
                    if(isset($this->categories[$product['category_id']]['name'])){
                        $result = $this->categories[$product['category_id']]['name'];
                    }
                    break;
                case 'text_field':
                    if(isset($template_setting[$field_name]['field']['text_field'])){
                        $result = $this->prepareField($template_setting[$field_name]['field']['text_field']);
                    }
                    break;
                case 'keywords':
                    if(isset($product['tag'])){
                        $result = str_replace(', ',',', $this->prepareField($product['tag'])) ;
                    }
                    break;
                case 'description_whis_html':
                    if($product['description']){
                        $result = '<![CDATA['. html_entity_decode($product['description']).']]>';
                    }
                    break;
                    
                default:
                if(isset($product[$composite_types])){
                    $product[$composite_types] = $this->prepareField($product[$composite_types]);
                    if($product[$composite_types]){
                        $result = $product[$composite_types];
                    }
                }
                break;
            }
            return $result;
        }

        public function getDescriptionAttribute($product,$template_setting){
            
            if(!isset($template_setting['offer_description']['field']) || !$template_setting['offer_description']['field']){
                $description = $this->prepareField($product['description']);
                return $description;
            }
            else{
                
                $key = $template_setting['offer_description']['field'];
                
                switch ($key){
                    case 'option_id':
                    $description = '';
                    $option = $this->getParamOption($product['ym_options']);
                    if($option){
                        foreach ($option as $value) {
                            $description .= ' '.implode(' ', $value);
                        }
                    }
                    break;

                    case 'attribute_id':
                    $description = '';
                    $attributes = $this->getParamAttribute($product['ym_attributes']);
                    if($attributes){
                        foreach ($attributes as $value) {
                            $description .= ' '.implode(' ', $value);
                        }
                    }
                    break;

                    case 'meta_title':
                        if(isset($product['meta_title']))
                        $description = $this->prepareField($product['meta_title']);
                    break;
                
                    case 'meta_keyword':
                        if(isset($product['meta_keyword']))
                        $description = $this->prepareField($product['meta_keyword']);
                    break;

                    case 'meta_description':
                        if(isset($product['meta_description']))
                        $description = $this->prepareField($product['meta_description']);
                    break;
                    
                    case 'description':
                        if(isset($product['description']))
                        $description = $this->prepareField($product['description']);
                    break;
                    
                    default:
                        $description = '';
                    break;
                }
                return $description;
            }
            
            $result = $this->prepareField($product['name']);
            if(isset($template_setting['offer_name']['field']) && $template_setting['offer_name']['field']=='name'){
                return $result;
            }
            if(isset($template_setting['offer_name']['field']) && $template_setting['offer_name']['field']=='meta_title' && isset($product['meta_title'])){
                $result = $this->prepareField($product['meta_title']);
                return $result;
            }
            if(isset($template_setting['offer_name']['field']) && $template_setting['offer_name']['field']=='composite' && $template_setting['offer_name']['composite']){
                ksort($template_setting['offer_name']['composite']);
                $name = array();
                foreach ($template_setting['offer_name']['composite'] as $composite) {
                    //атрибут
                    if($composite['status']=='attribute_id'){
                        $attributes_parts = explode('___', $composite['attribute_id']);
                        $attribute_group_id = $attributes_parts[0];
                        $attribute_id = $attributes_parts[1];
                        if($product['all_attributes']){
                            foreach ($product['all_attributes'] as $group_attributes) {
                                if($group_attributes['attribute_group_id'] == $attribute_group_id && $group_attributes['attribute']){
                                    foreach ($group_attributes['attribute'] as $attribute_group_value) {
                                        if($attribute_group_value['attribute_id']==$attribute_id){
                                            $name[] = trim($this->prepareField($attribute_group_value['name'])).': '.trim($this->prepareField($attribute_group_value['text']));
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    //опция
                    elseif($composite['status']=='option_id'){
                        $option_id = $composite['option_id'];
                        if($product['all_options']){
                            foreach ($product['all_options'] as $option) {
                                if($option['option_id'] == $option_id){
                                    
                                    $name_option = trim($this->prepareField($option['name']));
                                    $name_option_vields = array();
                                    foreach ($option['product_option_value'] as $product_option_value) {
                                        $name_option_vields[] = trim($this->prepareField($product_option_value['name']));
                                    }
                                    if($name_option_vields){
                                        $name[] = $name_option.': '.  implode(', ', $name_option_vields);
                                    }else{
                                        $name[] = $name_option;
                                    }
                                }
                            }
                        }
                    }
                    //цена
                    elseif($composite['status']=='price'){
                        $name[] = $this->prices[$product['product_id']];
                    }
                    //вес
                    elseif($composite['status']=='weight'){
                        if((float)$product['weight']>0){
                            $name[] = $this->weight->format($product['weight'],$product['weight_class_id']);
                        }
                    }
                    //производитель
                    elseif($composite['status']=='manufacturer_id'){
                        $product['manufacturer'] = $this->prepareField($product['manufacturer']);
                        if($product['manufacturer']){
                            $name[] = $product['manufacturer'];
                        }
                    }
                    //категория
                    elseif($composite['status']=='category_id'){
                        $name[] = $this->categories[$product['category_id']]['name'];
                    }
                    //габариты
                    elseif($composite['status']=='length_width_height'){
                        $length_width_height = array();
                        if((float)$product['length']>0){
                            $length_width_height[] = $this->length->format($product['length'],$product['length_class_id']);
                        }
                        if((float)$product['width']>0){
                            $length_width_height[] = $this->length->format($product['width'],$product['length_class_id']);
                        }
                        if((float)$product['height']>0){
                            $length_width_height[] = $this->length->format($product['height'],$product['length_class_id']);
                        }
                        if($length_width_height){
                            $name[] = implode('/', $length_width_height);
                        }
                    }
                    //остальные
                    elseif (isset ($product[$composite['status']])) {
                        $product[$composite['status']] = $this->prepareField($product[$composite['status']]);
                        if($product[$composite['status']]){
                            $name[] = $product[$composite['status']];
                        }
                    }
                }
                $result = trim($this->prepareField(implode(' ', $name)));
                return $result;
            }
        }
        
        public function getNameAttribute($product,$template_setting,$field_name){
            
            $result = '';
            
            if(isset($template_setting[$field_name]['field']['status']) && $template_setting[$field_name]['field']['status']!='composite'){
                
                $result = $this->getNameAttributeForType($product,$template_setting,$template_setting[$field_name]['field']['status'],$field_name);
                
            }elseif(isset($template_setting[$field_name]['field']['status']) && $template_setting[$field_name]['field']['status']=='composite'){
                
                $field_type = 'composite';
                
                $count_composite_elements = 10;
                
                $result_parts = array();
                
                for($i=1;$i<$count_composite_elements;$i++){
                    
                    if(isset($template_setting[ $field_name.'_'.$field_type.'_'.$i ]) && $template_setting[ $field_name.'_'.$field_type.'_'.$i ]){
                        
                        $result_parts[] = $this->getNameAttributeForType($product,$template_setting,$template_setting[ $field_name.'_'.$field_type.'_'.$i ]['field']['status'],$field_name.'_'.$field_type.'_'.$i);
                        
                    }
                    
                }
                
                if($result_parts){
                    
                    $result = implode(' ', $result_parts);
                    
                }
                
                
            }
            return $result;
        }
        
        public function getTemplateSettingNameComposite() {
            $columns_product_description = $this->db->query('SHOW COLUMNS FROM '.DB_PREFIX.'product_description');
            $columns_product = $this->db->query('SHOW COLUMNS FROM '.DB_PREFIX.'product');

            $template_setting_name_composite['name'] = 'name';
            if($columns_product_description->rows){
                foreach($columns_product_description->rows as $column){
                    if($column['Field']=='meta_title'){
                        $template_setting_name_composite['meta_title'] = 'meta_title';
                    }
                }
            }
            $unset_product_fileds = array_flip(array('quantity','stock_status_id','image','shipping','points','tax_class_id','date_available','weight_class_id','length_class_id','subtract','minimum','sort_order','status','viewed','date_added','date_modified'));
            $product_fileds = array();
            if($columns_product->rows){
                foreach($columns_product->rows as $key=>$column){
                    if(!isset($unset_product_fileds[$column['Field']])){
                        $product_fileds[$column['Field']] = $column['Field'];
                    }
                }
            }
            if(isset($product_fileds['length']) && isset($product_fileds['width']) && isset($product_fileds['height'])){
                unset($product_fileds['length']);
                unset($product_fileds['width']);
                unset($product_fileds['height']);
                $product_fileds['length_width_height'] = 'length_width_height';
            }
            $template_setting_name_composite += $product_fileds;
            $template_setting_name_composite['category_id'] = 'category_id';
            $template_setting_name_composite['option_id'] = 'option_id';
            $template_setting_name_composite['attribute_id'] = 'attribute_id';
            return $template_setting_name_composite;
        }

        public function getDeliveryOption($tamplate_setting,$price='',$weight='',$stock_status_id=''){
            $result = array();
            if(isset($tamplate_setting['delivery-options']['status'])){
                unset($tamplate_setting['delivery-options']['status']);
            }
            foreach ($tamplate_setting['delivery-options'] as $delivery_options) {
                $delivery_options['days'] = trim($delivery_options['days']);
                $delivery_options['order-before'] = trim($delivery_options['order-before']);
                $delivery_options['cost'] = trim($delivery_options['cost']);
                
                $skip = FALSE;
                //var_dump($delivery_options['price_from']);exit();
                if(isset($delivery_options['price_to']) && $delivery_options['price_to']!='' && isset($delivery_options['price_from']) && $delivery_options['price_from']!='' && $price!=''){
                    
                    
                    if($price>=$delivery_options['price_to'] || $price<$delivery_options['price_from']){
                        
                        $skip = TRUE;
                        
                    }
                    
                }elseif(isset($delivery_options['weight_from']) && $delivery_options['weight_from']!='' && isset($delivery_options['weight_to']) && $delivery_options['weight_to']!='' && $weight!=''){
                    
                    if($weight>=$delivery_options['weight_to'] || $weight<$delivery_options['weight_from']){
                        
                        $skip = TRUE;
                        
                    }
                    
                }
                
                if(isset($delivery_options['stock_status_id']) && $stock_status_id!='' && !isset($delivery_options['stock_status_id'][$stock_status_id])){
                    
                    $skip = TRUE;
                    
                }
                if(!$skip && ($delivery_options['cost']!='' || $delivery_options['days']!='' || $delivery_options['order-before']!='')){
                    if($delivery_options['cost']!=''){
                        $option['cost'] = (int)$delivery_options['cost'];
                    }
                    if($delivery_options['days']!=''){
                        $option['days'] = $delivery_options['days'];
                    }
                    if($delivery_options['order-before']!=''){
                        $option['order-before'] = $delivery_options['order-before'];
                    }
                    $result[] = $option;
                    unset($option);
                }
            }
            return $result;
        }
        
        public function getPrice($price,$product,$tamplate_setting){
            
            $result_price = 0.0;
            $price = $this->tax->calculate($price, $product['tax_class_id']);
            $new_price = (float)$price;
            if(isset($tamplate_setting['ymlprice']) && $tamplate_setting['ymlprice']){
                $tamplate_setting['ymlprice'] = (float)$tamplate_setting['ymlprice'];
                $new_price = $new_price - $tamplate_setting['ymlprice']/100*$price;
            }
            
            if($new_price==0.0){
                $result_price =  $price;
            }else{
                $result_price = $new_price;
            }
            
            if(isset($tamplate_setting['price_currencies_from']) && $tamplate_setting['price_currencies_from'] && isset($tamplate_setting['price_currencies_to']) && $tamplate_setting['price_currencies_to']){
                
                $result_price = $this->currency->convert($result_price,$tamplate_setting['price_currencies_from'],$tamplate_setting['price_currencies_to']);
                
            }
            
            return $result_price;
        }
        
        public function getPictureAttributes($product,$tamplate_setting) {
            if(isset($tamplate_setting['count_pictures']) && !$tamplate_setting['count_pictures']){
                return array();
            }elseif(isset($tamplate_setting['count_pictures'])){
                $count_pictures = (int)$tamplate_setting['count_pictures'];
            }else{
                $count_pictures = 1;
            }
            
            $pictures_sizes = 500;
            
            if(isset($tamplate_setting['pictures_sizes'])){
                $tamplate_setting['pictures_sizes'] = (int)$tamplate_setting['pictures_sizes'];
                if($tamplate_setting['pictures_sizes']>0){
                    $pictures_sizes = $tamplate_setting['pictures_sizes'];
                }
            }
            $result = array();
            if ($product['image'] && $product['image']!='no_image.jpg' && $product['image']!='no_image.png' && $product['image']!='no-image.jpg' && $product['image']!='no-image.png') {
                $this->load->model('tool/image');
                $result[] = $this->model_tool_image->resize($product['image'], $pictures_sizes, $pictures_sizes);
                if($product['images']){
                    for($i=1;($i<$count_pictures && isset($product['images'][$i]));$i++){
                        // чтобы не было дублежа картинок
                        if($product['images'][$i]['image']!=$product['image']){
                            $result[] = $this->model_tool_image->resize($product['images'][$i]['image'], $pictures_sizes, $pictures_sizes);
                        }
                    }
                }
            }
            return $result;
        }

        public function getCategoriesAndOffers($filter_data_group_id,$content_language_id,$setting_yml=array()) {
            $ym_categories = array();
            $this->load->model('extension/feed/ocext_feed_generator_yamarket');
            $all_yml_export_ocext_ym_filter_data_categories = $this->model_extension_feed_ocext_feed_generator_yamarket->getFilterData('ocext_feed_generator_yamarket_ym_filter_category',$filter_data_group_id);
            if($all_yml_export_ocext_ym_filter_data_categories){
                $ym_categories = $all_yml_export_ocext_ym_filter_data_categories;
                if($ym_categories){
                    foreach ($ym_categories as $category_id=>$ym_category){
                        if(!isset($ym_category['category_id'])){
                            unset($ym_categories[$category_id]);
                        }
                    }
                    
                    //если опустел, то категории не отмечены - нужны все данные - возвращаем туда всё, что там лежало
                    if(!$ym_categories){
                        $ym_categories = $all_yml_export_ocext_ym_filter_data_categories;
                    }
                }
            }
            $ym_manufacturers = array();
            $all_yml_export_ocext_ym_filter_data_manufacturers = $this->model_extension_feed_ocext_feed_generator_yamarket->getFilterData('ocext_feed_generator_yamarket_ym_filter_manufacturers',$filter_data_group_id);
            if($all_yml_export_ocext_ym_filter_data_manufacturers){
                $ym_manufacturers = $all_yml_export_ocext_ym_filter_data_manufacturers;
                if($ym_manufacturers){
                    foreach ($ym_manufacturers as $manufacturer_id=>$ym_manufacturer){
                        if(!isset($ym_manufacturer['manufacturer_id'])){
                            unset($ym_manufacturers[$manufacturer_id]);
                        }
                    }
                    //если опустел, то категории не отмечены - нужны все данные - возвращаем туда всё, что там лежало
                    if(!$ym_manufacturers){
                        $ym_manufacturers = $all_yml_export_ocext_ym_filter_data_manufacturers;
                        $ym_manufacturers[''] = array("setting_id"=>"0");
                        $ym_manufacturers[0] = array("setting_id"=>"0");
                    }
                }
            }
            
            //Получаем список товаров для выгрузки и список категорий
            $this->load->model('extension/feed/ocext_feed_generator_yamarket');
            $categories_and_products = $this->model_extension_feed_ocext_feed_generator_yamarket->getCategoriesAndProducts($ym_categories,$ym_manufacturers,$filter_data_group_id,$content_language_id);
            
            if(!isset($setting_yml['products']) || !isset($setting_yml['catalog']) || !$categories_and_products[$setting_yml['products']] || !$categories_and_products[$setting_yml['catalog']]){
                return FALSE;
            }else{
                return $categories_and_products;
            }
        }
        
        private function prepareField($field) {
            if(is_string($field)){
                $field = strip_tags(htmlspecialchars_decode($field));
                $from = array('"', '&', '>', '<', '\'','`','&acute;','™','©');
                $to = array('&quot;', '&amp;', '&gt;', '&lt;', '&apos;','','','','');
                $field = str_replace($from, $to, $field);
                $field = trim($field);
            }
            return $field;
	}
        
        private function setShopAttributes($name, $value) {
            $attributes = array('name', 'company', 'url', 'platform', 'version');
            if (in_array($name, $attributes)) {
                    $this->shop[$name] = $this->prepareField($value);
            }
	}
        
        private function setCurrencyAttributes($currency, $rate = 'CBRF') {
            if($currency){
                if(!isset($this->currencies[0])){
                    $this->currencies[] = array(
                        'id'=>$currency,
                        'rate'=>1
                    );
                }else{
                    $this->currencies[] = array(
                        'id'=>$currency,
                        'rate'=>$rate
                    );
                }
                return TRUE;
            }else{
                return FALSE;
            }
	}
        
        private function setCategoryAttrubite($name, $category_id, $parent_id = 0) {
            $name = $this->prepareField($name);
            if(!$category_id || !$name) {
                return;
            }
            if((int)$parent_id > 0) {
                $this->categories[$category_id] = array(
                        'id'=>$category_id,
                        'parentId'=>(int)$parent_id,
                        'name'=>$this->prepareField($name)
                );
            }else{
                $this->categories[$category_id] = array(
                    'id'=>$category_id,
                    'name'=>$this->prepareField($name)
                );
            }
	}
        
        protected function getPathWhisCategories($category_id,$old_path = '') {
            if (isset($this->categories[$category_id])) {
                if (!$old_path) {
                    $new_path = $this->categories[$category_id]['id'];
                } else {
                    $new_path = $this->categories[$category_id]['id'].'_' .$old_path;
                }	
                if (isset($this->categories[$category_id]['parentId'])) {
                    return $this->getPathWhisCategories($this->categories[$category_id]['parentId'], $new_path);
                } else {
                    return $new_path;
                }
            }
	}
        
        
        private function setOffer($data) {
            
            $custom_elements = array();
            if(isset($data['custom_elements'])){
                
                $custom_elements = $data['custom_elements'];
                
            }
            
            $offer = array();
            $attributes = array('id', 'type', 'available', 'bid', 'cbid', 'param', 'fee');
            $attributes = array_intersect_key($data, array_flip($attributes));
            foreach ($attributes as $key => $value) {
                switch ($key){
                    case 'id':
                    if ($value > 0) {
                            $offer[$key] = $value;
                    }
                    break;
                    
                    case 'fee':
                    $value = (int)$value;
                    if ($value > 0) {
                            $offer[$key] = $value;
                    }
                    break;

                    case 'type':
                    if (in_array($value, array('vendor.model'))) {
                            $offer['type'] = $value;
                    }
                    break;

                    case 'available':
                    $offer['available'] = (($value=='true') ? 'true' : 'false');
                    break;

                    case 'param':
                    if (is_array($value)) {
                        $offer['param'] = $value;
                    }
                    break;
                    default:
                    break;
                }
            }
            $type = isset($offer['type']) ? $offer['type'] : '';
            $finded_tags = array('url'=>0, 'price'=>0);
            
            if(isset($data['oldprice']) && $data['oldprice']>0){
                $finded_tags['oldprice'] = 1;
            }
            
            $finded_tags = array_merge($finded_tags,array('currencyId'=>1, 'categoryId'=>1,'market_category'=>0, 'picture'=>0, 'store'=>0, 'pickup'=>0, 'delivery'=>0,'delivery-options'=>0));
            
            switch ($type) {
                case 'vendor.model':
                    $finded_tags = array_merge($finded_tags, array('name'=>0,'vendor'=>0, 'vendorCode'=>0, 'model'=>0));
                    break;
                default:
                    $finded_tags = array_merge($finded_tags, array('name'=>0, 'vendor'=>0, 'vendorCode'=>0, 'model'=>0));
                    break;
            }
            $finded_tags = array_merge($finded_tags, array('description'=>0, 'typePrefix'=>0, 'sales_notes'=>0, 'manufacturer_warranty'=>0, 'country_of_origin'=>0, 'adult'=>0, 'barcode'=>0, 'weight'=>0,'description'=>0, 'dimensions'=>0, 'age'=>0, 'cpa'=>0, 'rec'=>0));
            $requiredes = array_filter($finded_tags);
            if (sizeof(array_intersect_key($data, $requiredes)) != sizeof($requiredes)) {
                    return;
            }
            $data = array_intersect_key($data, $finded_tags);
            $finded_tags = array_intersect_key($finded_tags, $data);
            $offer['data'] = array();
            foreach ($finded_tags as $key => $value) {
                    $offer['data'][$key] = $this->prepareField($data[$key]);
            }
            
            if($custom_elements){
                
                foreach ($custom_elements as $key => $value) {
                    $offer['data'][$key] = $value;
                }
            }
            
            $this->offers[] = $offer;
	}
        
        
        private function getYml() {
		$yml  = '<?xml version="1.0" encoding="UTF-8"?>' . $this->eol;
		$yml .= '<!DOCTYPE yml_catalog SYSTEM "shops.dtd">' . $this->eol;
		$yml .= '<yml_catalog date="' . date('Y-m-d H:i') . '">' . $this->eol;
		$yml .= '<shop>' . $this->eol;
		$yml .= $this->createTag($this->shop);
		$yml .= '<currencies>' . $this->eol;
		foreach ($this->currencies as $currency) {
			$yml .= $this->getElement($currency, 'currency');
		}
		$yml .= '</currencies>' . $this->eol;
		$yml .= '<categories>' . $this->eol;
		foreach ($this->categories as $category) {
			$category_name = $category['name'];
			unset($category['name'], $category['export']);
			$yml .= $this->getElement($category, 'category', $category_name);
		}
		$yml .= '</categories>' . $this->eol;
                if($this->delivery_option){
                    $yml .= $this->createTag($this->delivery_option);
                }
		$yml .= '<offers>' . $this->eol;
		foreach ($this->offers as $offer) {
			$rows = $this->createTag($offer['data']);
			unset($offer['data']);
			if (isset($offer['param'])) {
                            $rows .= $this->createParam($offer['param']);
                            unset($offer['param']);
			}
			$yml .= $this->getElement($offer, 'offer', $rows);
		}
		$yml .= '</offers>' . $this->eol;
		$yml .= '</shop>';
		$yml .= '</yml_catalog>';
                //пишем файл
                $rootPath = realpath(DIR_APPLICATION . '..'); 
                
                if(isset($this->general_setting[$this->parse_yml['export_filename']]) && $this->general_setting[$this->parse_yml['export_filename']]){
                    
                    $file_name_and_path = $rootPath.'/'.$this->general_setting['filename_export'].'.xml';
                
                    $dirname = dirname($file_name_and_path);

                    $handle = FALSE;

                    if($file_name_and_path && !file_exists($file_name_and_path)){

                        if(!is_dir($dirname)){

                            mkdir($dirname,0777,TRUE);

                        }

                        $handle = fopen($file_name_and_path, "w");

                    }elseif(file_exists($file_name_and_path)){

                        $handle = fopen($file_name_and_path, "w");

                    }

                    if($handle){
                        fwrite($handle, $yml);
                        fclose($handle);
                    }
                    
                }
		return $yml;
	}
        
        public function checklicense() {
            //asju
            eval(base64_decode('JGdlbmVyYWxfc2V0dGluZyA9ICR0aGlzLT5jb25maWctPmdldCgnb2NleHRfZmVlZF9nZW5lcmF0b3JfeWFtYXJrZXRfZ2VuZXJhbF9zZXR0aW5nJyk7DQogICAgICAgICAgICBpZihpc3NldCgkZ2VuZXJhbF9zZXR0aW5nWyd1c2VyX2tleSddKSAmJiBpc3NldCgkZ2VuZXJhbF9zZXR0aW5nWyd1c2VyX2VtYWlsJ10pKXsNCiAgICAgICAgICAgICAgICAkdGhpcy0+bF9kYXRhWyd1J10gPSAkZ2VuZXJhbF9zZXR0aW5nWyd1c2VyX2tleSddOw0KICAgICAgICAgICAgICAgICR0aGlzLT5sX2RhdGFbJ2UnXSA9ICRnZW5lcmFsX3NldHRpbmdbJ3VzZXJfZW1haWwnXTsNCiAgICAgICAgICAgIH1lbHNlew0KICAgICAgICAgICAgICAgICR0aGlzLT5sX2RhdGFbJ3UnXSA9IG1kNSh0aW1lKCkpOw0KICAgICAgICAgICAgICAgICR0aGlzLT5sX2RhdGFbJ2UnXSA9IHRpbWUoKTsNCiAgICAgICAgICAgIH0='));//OCext.com: do not delete this line | не удаляйте эту строку
            //indjds
            eval(base64_decode('aWYoZmlsZV9leGlzdHMoJF9TRVJWRVJbJ0RPQ1VNRU5UX1JPT1QnXS4nL3N5c3RlbS9saWJyYXJ5L3ZlbmRvci9vY2V4dC9vY2V4dF9mZWVkX2dlbmVyYXRvcl95YW1hcmtldF9saWNlbnNlLnBocCcpKXsNCiAgICAgICAgICAgICAgICBpbmNsdWRlX29uY2UgJF9TRVJWRVJbJ0RPQ1VNRU5UX1JPT1QnXS4nL3N5c3RlbS9saWJyYXJ5L3ZlbmRvci9vY2V4dC9vY2V4dF9mZWVkX2dlbmVyYXRvcl95YW1hcmtldF9saWNlbnNlLnBocCc7DQogICAgICAgICAgICB9'));//OCext.com: do not delete this line | не удаляйте эту строку
        }

	private function getElement($attributes, $element_name, $element_value = '') {
            $retval = '<'.$element_name.' ';
            foreach ($attributes as $key => $value) {
                $retval .= $key .'="'.$value.'" ';
            }
            $retval .= $element_value ? '>' .$this->eol. $element_value.'</'.$element_name.'>' : '/>';
            $retval .= $this->eol;
            return $retval;
	}
        
	private function createTag($tags) {
            $retval = '';
            foreach ($tags as $key => $value) {
                if(!is_array($value) && ($value || $value===0.0 || $value===0)){
                    $retval .= '<'.$key.'>'.$value.'</'.$key .'>'.$this->eol;
                }elseif (is_array($value) && $key == 'delivery-options') {
                    $retval .= $this->createDeliveryOptions($value); 
                }elseif (is_array($value) && $key == 'age') {
                    $retval .= '<'.$key.' unit="'.$value['unit'].'">'.$value['value'].'</'.$key.'>' . $this->eol;
                }elseif (is_array($value)) {
                    foreach ($value as $key_two=>$value_two) {
                        $retval .= '<'.$key.'>'.$value_two.'</'.$key.'>' . $this->eol;
                    }
                }
            }
            return $retval;
	}
        
	private function createParam($params) {
            $retval = '';
            foreach ($params as $param) {
                $retval .= '<param name="'.$this->prepareField($param['name']);
                if (isset($param['unit'])) {
                        $retval .= '" unit="'.$this->prepareField($param['unit']);
                }
                $retval .= '">'.$this->prepareField($param['value']) . '</param>'.$this->eol;
            }
            return $retval;
	}
        
        private function createDeliveryOptions($delivery_options) {
            $retval = '';
            if($delivery_options){
                foreach ($delivery_options as $option) {
                    if(isset($option['cost']) && isset($option['days'])){
                        $retval .= '<option cost="' . trim($option['cost']).'" days="'.trim($option['days']).'';
                        if (isset($option['order-before']) && $option['order-before']) {
                                $retval .= '" order-before="' . trim($option['order-before']);
                                unset($option['order-before']);
                        }
                        $retval .= '"/>'.$this->eol;
                    }
                }
            }
            if($retval){
                $retval = '<delivery-options>'.$this->eol.$retval.'</delivery-options>'.$this->eol;
            }
            
            return $retval;
	}
        
        public function sendErrorXML($errors) {
            $yml  = '<?xml version="1.0" encoding="UTF-8"?>' . $this->eol;
            $yml .= '<errors date="' . date('Y-m-d H:i') . '">' . $this->eol;
            foreach ($errors as $error) {
                $yml .= $this->createTag(array('error'=>$error)) . $this->eol;
            }
            $yml .= '</errors>';
            $this->response->addHeader('Content-Type: application/xml');
            $this->response->setOutput($yml);
        }
}
?>