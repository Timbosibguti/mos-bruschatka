<?php
//  Live Price / Живая цена (Динамическое обновление цены)
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

class ModelModuleLivePrice extends Model {

	private $extension_code = 'lp2';
	// var $lp_type = "lppro"; // the text is left there but commented out for compatibility with old versions of Related Options
  private $options_selects = array('select','radio','image','block','color','nwd_color');
  private $cache_cart = array();
  private $cache_price = array();
  private $language_loaded = false;
  private $module_installed_status = null;
  private $ro_installed_status = null;
  private $io_installed_status = null;
	private $pso_installed_status = null;
  private $global_discounts_status = null;
  private $global_specials_status = null;
	private $theme_name = false;

	public function versionPRO() {
		return ($this->getExtensionCode() == 'lppro');
	}
	
	public function getExtensionCode() {
		return $this->extension_code;
	}
	
  public function installed() {
    if ( is_null($this->module_installed_status) ) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = 'module' AND `code` = 'liveprice'");
      $this->module_installed_status = $query->num_rows;
    }
    return $this->module_installed_status;
  }
  
  public function installedImprovedOptions() {
    if ( is_null($this->io_installed_status) ) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = 'module' AND `code` = 'improvedoptions'");
      $this->io_installed_status = $query->num_rows;
    }
    return $this->io_installed_status;
  }
  
  public function installedRelatedOptions() {
    if ( is_null($this->ro_installed_status) ) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = 'module' AND `code` = 'related_options'");
      $this->ro_installed_status = $query->num_rows;
    }
    return $this->ro_installed_status;
  }
  
  public function hasGlobalDiscounts() {
    if ( is_null($this->global_discounts_status) ) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "liveprice_global_discount LIMIT 1");
      $this->global_discounts_status = $query->num_rows;
    }
    return $this->global_discounts_status;
  }
  public function hasGlobalSpecials() {
    if ( is_null($this->global_specials_status) ) {
      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "liveprice_global_special LIMIT 1");
      $this->global_specials_status = $query->num_rows;
    }
    return $this->global_specials_status;
  }
  
  public function load_language() {
    
    if ( !$this->language_loaded) {
      if ( VERSION >= '2.1.0.0' ) {
        $this->load->language('module/liveprice');
      } else {
        $this->language->language('module/liveprice');
      }
      $this->language_loaded = true;
    }
  }
  
  public function getThemeName() {
		if (!$this->theme_name) {
			$theme_name = '';
			if ( VERSION >= '2.2.0.0' ) {
				if ($this->config->get('config_theme') == 'theme_default') {
					$theme_name = $this->config->get('theme_default_directory');
				} else {
					$theme_name = substr($this->config->get('config_theme'), 0, 6) == 'theme_' ? substr($this->config->get('config_theme'), 6) : $this->config->get('config_theme') ;
				}
			} else {  
				$theme_name = $this->config->get('config_template');
			}
			if ($theme_name == 'BurnEngine') {
				$theme_info = (array) $this->config->get( 'BurnEngine_theme');
				if ($theme_info && !empty($theme_info['id']) ) {
					$theme_name = $theme_name.'_'.$theme_info['id']; 
				}
			}
			// shorten theme name
			$themes_shorten = array('tt_sonic',
															'tt_oxelar',
															'OPC080185_',
															'OPC080188_',
															'tt_andro',
															'tt_veneno',
															'tt_rossi',
															'tt_greentech_home',
															'tt_sagitta',
															'tt_bstore',
															'tt_selphy',
															'tt_orion',
															'aspire',
															'tt_lavoro_home',
															'tt_matalo_home',
															'OPC080187',
															'OPC040_',
															'tt_bege',
															);
			foreach ( $themes_shorten as $theme_shorten ) {
				$theme_shorten_length = strlen($theme_shorten);
				if ( substr($theme_name, 0, $theme_shorten_length) == $theme_shorten ) {
					$theme_name = substr($theme_name, 0, $theme_shorten_length);
					break;
				}
			}
			$this->theme_name = $theme_name;
		}
		return $this->theme_name;
  }
	
	public function getPathToMainJS() {
		return $this->getScriptPathWithVersion('view/extension/live_price/js/liveopencart.live_price.js');
		//return 'catalog/view/extension/live_price/js/liveopencart.live_price.js'.'?v='.$this->getScriptVersion();
	}
	
	public function getPathToCustomJS() {
		
		$possible_paths = array(
			'view/extension/live_price/themes/'.$this->getThemeName().'/'.$this->getThemeName().'.js', // new theme specific directory
			'view/extension/live_price/themes/'.$this->getThemeName().'.js', // new directory
			'view/extension/live_price/js/themes/'.$this->getThemeName().'.js', // old
		);
		
		foreach ( $possible_paths as $path ) {
			if ( file_exists(DIR_APPLICATION.$path) ) {
				return $this->getScriptPathWithVersion($path);
			}
		}
		
		//$filename = 'catalog/view/extension/live_price/js/themes/'.$this->getThemeName().'.js';
		//if ( file_exists($filename) ) {
		//	return $filename.'?v='.$this->getScriptVersion();
		//}
	}
	
	
	private function getScriptPathWithVersion($p_path) {
		
		$path = $p_path;
		if ( substr($path, 0, strlen(DIR_APPLICATION)) == DIR_APPLICATION ) {
			$path = substr($path, strlen(DIR_APPLICATION));
		}
		
		$basic_dir = 'catalog/';
		$file_path = DIR_APPLICATION.$path;
		
		if ( file_exists($file_path) ) {
			return $basic_dir.$path.'?v='.filemtime($file_path);
		}
	}
	
	protected function getCustomTemplates() {
		$dir_theme = 'extension/live_price/themes/'.$this->getThemeName().'/';
		$dir_full = DIR_TEMPLATE.'../'.$dir_theme;
		if ( file_exists($dir_full) ) {
			$files = array();
			foreach ( glob($dir_full.'*.tpl') as $file_name ) {
				
				$files[basename($file_name, '.tpl')] = '../'.$dir_theme.basename($file_name); // path for tpl loader should be based on DIR_TEMPLATE
			}
			return $files;
		}
	}
	
	protected function loadTemplate($route, $data) {
		
		if ( class_exists('Template') ) {
			$template = new Template('basic');
			
			foreach ($data as $key => $value) {
				$template->set($key, $value);
			}
			
			return $template->render($route);
		
		} else { // older version
			
			extract($data);
			
			$file = DIR_TEMPLATE . $route;
			
			ob_start();
			require($file);
			$output = ob_get_contents();
			ob_end_clean();
			
			return $output;
		}
	}
	
	public function modifyProductSpecialQuery($p_sql) {
		
		/*
		$sql = "
			SELECT DISTINCT ps.product_id,
						(SELECT AVG(rating) FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = ps.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating
			FROM " . DB_PREFIX . "product_special ps
				LEFT JOIN " . DB_PREFIX . "product p ON (ps.product_id = p.product_id)
				LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)
				LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)
			WHERE p.status = '1'
				AND p.date_available <= NOW()
				AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
				AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "'
				AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW())
				AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))
			GROUP BY ps.product_id";
		*/	
		
		$sql_special = "
			SELECT PS.product_id, PS.customer_group_id, PS.date_start, PS.date_end, PS.priority, PS.price
			FROM ".DB_PREFIX."product_special PS
		UNION
			SELECT P.product_id, PGS.customer_group_id, PGS.date_start, PGS.date_end, PGS.priority, PGS.price
			FROM ".DB_PREFIX."liveprice_global_special PGS, ".DB_PREFIX."product P
			WHERE (P.manufacturer_id = PGS.manufacturer_id OR PGS.manufacturer_id = -1)
				AND (P.product_id IN (SELECT PTC.product_id FROM ".DB_PREFIX."product_to_category PTC WHERE PTC.category_id = PGS.category_id ) OR PGS.category_id = -1)
		";
		
		$sql = str_replace("FROM ".DB_PREFIX."product_special ps", "FROM (".$sql_special.") ps", $p_sql);
		
		return $sql;
	}
	
	private function getCurrency() {
		if ( isset($this->session->data['currency']) ) {
			$currency =  $this->session->data['currency'];
		} else {
			if ( !$this->model_localisation_currency ) {
				$this->load->model('localisation/currency');
			}
			$currencies = $this->model_localisation_currency->getCurrencies();
			$currency = '';
			if (isset($this->request->cookie['currency']) && !array_key_exists($currency, $currencies)) {
				$currency = $this->request->cookie['currency'];
			}
			if (!array_key_exists($currency, $currencies)) {
				$currency = $this->config->get('config_currency');
			}
		}
		return $currency;
	}
  
  private function format($number) {
    if ( VERSION >= '2.2.0.0' ) {
			return $this->currency->format($number, $this->getCurrency());
      //return $this->currency->format($number, $this->session->data['currency']);
    } else {  
      return $this->currency->format($number);
    }
  }
  
  
  
  public function getPriceStartingFrom($product_info, $price, $special, $tax) {
    
    if ( $this->installed() && ($this->customer->isLogged() || !$this->config->get('config_customer_price')) && $this->versionPRO() ) {
      
      $lp_settings = $this->config->get('liveprice_settings');
      
      if ( !empty($lp_settings['starting_from']) ) {
      
        $starting_prices = $this->getProductDefaultPrice($product_info['product_id'], true);
        
        if ( !empty($lp_settings['show_from']) ) {
          $this->model_module_liveprice->load_language();
          $f_addon = $this->language->get('liveprice_from');
        }
        
        if ( $starting_prices ) {
          if ( ($lp_settings['show_from'] == 1 && $starting_prices['minimal'] )  // for minimal
          || $lp_settings['show_from'] == 2 ) { // for all
            $starting_prices['f_price']   = $starting_prices['f_price'] ? $f_addon.$starting_prices['f_price'] : $starting_prices['f_price'];
            $starting_prices['f_special'] = $starting_prices['f_special'] ? $f_addon.$starting_prices['f_special'] : $starting_prices['f_special']; 
            $starting_prices['f_tax']     = $starting_prices['f_tax'] ? $f_addon.$starting_prices['f_tax'] : $starting_prices['f_tax'];
          }
        } elseif ( !empty($lp_settings['show_from']) && $lp_settings['show_from'] == 2 ) { // for all
          $starting_prices = array();
          $starting_prices['f_price']   = $price ? $f_addon.$price : $price;
          $starting_prices['f_special'] = $special ? $f_addon.$special : $special; 
          $starting_prices['f_tax']     = $tax ? $f_addon.$tax : $tax;
        }
        return $starting_prices;
        
      }
    }
  }
  
  function getRelatedOptionsType() {
    if ( is_null($this->ro_type) ) {
      $this->ro_type = false;
      if ( $this->installedRelatedOptions() ) {
        if ( !$this->model_module_related_options ) {
          $this->load->model('module/related_options');
        }
        if ( method_exists( 'ModelModuleRelatedOptions', 'get_related_options_set_by_poids' ) ) { // related options
          $this->ro_type = 'ro';
        } elseif ( method_exists( 'ModelModuleRelatedOptions', 'get_related_options_sets_by_poids' ) ) { // Related Options PRO or newer version of RO
          $this->ro_type = 'ropro';
        }
      }
    }
    return $this->ro_type;
  }
  
  function getProductFirstROPROVariant( $product_id ) {
    $query = $this->db->query(" SELECT ROVP.relatedoptions_variant_product_id
                                FROM ".DB_PREFIX."relatedoptions_variant_product ROVP
                                    LEFT JOIN ".DB_PREFIX."relatedoptions_variant ROV ON (ROV.relatedoptions_variant_id = ROVP.relatedoptions_variant_id)
                                WHERE ROVP.product_id = ".(int)$product_id."
                                ORDER BY ROV.sort_order, ROV.relatedoptions_variant_name, ROVP.relatedoptions_variant_id, ROVP.relatedoptions_variant_product_id
                                LIMIT 1
                              ");
    if ( $query->num_rows ) {
      return $query->row['relatedoptions_variant_product_id'];
    }
  }
  
  function getROCombination($relatedoptions_id) {
    $query = $this->db->query(" SELECT PO.product_option_id, POV.product_option_value_id
                                FROM ".DB_PREFIX."relatedoptions_option ROO
                                    ,".DB_PREFIX."product_option PO
                                    ,".DB_PREFIX."product_option_value POV
                                WHERE ROO.relatedoptions_id = ".(int)$relatedoptions_id."
                                  AND PO.option_id = ROO.option_id
                                  AND PO.product_id = ROO.product_id
                                  AND POV.option_value_id = ROO.option_value_id
                                  AND POV.product_id = ROO.product_id
                              ");
    $comb = array();
    foreach ( $query->rows as $row ) {
      $comb[$row['product_option_id']] = $row['product_option_value_id'];
    }
    return $comb;
  }
  
  function getProductDefaultPrice($product_id, $inclide_starting_from = false) {  
    
    if ( $this->installed() && $this->versionPRO() ) {
      
      $lp_settings = $this->config->get('liveprice_settings');
      
      $io_defaults = array();
      $ro_minimal = array();
      
      // to get product price including possible discounts with quantity = 0 and possible specials
      $lp_data = $this->getProductPrice( $product_id, 1, array(), 0, array(), array(), array(), false, true, true );
      $product_price = $lp_data['prices']['price_opt'];
      
      $sql_min_options = "SELECT  POV.product_option_value_id
                                , POV.product_option_id
                                , POV.option_value_id
                                , PO.required
                                , OV.sort_order
                                , O.type
                                , POV.price pov_price
                                , (CASE POV.price_prefix
                                    WHEN '+' THEN '".(float)$product_price."' + POV.price
                                    WHEN '%' THEN '".(float)$product_price."'/100*(100+POV.price)
                                    WHEN '*' THEN '".(float)$product_price."'*POV.price
                                    WHEN '/' THEN (CASE POV.price WHEN 0 THEN '".(float)$product_price."' ELSE '".(float)$product_price."'/POV.price END)
                                    WHEN '=' THEN POV.price
                                    WHEN '-' THEN '".(float)$product_price."' - POV.price
                                    ELSE '".(float)$product_price."'
                                  END - '".(float)$product_price."') price
                          FROM ".DB_PREFIX."product_option_value POV
                              ,".DB_PREFIX."option_value OV
                              ,".DB_PREFIX."product_option PO
                              ,`".DB_PREFIX."option` O
                          WHERE POV.product_id = ".(int)$product_id."
                            AND POV.option_value_id = OV.option_value_id
                            AND PO.product_option_id = POV.product_option_id
                            AND OV.option_id = O.option_id
                        ";
      
      if ( !empty($lp_settings['default_price']) ) { // defaults from IO and RO has higher priority than lowest price of option
        
        // get improved options defaults 
        if ( $this->installedImprovedOptions() ) {
        
          if (!$this->model_module_improvedoption) {
            $this->load->model('module/improvedoptions');
          }
          
          $io_settings = $this->model_module_improvedoptions->getSettings();
          if ( !empty($io_settings['auto_selection']) ) {
          
            $query = $this->db->query(" SELECT PO.required, POV.product_option_id, POV.subtract, POV.quantity, POV.product_option_value_id, POV.default_select
                                        FROM ".DB_PREFIX."product_option_value POV
                                            ,".DB_PREFIX."option_value OV
                                            ,".DB_PREFIX."product_option PO
                                        WHERE POV.product_id = ".(int)$product_id."
                                          AND POV.option_value_id = OV.option_value_id
                                          AND PO.product_option_id = POV.product_option_id
                                        ORDER BY OV.sort_order ASC
                                        ");
                                                // AND PO.required = 1
                                                // AND POV.default_select = 1
            $options_with_defaults = array(); // to use default values only first time
            foreach ($query->rows as $row) {
                
              if ( $io_settings['auto_selection'] == 1 ) { // first available option value
                if ( !isset($io_defaults[$row['product_option_id']]) ) {
                  if ( !$row['subtract'] || $row['quantity'] ) {
                    $io_defaults[$row['product_option_id']] = $row['product_option_value_id'];
                  }
                }
              } elseif ( $io_settings['auto_selection'] == 2 ) { // first available option value is default is not set
                if ( !isset($io_defaults[$row['product_option_id']]) || ( $row['default_select'] && !in_array($row['product_option_id'], $options_with_defaults) ) ) {
                  $io_defaults[$row['product_option_id']] = $row['product_option_value_id'];
                  if ( $row['default_select'] ) {
                    $options_with_defaults[] = $row['product_option_id'];
                  }
                }
              } elseif ( $io_settings['auto_selection'] == 3 ) { // default value
                if ( !isset($io_defaults[$row['product_option_id']]) && $row['default_select'] ) {
                  $io_defaults[$row['product_option_id']] = $row['product_option_value_id'];
                }
              }
            }
          }
        }
      }
      
      // only minimal price calculation works for RO (not defaults)
      // calculation is based on the mind that related options are required
      // RO discounts and specials has not affect to the calculation
      if ( !empty($lp_settings['starting_from']) ) { 
        if ( $this->installedRelatedOptions() ) {
        
          if ( !$this->model_module_related_options ) {
            $this->load->model('module/related_options');
          }
          $ro_type = $this->getRelatedOptionsType();
          
          if ( $ro_type )  {

            $ro_settings = $this->config->get('related_options');
            $ro_options = $this->model_module_related_options->get_product_variant_options($product_id);
            
            $ro_ids = false;
            if ( $io_defaults ) {
              $ro_io_combs = $this->model_module_related_options->get_related_options_sets_by_poids($product_id, $io_defaults);
              
              if ( $ro_io_combs ) {
                $ro_ids = array();
                foreach ($ro_io_combs as $ro_io_comb) {
                  $ro_ids[] = $ro_io_comb['relatedoptions_id'];
                }
              }
            }
            
            $sql_ro_price = "";
            if ( !empty($ro_settings['spec_price']) ) {
              if ( !empty($ro_settings['spec_price_prefix']) ) {
                $sql_ro_price = "IF(RO.price <> 0,
                                  CASE RO.price_prefix
                                    WHEN '+' THEN '".(float)$product_price."' + RO.price
                                    WHEN '=' THEN RO.price
                                    WHEN '-' THEN '".(float)$product_price."' - RO.price
                                    ELSE RO.price
                                  END, '".(float)$product_price."')";
              } else {
                $sql_ro_price = "IF(RO.price <> 0, RO.price, '".(float)$product_price."')";
              }
            } else {
              $sql_ro_price = "'".(float)$product_price."'";
            }
						
						// get ro_combs taking possible discounts with quantity = 1 into account
						$sql_basic_ro = "
							SELECT 	RO.relatedoptions_id
										, IF(ROD.relatedoptions_id IS NULL, RO.price_prefix, ".
										// basically RO discounts uses only = prefix, but it could be changed by the specific setting of Live Price PRO
										( !empty($lp_settings['ropro_discounts_addition']) ? "RO.price_prefix" : "'='" )
										.") price_prefix
										, IF(ROD.relatedoptions_id IS NULL, RO.price, ROD.price) price
							FROM ".DB_PREFIX."relatedoptions RO
										LEFT JOIN ".DB_PREFIX."relatedoptions_discount ROD
											ON (ROD.relatedoptions_id = RO.relatedoptions_id AND ROD.quantity = 1 AND ROD.customer_group_id = ".(int)$this->config->get('config_customer_group_id').")
							WHERE RO.product_id = ".(int)$product_id."
								".
								// for ROPRO check only the first variant of related options
								($ro_type=="ropro" ? " AND RO.relatedoptions_variant_product_id = ".(int)$this->getProductFirstROPROVariant($product_id)." " : "")
								.
								($ro_ids ? " AND RO.relatedoptions_id IN (".implode(',', $ro_ids).")" : "" )
								."
						";
						
            // calculation of RO prices takes into account standard price modifiers of options values used in ROcombs
            $query = $this->db->query(" SELECT PRICES.* FROM
                                        ( SELECT RO.relatedoptions_id
                                                ,(".$sql_ro_price."
                                                  + IF(ROOPR.price IS NULL,0,ROOPR.price)
                                                ) as price
                                          FROM (".$sql_basic_ro.") RO
                                              LEFT JOIN ( SELECT SUM(OPR.price) as price, ROO.relatedoptions_id
                                                          FROM ( ".$sql_min_options." ) as OPR
                                                              ,".DB_PREFIX."relatedoptions_option ROO
                                                          WHERE ROO.product_id = ".(int)$product_id."
                                                            AND ROO.option_value_id = OPR.option_value_id
                                                          GROUP BY (ROO.relatedoptions_id)
                                                        ) as ROOPR ON ( RO.relatedoptions_id = ROOPR.relatedoptions_id )
                                        ) PRICES
                                      ORDER BY PRICES.price ASC
                                    ");
						/*
						// calculation or RO prices with taking into account standart prices modifiers of options values used in ROcombs
            $query = $this->db->query(" SELECT PRICES.* FROM
                                        ( SELECT RO.relatedoptions_id
                                                ,(".$sql_ro_price."
                                                  + IF(ROOPR.price IS NULL,0,ROOPR.price)
                                                ) as price
                                          FROM ".DB_PREFIX."relatedoptions RO
                                              LEFT JOIN ( SELECT SUM(OPR.price) as price, ROO.relatedoptions_id
                                                          FROM ( ".$sql_min_options." ) as OPR
                                                              ,".DB_PREFIX."relatedoptions_option ROO
                                                          WHERE ROO.product_id = ".(int)$product_id."
                                                            AND ROO.option_value_id = OPR.option_value_id
                                                          GROUP BY (ROO.relatedoptions_id)
                                                        ) as ROOPR ON ( RO.relatedoptions_id = ROOPR.relatedoptions_id )
                                          WHERE RO.product_id = ".(int)$product_id."
                                            ".
                                            // for ROPRO only first variant of options combinations
                                            ($ro_type=="ropro" ? " AND RO.relatedoptions_variant_product_id = ".(int)$this->getProductFirstROPROVariant($product_id)." " : "")
                                            .
                                            ($ro_ids ? " AND RO.relatedoptions_id IN (".implode(',', $ro_ids).")" : "" )
                                            ."
                                        ) PRICES
                                      ORDER BY PRICES.price ASC
                                    ");
            */                        
            if ( $query->num_rows ) {
              
              // only of at least one of RO changes product price
              foreach ( $query->rows as $row ) {
                if ( $row['price'] != $product_price ) {
                  $ro_minimal = $this->getROCombination( $query->rows[0]['relatedoptions_id'] ); // first row
                  break;
                }
              }
              
            }
          }
        }
      }
    
      $query = $this->db->query(" SELECT PRICES.*
                                  FROM ( ".$sql_min_options." ) PRICES
                                  ORDER BY price ASC, sort_order ASC
                                  ");
                                  //AND PO.required = 1 
    
      $values_for_calc = array();
      $minimal_options_used = false;
      
      $all_pov_prices_zero = true;
      foreach ($query->rows as $row) {
        if ( $row['pov_price'] != 0 ) {
          $all_pov_prices_zero = false;
          break;
        }
      }
    
      foreach ($query->rows as $row) {
        
        // may be shold be improved for checkboxes
        if ( !isset($values_for_calc[$row['product_option_id']]) ) {
        
          $count_before = count($values_for_calc);
        
          if ( $inclide_starting_from && isset($ro_minimal[$row['product_option_id']]) ) { // RO min has a priority. price may be in options combination
            $values_for_calc[$row['product_option_id']] = $ro_minimal[$row['product_option_id']];
            $minimal_options_used = true;
            
          } elseif ( isset($io_defaults[$row['product_option_id']]) ) {
            $values_for_calc[$row['product_option_id']] = $io_defaults[$row['product_option_id']];
          
          } elseif ( $inclide_starting_from ) { // exclude zero options prices 
            if ( !empty($lp_settings['starting_from']) && $lp_settings['starting_from'] == 1 && $row['required'] ) { // minimal options prices modifiers for required options
              $values_for_calc[$row['product_option_id']] = $row['product_option_value_id'];
              
            } elseif ( !empty($lp_settings['starting_from']) && $lp_settings['starting_from'] == 2 ) { // minimal options prices modifiers for all options
              $values_for_calc[$row['product_option_id']] = $row['product_option_value_id'];
            }
          }
          
          if ( $count_before != count($values_for_calc) ) { // new value added
            if ($row['type'] == 'checkbox') {
              $values_for_calc[$row['product_option_id']] = array( $values_for_calc[$row['product_option_id']] );
            }
            if ( $values_for_calc[$row['product_option_id']] == $row['product_option_value_id'] ) { // minimal option value (it may be equal to defaul value)
              if ( $row['required'] || ( !empty($lp_settings['starting_from']) && $lp_settings['starting_from'] == 2 ) ) { //
                if ( !$all_pov_prices_zero ) {
                  $minimal_options_used = true;
                }
              }
            }
          }
        }
      }
      
      $lp_data = $this->getProductPrice( $product_id, 1, $values_for_calc, 0, array(), array(), array(), false, true, true );
			
      $prices       = $lp_data['prices'];
      $product_data = $lp_data['product_data'];
      $option_data  = $lp_data['option_data'];
      
      $defaults = array(  'price'       =>  $prices['price_old_opt']
                        , 'special'     =>  $prices['special_opt']
                        , 'points'      =>  $prices['points']
                        , 'reward'      =>  $product_data['reward']
                        , 'weight'      =>  $product_data['weight']
                        
                        , 'f_price'     =>  $prices['f_price_old_opt']
                        , 'f_special'   =>  ($prices['special']?$prices['f_special_opt']:'')
                        , 'f_tax'       =>  ($prices['config_tax']?$prices['f_price_opt_notax']:$prices['config_tax'])
                        
                        , 'minimal'     => $minimal_options_used
                        
                        , 'minimum'     =>  $product_data['minimum']
                        , 'product_id'  =>  $product_id
                        
                        );
      
      return $defaults;
        
    }
  
    return false;
  }
  
  private function installedProductSizeOption() {
		if ( is_null($this->pso_installed_status) ) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = 'module' AND `code` = 'option_size'");
			$this->pso_installed_status = $query->num_rows && (method_exists( 'Cart', 'getAllProductOption') || method_exists( 'Cart\Cart', 'getAllProductOption') || method_exists( $this->cart, 'getAllProductOption') );
		}
    return $this->pso_installed_status;
  }
  
  private function ProductHasSizeOption($options, $options_types) {
    foreach ($options as $product_option_id => $option_value) {
      if (!isset($options_types[$product_option_id])) {
        continue;
      }
      /*
      if ( isset($options_types[$product_option_id]['calculate_once']) && $options_types[$product_option_id]['calculate_once'] == 1 ) {
        continue;
      }
      */
      if ($options_types[$product_option_id]['type'] == 'size') {
        return true;
      }
    }
    return false;
  }

  //$current_quantity < 0 (cart call)
	private function calculateOptionPrice($product_id, $price, $points, $p_product_option_data, $get_full_data=false, $quantity=0, $current_quantity=0, $option_data=array(), $option_points=0, $option_weight=0, $stock=true) {
  //private function calculateOptionPrice($option_price, $product_id, $price, $points, $options, $options_types, $options_values, $get_full_data=false, $recurring_id=0, $quantity=0, $current_quantity=0, $option_data=array(), $option_points=0, $option_weight=0, $stock=true) {
    
		$options = $p_product_option_data['options'];
		$options_types = $p_product_option_data['options_types'];
		$options_values = $p_product_option_data['options_values'];
		
    $price_rewrited = false;
    
    $installedPSO = $this->installedProductSizeOption();
    if ($installedPSO) {
      
      $min_width = 0;
      $max_width = 0;
      $min_height = 0;
      $max_height = 0;
      $cost_per_square = 0;
      $option_size_id = 0;
      $product_option_size_id = 0;
      $product_width = 0;
      $product_height = 0;
      $product_options =  $this->cart->getAllProductOption($product_id);
      if(!empty($product_options)) {
        foreach($product_options as $product_option) {
          if ($product_option['min_width'] != '' && $product_option['max_width'] != '' && $product_option['cost_per_square'] != '') {
            $min_width = $product_option['min_width'];
            $max_width = $product_option['max_width'];
            $min_height = $product_option['min_height'];
            $max_height = $product_option['max_height'];
            $cost_per_square = $product_option['cost_per_square'];
            $product_option_size_id = $product_option['product_option_id'];
            $option_size_id = $product_option['option_id']; 
            break;
          }
        }
      }
      if($cost_per_square > 0 && $product_option_size_id > 0) {
        $product_width = isset($options[$product_option_size_id]['width']) ? $options[$product_option_size_id]['width'] : 0;
        $product_height = isset($options[$product_option_size_id]['height']) ? $options[$product_option_size_id]['height'] : 0; 
      }
      
      $has_size_option = false;
      
    }
    
    
    $option_price = 0;
    
    foreach ($options as $product_option_id => $option_value) {
      
      if (!isset($options_types[$product_option_id])) {
        continue;
      }
      
      $calc_multiplier = 1;
      if ( isset($options_types[$product_option_id]['calculate_once']) && $options_types[$product_option_id]['calculate_once'] == 1 ) {
        //$calc_multiplier = 1 / ($current_quantity<0 ? $quantity : ($current_quantity==0 ? 1 : $current_quantity) );
        $calc_multiplier = 1 / max(abs($current_quantity), 1) ;
      }
      
      $options_array = array();
      if ( in_array($options_types[$product_option_id]['type'], $this->options_selects) ) {
        $options_array = array($option_value);
      } elseif ( $options_types[$product_option_id]['type'] == 'checkbox' && is_array($options_array) ) {
        $options_array = $option_value;
      }
      
      if ( (in_array($options_types[$product_option_id]['type'], $this->options_selects) || $options_types[$product_option_id]['type'] == 'checkbox')
          && isset($options_values[$product_option_id]) ) {
        
        $povs = $options_values[$product_option_id];
        
        foreach ($options_array as $product_option_value_id) {
          
          if ( isset($povs[$product_option_value_id]) ) {
            
            $pov = $povs[$product_option_value_id];
            
            // Product Size Option
            if ($installedPSO && $this->cart->checkScaleWithSize($product_id, $product_option_id, $option_size_id)) {
              $pov['price'] = $calc_multiplier * $pov['price'] * $product_width * $product_height;
            }
            
            if ($pov['price'] != 0) {
            
              if ($pov['price_prefix'] == '+') {
                
                $option_price += $calc_multiplier * $pov['price'];
                
              } elseif ($pov['price_prefix'] == '-') {
                $option_price -= $calc_multiplier * $pov['price'];
                
              } elseif ($pov['price_prefix'] == '%') {
                
                $current_price = $price+$option_price;
                $option_price = round($current_price*(100+$pov['price'])/100,2)-$price;
                //$current_price = $price; // % works on basic product price
                //$option_price = round($current_price*$pov['price']/100,2);  
                
              } elseif ($pov['price_prefix'] == '*') {
                $current_price = $price+$option_price;
                $option_price = round($current_price*$pov['price'],2)-$price;
                
              } elseif ($pov['price_prefix'] == '/' && $pov['price']!=0) {
                $current_price = $price+$option_price;
                $option_price = round($current_price/$pov['price'],2)-$price;
                
              } elseif ($pov['price_prefix'] == '=') {
                $current_price = $price+$option_price;
                $option_price = $pov['price']-$price;
                //$option_price = $pov['price']-$current_price;
                $price_rewrited = true;
              }
            }
            
            if ($get_full_data) {
            
              if ( $pov['points'] ) {
                if ($pov['points_prefix'] == '=') {
                  $current_points = $points+$option_points;
                  $option_points = $pov['points']-$current_points;
                } elseif ($pov['points_prefix'] == '+') {
                  $option_points += $calc_multiplier * $pov['points'];
                } elseif ($pov['points_prefix'] == '-') {
                  $option_points -= $calc_multiplier * $pov['points'];
                }
              }
                            
              if ($pov['weight_prefix'] == '+') {
                $option_weight += $calc_multiplier * $pov['weight'];
              } elseif ($pov['weight_prefix'] == '-') {
                $option_weight -= $calc_multiplier * $pov['weight'];
              }
              
              if ($pov['subtract'] && (!$pov['quantity'] || ($pov['quantity'] < $quantity))) {
                $stock = false;
              }
              
              $option_data[] = array(
                'product_option_id'       => $product_option_id,
                'product_option_value_id' => $product_option_value_id,
                'option_id'               => $options_types[$product_option_id]['option_id'],
                'option_value_id'         => $pov['option_value_id'],
                'name'                    => $options_types[$product_option_id]['name'],
                'option_value'            => $pov['name'],
                'value'                   => $pov['name'],
                'type'                    => $options_types[$product_option_id]['type'],
                'quantity'                => $pov['quantity'],
                'subtract'                => $pov['subtract'],
                //'price'                   => $pov['price'],
                'price'                   => ($pov['price_prefix']=='+' || $pov['price_prefix']=='-') ? $calc_multiplier*$pov['price'] : $pov['price'],
                'price_prefix'            => $pov['price_prefix'],
                'points'                  => $pov['points'],
                'points_prefix'           => $pov['points_prefix'],
                'weight'                  => $pov['weight'],
                'weight_prefix'           => $pov['weight_prefix']
              );
            }
          }
        }
      } elseif ( in_array($options_types[$product_option_id]['type'], array('text','textarea','file','date','datetime','time') ) ) {
        
        if ($get_full_data) {
        
          // for Customer Order Product Upload - myoc_copu.xml - , makes files array
          if ( (is_array($option_value) || is_object($option_value)) && $options_types[$product_option_id]['type'] == 'file') {
            $current_option_values_array = $option_value;
          } else {
            $current_option_values_array = array($option_value);
          }
        
          foreach ($current_option_values_array as $current_option_value) {
            $option_data[] = array(
              'product_option_id'       => $product_option_id,
              'product_option_value_id' => '',
              'option_id'               => $options_types[$product_option_id]['option_id'],
              'option_value_id'         => '',
              'name'                    => $options_types[$product_option_id]['name'],
              'value'                   => $current_option_value,
              'type'                    => $options_types[$product_option_id]['type'],
              'quantity'                => '',
              'subtract'                => '',
              'price'                   => '',
              'price_prefix'            => '',
              'points'                  => '',
              'points_prefix'           => '',								
              'weight'                  => '',
              'weight_prefix'           => ''
            );
          }
          
        }
       
      // Product Size Option
      } elseif ($options_types[$product_option_id]['type'] == 'size' && $installedPSO) {
        
        $has_size_option = true;
        $width = $option_value['width'];
        $height = $option_value['height'];
        
        $extra_price = $width * $height * $options_types[$product_option_id]['cost_per_square'];
        
        if($extra_price < $options_types[$product_option_id]['min_price'])
          $extra_price = $options_types[$product_option_id]['min_price'];
        
        $option_price += $extra_price;
        
        if ($this->config->has('pso_dimension_order'))
          $pso_dimension_order = $this->config->get('pso_dimension_order');
        else
          $pso_dimension_order = 0; //default: height then width
        
        $option_data[] = array(
          'product_option_id'       => $product_option_id,
          'product_option_value_id' => '',
          'option_id'               => $options_types[$product_option_id]['option_id'],
          'option_value_id'         => '',
          'name'                    => $options_types[$product_option_id]['name'],
          'value'           		  => $pso_dimension_order == 1 ? ($width . 'x' . $height) : ($height . 'x' . $width),
          'type'                    => $options_types[$product_option_id]['type'],
          'quantity'                => '',
          'subtract'                => '',
          'price'                   => $extra_price,
          'price_prefix'            => '',
          'points'                  => '',
          'points_prefix'           => '',								
          'weight'                  => '',
          'weight_prefix'           => ''
        );
        
      }
      
    }
    
    return array( 'price_rewrited'  =>$price_rewrited
                , 'option_price'    =>$option_price
                , 'option_data'     =>$option_data
                , 'option_points'   =>$option_points
                , 'option_weight'   =>$option_weight
                , 'stock'           =>$stock
                );
  }

  
  // compatibility
  // Custom Price Product - Customer can enter custom price for products flagged as such
  private function getCustomPrice($product, $options) {
  
    $price = $product['price'];
    if (strtolower($product['sku']) == 'custom' || strtolower($product['location']) == 'custom' || strtolower($product['upc']) == 'custom') {
      if ($options) {
        $pids = array_keys($options);
        
        if ($pids) {
          foreach ($pids as &$pid) {
            $pid = (int)$pid;
          }
          unset($pid);
          
          $query = $this->db->query(" SELECT PO.product_option_id, OD.name
                                      FROM  " . DB_PREFIX . "product_option PO
                                          , " . DB_PREFIX . "option_description OD
                                      WHERE PO.product_option_id IN (" . implode(',',$pids) . ")
                                        AND PO.option_id = OD.option_id
                                        AND OD.language_id = '" . (int)$this->config->get('config_language_id') . "'
                                      ");
          $po_names = array();
          foreach ($query->rows as $row) {
            $po_names[$row['product_option_id']] = $row['name'];
          }
        
          foreach ($options as $product_option_id => $option_value) {
            if ( isset($po_names[$product_option_id]) && strpos($po_names[$product_option_id], '**') !== false ) {
              $price = (float)$option_value;
              break;
            }
          }
        }
      }
    }
    return $price;
  }
  
  private function getProductCategoriesDirect($product_id) {
    $query = $this->db->query(" SELECT category_id FROM " . DB_PREFIX . "product_to_category
                                WHERE product_id = '" . (int)$product_id . "'
                              ");
    $categories = array();
    foreach ( $query->rows as $row ) {
      $categories[] = $row['category_id'];
    }
    return $categories;
  }
  
  private function getProductManufacturer($product_id) {
    $query = $this->db->query(" SELECT manufacturer_id FROM " . DB_PREFIX . "product
                                WHERE product_id = '" . (int)$product_id . "'
                              ");
    if ( $query->num_rows ) {
      return $query->row['manufacturer_id'];
    }
    return 0;
  }
  
  public function getProductDiscount( $product_id, $price, $customer_group_id, $discount_quantity, $ro_combs=false) {
		
    $lp_settings = $this->config->get('liveprice_settings');
        
    $product_discount_query_data = $this->getProductDiscountQuery((int)$product_id, (int)$customer_group_id, (int)$discount_quantity, $ro_combs);
				
    $product_discount_query = $product_discount_query_data['query'];
    $discount_k = 1;
    if ($product_discount_query->num_rows) {
			
			$used_price_prefix = '';
      if ( !empty($product_discount_query->row['price_prefix']) && $product_discount_query->row['price_prefix'] != '=' ) {
        $discount_k = 1;
        if ( $product_discount_query->row['price_prefix'] == '%' ) { // -%
          $discount_k = (100-$product_discount_query->row['price'])/100;
        } elseif ( $product_discount_query->row['price_prefix'] == '_' ) { // =%
          $discount_k = ($product_discount_query->row['price'])/100;
        }
        $product_discount_query->row['price'] = round($price*$discount_k, 2);
				$used_price_prefix = $product_discount_query->row['price_prefix'];
        
      } else { // =
				
				$used_price_prefix = '=';
				
        // Product Currency compatibility
        if ( isset($product_discount_query->row['currency_discount']) ) {
          $product_discount_query->row['price'] = $this->currency->convert($product_discount_query->row['price'], $product_discount_query->row['currency_discount'], $this->config->get('config_currency'));
        }
      }
			
			return array('price'=>$product_discount_query->row['price'], 'used_price_prefix'=>$used_price_prefix );
			
    }
  }
  
  public function hasProductOwnDiscounts($product_id) {
    return $this->db->query("SELECT product_discount_id FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "' LIMIT 1 ")->num_rows;
  }
  
  public function getProductDiscountQuery($product_id, $customer_group_id, $discount_quantity, $ro_combs=false) {
    
		$query_data = array();
		
		$lp_settings = $this->config->get('liveprice_settings');
		
    if ( $this->getRelatedOptionsType() ) { // installed, model loaded (for both)
      
      $ro_settings = $this->config->get('related_options');
      
      if ( !empty($ro_settings['spec_price']) && !empty($ro_settings['spec_price_discount']) ) {
				if ($ro_combs) {
					foreach ($ro_combs as $ro_comb) {
						
						if ( !empty($ro_comb['discounts']) ) {
							if ( !empty($lp_settings['ropro_discounts_addition']) && !empty($ro_settings['spec_price_prefix']) && !empty($ro_comb['price_prefix']) && ($ro_comb['price_prefix']=='+' || $ro_comb['price_prefix']=='-') ) {
								continue; // these discount additions are implemented another way (on anoher step)
							}
							
							$ro_discount_query = $this->db->query("	SELECT RD.price
																											FROM " . DB_PREFIX . "relatedoptions_discount RD
																											WHERE RD.relatedoptions_id = '" . (int)$ro_comb['relatedoptions_id'] . "'
																												AND RD.customer_group_id = '" . (int)$customer_group_id . "'
																												AND RD.quantity <= '" . (int)$discount_quantity . "'
																											ORDER BY RD.quantity DESC, RD.priority ASC, RD.price ASC LIMIT 1");
							if ($ro_discount_query->num_rows)	{
								$query_data['query'] = $ro_discount_query;
							}
							
						}
					}
				}	
			}
    } 
		
		if ( empty($query_data['query']) ) { // not set by RO
    
			if ( $this->hasProductOwnDiscounts($product_id) || !$this->versionPRO() ) {
			
				$pdq = $this->db->query(" SELECT * FROM " . DB_PREFIX . "product_discount
																	WHERE product_id = '" . (int)$product_id . "'
																		AND (customer_group_id = '" . (int)$customer_group_id . "' OR customer_group_id = -1 )
																		AND ((date_start = '0000-00-00' OR date_start < NOW())
																		AND (date_end = '0000-00-00' OR date_end > NOW()))
																		".
																			($discount_quantity===false ?
																					" AND quantity > 1
																						ORDER BY quantity ASC, priority ASC, price ASC
																					"
																				:
																					" AND quantity <= '" . (int)$discount_quantity . "'
																						AND quantity > 0
																						ORDER BY quantity DESC, priority ASC, price ASC LIMIT 1
																					"
																			)
																		."
																	");
    
			} else { // global discounts should work only if product doesn't have any discount
					
				$categories = $this->getProductCategoriesDirect($product_id);
				$categories[] = -1;
				
				$manufacturer_id = $this->getProductManufacturer($product_id);
				
				$pdq = $this->db->query(" SELECT * FROM " . DB_PREFIX . "liveprice_global_discount
																	WHERE (customer_group_id = '" . (int)$customer_group_id . "' OR customer_group_id = -1 )
																		AND (category_id IN (" . implode(',',$categories) . ") )
																		AND (manufacturer_id = '" . (int)$manufacturer_id . "' OR manufacturer_id = -1 )
																		AND ((date_start = '0000-00-00' OR date_start < NOW())
																		AND (date_end = '0000-00-00' OR date_end > NOW()))
																		".
																			($discount_quantity===false ?
																					" AND quantity > 1
																						ORDER BY quantity ASC, priority ASC, price ASC
																					"
																				:
																					" AND quantity <= '" . (int)$discount_quantity . "'
																						AND quantity > 0
																						ORDER BY quantity DESC, priority ASC, price ASC LIMIT 1
																					"
																			)
																		."
																	");
			}
			$query_data['query'] = $pdq;
		}
    return $query_data;
  }
  
  public function getProductSpecial( $product_id, $price, $customer_group_id, $ro_combs=false) {
		
    $product_special_query_data = $this->getProductSpecialQuery((int)$product_id, (int)$customer_group_id, $ro_combs);
		
		$lp_settings = $this->config->get('liveprice_settings');
		
		$product_special_query = $product_special_query_data['query'];
    $discount_k = 1;
    if ($product_special_query->num_rows) {
			
      if ( !empty($product_special_query->row['price_prefix']) && $product_special_query->row['price_prefix'] != '=' ) {
        $discount_k = 1;
        if ( $product_special_query->row['price_prefix'] == '%' ) { // -%
          $discount_k = (100-$product_special_query->row['price'])/100;
        } elseif ( $product_special_query->row['price_prefix'] == '_' ) { // =%
          $discount_k = ($product_special_query->row['price'])/100;
        }
        $product_special_query->row['price'] = round($price*$discount_k, 2);
				$used_price_prefix = $product_special_query->row['price_prefix'];
        
      } else { // =
				
				$used_price_prefix = '=';
				
        // Product Currency compatibility
        if ( isset($product_special_query->row['currency_special']) ) {
          $product_special_query->row['price'] = $this->currency->convert($product_special_query->row['price'], $product_special_query->row['currency_special'], $this->config->get('config_currency'));
        }
      }
			
			$current_price = $product_special_query->row['price'];
			//return array('price'=>$current_price, 'used_price_prefix'=>$used_price_prefix );
      
      //return $product_special_query->row['price'];
    }
		
		if ( isset($current_price) ) {
			return array('price'=>$current_price, 'used_price_prefix'=>$used_price_prefix );
		}
  }
  
  public function hasProductOwnSpecials($product_id) {
    return $this->db->query("SELECT product_special_id FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' LIMIT 1 ")->num_rows;
  }
  
  public function getProductSpecialQuery($product_id, $customer_group_id, $ro_combs=false) {
    
		$query_data = array();
		
		$lp_settings = $this->config->get('liveprice_settings');
		
    if ( $this->getRelatedOptionsType() ) { // installed, model loaded (for both)
      
      $ro_settings = $this->config->get('related_options');
      
      if ( !empty($ro_settings['spec_price']) && !empty($ro_settings['spec_price_special']) ) {
				if ($ro_combs) {
					foreach ($ro_combs as $ro_comb) {
						
						if ( !empty($ro_comb['specials']) ) {
							if ( !empty($lp_settings['ropro_specials_addition']) && !empty($ro_settings['spec_price_prefix']) && !empty($ro_comb['price_prefix']) && ($ro_comb['price_prefix']=='+' || $ro_comb['price_prefix']=='-') ) {
								continue; // these special additions are implemented another way (on anoher step)
							}
							
							$ro_special_query = $this->db->query(" SELECT price FROM " . DB_PREFIX . "relatedoptions_special
																												WHERE relatedoptions_id = '" . (int)$ro_comb['relatedoptions_id'] . "'
																													AND customer_group_id = '" . (int)$customer_group_id . "'
																												ORDER BY priority ASC, price ASC LIMIT 1");
							if ($ro_special_query->num_rows)	{
								$query_data['query'] = $ro_special_query;
							}
						}
					}
				}	
			}
    } 
    
		if ( empty($query_data['query']) ) { // not set by RO
		
			if ( $this->hasProductOwnSpecials($product_id) || !$this->versionPRO() ) {
			
				$pdq = $this->db->query(" SELECT * FROM " . DB_PREFIX . "product_special
																	WHERE product_id = '" . (int)$product_id . "'
																		AND (customer_group_id = '" . (int)$customer_group_id . "' OR customer_group_id = -1 )
																		AND ((date_start = '0000-00-00' OR date_start < NOW())
																		AND (date_end = '0000-00-00' OR date_end > NOW()))
																	ORDER BY priority ASC, price ASC
																	LIMIT 1
																	");
			
			} else { // global specials should work only if product doesn't have any own special
					
				$categories = $this->getProductCategoriesDirect($product_id);
				$categories[] = -1;
				
				$manufacturer_id = $this->getProductManufacturer($product_id);
				
				$pdq = $this->db->query(" SELECT * FROM " . DB_PREFIX . "liveprice_global_special
																	WHERE (customer_group_id = '" . (int)$customer_group_id . "' OR customer_group_id = -1 )
																		AND (category_id IN (" . implode(',',$categories) . ") )
																		AND (manufacturer_id = '" . (int)$manufacturer_id . "' OR manufacturer_id = -1 )
																		AND ((date_start = '0000-00-00' OR date_start < NOW())
																		AND (date_end = '0000-00-00' OR date_end > NOW()))
																	ORDER BY priority ASC, price ASC
																	LIMIT 1
																	");
			}
		
			$query_data['query'] = $pdq;
		}
		/*
		if ( !empty($lp_settings['ropro_specials_addition']) && !empty($ro_special_query) && $ro_special_query->num_rows && !empty($ro_comb_price_prefix) ) {
			$query_data['ro_specials_addition'] = $ro_special_query;
			$query_data['ro_comb_price_prefix'] = $ro_comb_price_prefix;
		}
		*/
		
    return $query_data;
  }
  
  private function arrayKeysToInt($arr) {
    $new_arr = array();
    foreach ( $arr as $key => $val ) {
      $new_arr[(int)$key] = $val;
    }
    return $new_arr;
  }
	
	private function arrayDeleteEmpty($arr) {
    $new_arr = array();
    foreach ($arr as $key => $val) {
      if ($val) {
        $new_arr[$key] = $val;
      }
    }
    return $new_arr;
  }
	
	private function normalizeArrayOfOptions($p_arr) {
		$new_arr = array();
    foreach ( $p_arr as $key => $val ) {
			if ( is_object($val) ) {
				$new_val = get_object_vars($val);
			} else {
				$new_val = $val;
			}
			if ( $new_val ) {
				$new_arr[(int)$key] = $new_val;
			}
    }
    return $new_arr;
	}
	
	private function getProductSettingDiscountQuantity($product_id) {
    
    $lp_settings = $this->config->get('liveprice_settings');
		
		$discount_quantity = isset($lp_settings['discount_quantity']) ? $lp_settings['discount_quantity'] : 0;
		
		if ( !empty($lp_settings['discount_quantity_customize']) && !empty($lp_settings['dqc']) ) {
			foreach ($lp_settings['dqc'] as $dqc) {
				if ( !empty($dqc['products']) ) {
					if ( in_array($product_id, $dqc['products']) ) {
						$discount_quantity = $dqc['discount_quantity'];
					}
				}
				if ( !empty($dqc['manufacturers']) ) {
					$query = $this->db->query("SELECT manufacturer_id FROM " . DB_PREFIX . "product WHERE product_id = ".(int)$product_id." ");
					if ( $query->num_rows ) {
						if ( in_array($query->row['manufacturer_id'], $dqc['manufacturers']) ) {
							$discount_quantity = $dqc['discount_quantity'];
						}
					}
				}
				if ( !empty($dqc['categories']) && is_array($dqc['categories']) ) {
					array_walk($dqc['categories'], 'intval');
					$query = $this->db->query(" SELECT category_id
																			FROM " . DB_PREFIX . "product_to_category
																			WHERE product_id = ".(int)$product_id."
																				AND category_id IN (".implode(',', $dqc['categories']).")
																			");
					if ( $query->num_rows ) {
						$discount_quantity = $dqc['discount_quantity'];
					}
				}
			}
		}
    
		if ($discount_quantity == 2 && !$this->installedRelatedOptions()) {
			$discount_quantity = 1;
		}
		
    return $discount_quantity;
    
  }

	private function getOptionDataKey($p_option_dt) {
		
		$key = '';
		
		$key_parts = array('option_id', 'option_value_id', 'product_option_id', 'product_option_value_id');
		foreach ( $key_parts as $key_part ) {
			$key.= '_';
			if ( isset($p_option_dt[$key_part]) ) {
				$key.= $p_option_dt[$key_part];
			}
		}
		return $key;
	}
	
	private function putOptionDataFields($p_option_data, $p_data) {
		
		if ( $p_data ) {
			foreach ($p_option_data as &$option_dt) {
				$option_key = $this->getOptionDataKey($option_dt);
				
				foreach ($p_data as $field => $field_values) {
					if ( isset($field_values[$option_key]) ) {
						$option_dt[$field] = $field_values[$option_key];
					}
				}
			}
			unset($option_dt);
		}
		return $p_option_data;
	}
	
	private function getOptionDataFields($p_option_data, $p_fields) {
		$data = array();
		foreach ( $p_option_data as $option_dt ) {
			foreach ( $p_fields as $field ) {
				if ( isset($option_dt[$field]) ) {
					if ( !isset($data[$field]) ) {
						$data[$field] = array();
					}
					$option_key = $this->getOptionDataKey($option_dt);
					$data[$field][$option_key] = $option_dt[$field];
				}
			}
		}
		return $data;
	}
	
	// prepare (read) sets of product options for usage
	private function prepareDataOfProductOptions($p_product_id, $p_options) {
		
		$options_types = array();
		$options_values = array();
		
		$product_option_ids = array();
		$product_option_value_ids = array();
		foreach ($p_options as $product_option_id => $option_value) {
			if (!in_array($product_option_id, $product_option_ids)) $product_option_ids[] = (int)$product_option_id;
		}
		
		if ( count($product_option_ids) != 0 ) {
			
			$options_query = $this->db->query(" SELECT po.*, od.name, o.* 
																					FROM " . DB_PREFIX . "product_option po
																						LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id)
																						LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id)
																					WHERE po.product_option_id IN (" . implode(",", $product_option_ids) . ")
																						AND po.product_id = '" . (int)$p_product_id . "'
																						AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'");
			foreach ($options_query->rows as $row) {
				$options_types[$row['product_option_id']] = $row;
			}
		
			foreach ($p_options as $product_option_id => $option_value) {
				
				if (!isset($options_types[$product_option_id])) continue;
				
				if ( in_array($options_types[$product_option_id]['type'], $this->options_selects) ) {
					if (!in_array((int)$option_value, $product_option_value_ids)) {
						$product_option_value_ids[] = (int)$option_value;
					}
				} elseif ($options_types[$product_option_id]['type'] == 'checkbox' && is_array($option_value)) {
					foreach ($option_value as $product_option_value_id) {
						if (!in_array((int)$product_option_value_id, $product_option_value_ids)) {
							$product_option_value_ids[] = (int)$product_option_value_id;
						}
					}
				}
			}
			
			if ( count($product_option_ids) != 0 && count($product_option_value_ids) != 0 ) { // в $product_option_ids могут быть опции не подходящих типов
				 $option_value_query = $this->db->query("SELECT  pov.*, ovd.name
																								FROM " . DB_PREFIX . "product_option_value pov
																									LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id)
																									LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id)
																								WHERE pov.product_option_value_id IN (" . implode(",", $product_option_value_ids) . ")
																									AND pov.product_option_id IN (" . implode(",", $product_option_ids) . ")
																									AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
				foreach ($option_value_query->rows as $row) {
					
					// Product Currency compatibility
					if ( isset($row['currency_option']) ) {
						$row['price'] = $this->currency->convert($row['price'], $row['currency_option'], $this->config->get('config_currency'));
					}
					
					if (!isset($options_values[$row['product_option_id']])) {
						$options_values[$row['product_option_id']] = array();
					}
					$options_values[$row['product_option_id']][$row['product_option_value_id']] = $row;
				}
			}
			
		}
		
		return array(	'options'=>$p_options,
									'options_types'=>$options_types,
									'options_values'=>$options_values,
									'product_option_ids'=>$product_option_ids,
									'product_option_value_ids'=>$product_option_value_ids,
								 );
		
	}
	
	private function applyDiscountSpecialToPrices( $product_id, $quantity, $current_quantity, $price, $points, $ro_price_modificator, $customer_group_id, $product_option_data, $to_total, $calc_discount, $ds_price_data ) {
		
		if ( !$to_total || $ds_price_data['used_price_prefix'] == '=' ) { // basic calc
							
			$price = $ds_price_data['price'];
			if ( $ds_price_data['used_price_prefix'] == '=' && !empty($ro_price_modificator) ) {
				
				$price+= $ro_price_modificator;
			}
			
			// calc options
			$option_price_data = $this->calculateOptionPrice( $product_id, $price, $points, $product_option_data, true, $quantity, $current_quantity, array(), 0, 0, true );
			
		} else { // % discount/special to total
			
			// calc options
			$option_price_data = $this->calculateOptionPrice( $product_id, $price, $points, $product_option_data, true, $quantity, $current_quantity, array(), 0, 0, true );
			
			// apply discount/special to options
			if ( $calc_discount ) { // discount
				$ds_option_price_data = $this->getProductDiscount( $product_id, $option_price_data['option_price'], $customer_group_id, $quantity, isset($ro_combs)?$ro_combs:false);	
			} else { // special
				$ds_option_price_data = $this->getProductSpecial( $product_id, $option_price_data['option_price'], $customer_group_id, isset($ro_combs)?$ro_combs:false);
			}
			
			$option_price_data['option_price'] = $ds_option_price_data['price'];
			/*
			// apply discount/special to ro_price_modifier
			if ( !empty($ro_price_modificator) && !empty($calc_data['price_rewrited']) ) {
				if ( $calc_discount ) { // discount
					$ds_ro_mod_price_data = $this->getProductDiscount( $product_id, $ro_price_modificator, $customer_group_id, $quantity, isset($ro_combs)?$ro_combs:false);
				} else { // special
					$ds_ro_mod_price_data = $this->getProductSpecial( $product_id, $ro_price_modificator, $customer_group_id, isset($ro_combs)?$ro_combs:false);
				}
				$ro_price_modificator = $ds_ro_mod_price_data['price'];
			}
			*/
			$price = $ds_price_data['price'];
		}
		
		return array( 'option_price_data' => $option_price_data, 'price' => $price );
	}
	
  
	public function getProductPriceByParamsArray($params) {
		
		$product_id 				= isset($params['product_id']) ? $params['product_id'] : 0 ;
		$quantity 					= isset($params['quantity']) ? $params['quantity'] : 1 ;
		$options 						= isset($params['options']) ? $params['options'] : array() ;
		$recurring_id 			= isset($params['recurring_id']) ? $params['recurring_id'] : 0 ;
		$prices 						= isset($params['prices']) ? $params['prices'] : array() ;
		$product_data 			= isset($params['product_data']) ? $params['product_data'] : array() ;
		$option_data 				= isset($params['option_data']) ? $params['option_data'] : array() ;
		$multiplied_price 	= isset($params['multiplied_price']) ? $params['multiplied_price'] : false ;
		$use_cart_cache 		= isset($params['use_cart_cache']) ? $params['use_cart_cache'] : false ;
		$use_price_cache 		= isset($params['use_price_cache']) ? $params['use_price_cache'] : false ;
		$without_discounts 	= isset($params['without_discounts']) ? $params['without_discounts'] : false ;
		$ignore_cart 				= isset($params['ignore_cart']) ? $params['ignore_cart'] : false ;
		$qpo_discount_quantity_addition   = isset($params['qpo_discount_quantity_addition']) ? $params['qpo_discount_quantity_addition'] : 0 ;
		
		return $this->getProductPrice($product_id, $quantity, $options, $recurring_id, $prices, $product_data, $option_data, $multiplied_price, $use_cart_cache, $use_price_cache, $without_discounts, $ignore_cart, $qpo_discount_quantity_addition);
		
	}
	
	// PARAMS:
  // $product_id,
  // $current_quantity ( use 0 for cart )
  // $options = array( $product_option_id => $product_option_value_id )
  // $recurring_id
  // RESULTS:
  // &$prices=array(), &$product_data=array(), &$option_data=array()
  // if $current_quantity < 0 - cart call with current cart quantity
  public function getProductPrice($p_product_id, $current_quantity=1, $options=array(), $recurring_id=0, $prices=array(), $product_data=array(), $option_data=array(), $multiplied_price=false, $use_cart_cache=false, $use_price_cache=false, $without_discounts=false, $ignore_cart=false, $qpo_discount_quantity_addition=0) {
    
		$product_id = (int)$p_product_id;
		$current_quantity = (int)$current_quantity;
		
    // <0 - cart call
    if ($current_quantity==0) {
      $current_quantity = 1;
    }
    
    $ro_type = '';
    if ( $this->installedRelatedOptions() ) {
      if ( !$this->model_module_related_options ) {
        $this->load->model('module/related_options');
      }
      $ro_type = $this->getRelatedOptionsType();
    }
		
		
    
    $cache_price_key = md5( $product_id.'_'.$current_quantity.'_'.serialize($options).'_'.$recurring_id );
    if ( $use_price_cache && isset($this->cache_price[$cache_price_key]) ) {
      $prices       = $this->cache_price[$cache_price_key]['prices'];
      $product_data = $this->cache_price[$cache_price_key]['product_data'];
      $option_data  = $this->cache_price[$cache_price_key]['option_data'];
    } else {
    
      $lp_settings = $this->config->get('liveprice_settings');
      
      $settings_discount_quantity = $this->getProductSettingDiscountQuantity($product_id);
      
      if ( $settings_discount_quantity == 2 ) {
        
        if ( !$this->model_module_related_options ) {
          $this->load->model('module/related_options');
        }
        $ro_installed = $this->model_module_related_options->installed();
        if ($ro_installed) {
          $ro_type = $this->getRelatedOptionsType();
          if ( $ro_type == 'ro' ) { // related options
            $ro_price_data = $this->model_module_related_options->get_related_options_set_by_poids($product_id, $options, true);
          } elseif ( $ro_type == 'ropro' ) { // Related Options PRO
            $ro_price_data = $this->model_module_related_options->get_related_options_sets_by_poids($product_id, $options, true);
            //$ro_price_data = $this->model_module_related_options->get_related_options_sets_by_poids($product_id, $options);
          }
        }
      }
      
      // $options = $this->arrayKeysToInt( $this->arrayDeleteEmpty($options) );
			$options = $this->normalizeArrayOfOptions( $options );
			
			// to save extra fields of options (values)
			$option_data_fields = $this->getOptionDataFields($option_data, array('opt_image', 'model')); // save extra fields
      
      $product_data = array();
      $option_data = array();
      $prices = array(  // without taxes
                        'product_price' => 0            // product price
                      , 'price_old' => 0                // product price with discount, but without special
                      , 'price_old_opt' => 0            // product price with discount, but without special, and with options
                      , 'special' => 0                  // product special price
                      , 'special_opt' => 0              // product special price with options
                      , 'price' => 0                    // product price with discount and special (special ignore discount)
                      , 'price_opt' => 0                // product price with discount and special (special ignore discount) with options
                      , 'option_price' => 0             // option price modificator
                      , 'option_price_special' => 0     // option price modificator for specials
                      //, 'discounts' => array()
                      
                        // with taxes and formatted
                      , 'f_product_price' => 0            // product price
                      , 'f_price_old' => 0                // product price with discount, but without special
                      , 'f_price_old_opt' => 0            // product price with discount, but without special, and with options
                      , 'f_special' => 0                  // product special price
                      , 'f_special_opt' => 0              // product special price
                      , 'f_price' => 0                    // product price with discount and special (special ignore discount)
                      , 'f_price_opt' => 0                // product price with discount and special (special ignore discount)
                      , 'f_option_price' => 0             // option price modificator
                      //, 'f_discounts' => array()
                      
                      
                      // without taxes and formatted
                      , 'f_product_price_notax' => 0            // product price
                      , 'f_price_old_notax' => 0                // product price with discount, but without special
                      , 'f_price_old_opt_notax' => 0            // product price with discount, but without special
                      , 'f_special_notax' => 0                  // product special price
                      , 'f_special_opt_notax' => 0              // product special price
                      , 'f_price_notax' => 0                    // product price with discount and special (special ignore discount)
                      , 'f_price_opt_notax' => 0                // product price with discount and special (special ignore discount)
                      , 'f_option_price_notax' => 0             // option price modificator
                      //, 'f_discounts_notax' => array()
                      
                      , 'config_tax' => $this->config->get('config_tax')
                      , 'points' => 0
											, 'tax_class_id' => 0
                      
                      );
      
      
      $quantity = MAX($current_quantity,0); // for cart call, total quantity (for disconts), doesn't include current cart row quantity (to not include it twice)
      
      if ( $current_quantity<0 || ( empty($lp_settings['ignore_cart']) && empty($ignore_cart) ) ) {
        
        if ( !$this->cache_cart || !$use_cart_cache ) {
          
          if ( VERSION >= '2.1.0.0' ) {
            
            $cart_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "cart WHERE customer_id = '" . (int)$this->customer->getId() . "' AND session_id = '" . $this->db->escape($this->session->getId()) . "'");
            foreach ($cart_query->rows as $cart_product) {
              $cart_product['cart_quantity'] = $cart_product['quantity'];
              $cart_product['option'] = (array)json_decode($cart_product['option'], true);
              $this->cache_cart[] = $cart_product;
            }
            
          } else { // 2.0.X 
            foreach ($this->session->data['cart'] as $key => $cart_quantity) {
              $cart_product = unserialize(base64_decode($key));
              $cart_product['cart_quantity'] = $cart_quantity;
              $this->cache_cart[] = $cart_product;
            }
          }
        }
        
        //foreach ($this->session->data['cart'] as $key => $cart_quantity) {
        //    $cart_product = unserialize(base64_decode($key));
        foreach ($this->cache_cart as &$cart_product) {
          
          $cart_product_id = $cart_product['product_id'];
          $cart_quantity = $cart_product['cart_quantity'];
          
          if ($cart_product_id == $product_id) {
    
            // Options
            if (!empty($cart_product['option'])) {
              $cart_options = $cart_product['option'];
            } else {
              $cart_options = array();
            }
            $cart_options = $this->arrayKeysToInt($cart_options);
            
            // Profile
            if (!empty($product['recurring_id'])) {
              $recurring_id = $product['recurring_id'];
            } else {
              $recurring_id = 0;
            }
            
            if ( $settings_discount_quantity==1 ) { // by options
              
              if ($options == $cart_options) {
              //if ( json_encode($options)==json_encode($cart_options) ) {
              //if ($options == $cart_options) {
                $quantity = $quantity + $cart_quantity;
              }
              
            } elseif ( $settings_discount_quantity==2 ) { // by related options combination
              
              if ( isset($ro_price_data) && $ro_price_data ) {
                
                if ( $ro_type == 'ro' ) { // related options
                  if ($use_cart_cache && isset($cart_product['ro_price_data_cart'])) {
                    $ro_price_data_cart = $cart_product['ro_price_data_cart'];
                  } else {
                    $ro_price_data_cart = $this->model_module_related_options->get_related_options_set_by_poids($product_id, $cart_options, true);
                    $cart_product['ro_price_data_cart'] = $ro_price_data_cart;
                  }
                  //$ro_price_data_cart = $this->model_module_related_options->get_related_options_set_by_poids($product_id, $cart_options, true);
                  
                  if ( $ro_price_data_cart && $ro_price_data_cart['relatedoptions_id'] == $ro_price_data['relatedoptions_id'] ) {
                    $quantity = $quantity + $cart_quantity;
                  }
                  
                } elseif ( $ro_type == 'ropro' ) { // Related Options PRO
                  
                  if ($use_cart_cache && isset($cart_product['ro_price_data_cart'])) {
                    $ro_price_data_cart = $cart_product['ro_price_data_cart'];
                  } else {
                    $ro_price_data_cart = $this->model_module_related_options->get_related_options_sets_by_poids($product_id, $cart_options, true);
                    //$ro_price_data_cart = $this->model_module_related_options->get_related_options_sets_by_poids($product_id, $cart_options);
                    $cart_product['ro_price_data_cart'] = $ro_price_data_cart;
                  }
                  
                  //$ro_price_data_cart = $this->model_module_related_options->get_related_options_sets_by_poids($product_id, $cart_options);
                  
                  if ( $ro_price_data_cart ==  $ro_price_data) {
                    $quantity = $quantity + $cart_quantity;
                  }
                  
                }
                
              } elseif ($options == $cart_options) {
                $quantity = $quantity + $cart_quantity;
              }
              
            } else { // by product
              $quantity = $quantity + $cart_quantity;
            }
          } 
        }
        unset($cart_product);
      }
      
			// taking other current cobinations of options into account maybe needed (only if discounts are product based)
			if ( $qpo_discount_quantity_addition && !$settings_discount_quantity ) { 
				$quantity+= $qpo_discount_quantity_addition; 
			}
			
      // $quantity  - full quantity for discount ($current_quantity + cart quantity (sometimes, depends on settings) )
      // $current_quantity  - quantity for current product calc
      
      $quantity = max($quantity, 1);
      $real_quantity = max(1, abs($current_quantity));
      
      $stock = true;
  
      $product_query = $this->db->query(" SELECT *
                                          FROM " . DB_PREFIX . "product p
                                            LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)
                                          WHERE p.product_id = '" . (int)$product_id . "'
                                            AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'
                                            AND p.date_available <= NOW()
                                            AND p.status = '1'");
      
      if ($product_query->num_rows) {
        
        // << for RO
				
				$ro_price_modificator = 0;
				
        if ( $this->getRelatedOptionsType() == 'ropro' ) { // installed, model loaded
          $ro_settings = $this->config->get('related_options');
          $ro_combs = $this->model_module_related_options->get_related_options_sets_by_poids($product_id, $options, true);
          if ($ro_combs) {
            foreach ($ro_combs as $ro_comb) {
              if (isset($ro_settings['spec_weight']) && $ro_settings['spec_weight'] && $ro_comb['weight'] != 0) {
                if ($ro_comb['weight_prefix'] == '=') {
                  $product_query->row['weight'] = $ro_comb['weight'];
                } elseif ($ro_comb['weight_prefix'] == '+') {
                  $product_query->row['weight'] += $ro_comb['weight'];
                } elseif ($ro_comb['weight_prefix'] == '-') {
                  $product_query->row['weight'] -= $ro_comb['weight'];
                }
              }
            }
          }
        } elseif ( $this->getRelatedOptionsType() == 'ro' ) {
          $ro_settings = $this->config->get('related_options');
          $ro_price_data = $this->model_module_related_options->get_related_options_set_by_poids($product_id, $options, true);
          if ( $ro_price_data && isset($ro_price_data['relatedoptions_id']) ) {
            if (isset($ro_settings['spec_weight']) && $ro_settings['spec_weight'] && $ro_price_data['weight'] != 0) {
              if ($ro_price_data['weight_prefix'] == '=') {
                $product_query->row['weight'] = $ro_price_data['weight'];
              } elseif ($ro_price_data['weight_prefix'] == '+') {
                $product_query->row['weight'] += $ro_price_data['weight'];
              } elseif ($ro_price_data['weight_prefix'] == '-') {
                $product_query->row['weight'] -= $ro_price_data['weight'];
              }
            }
          }
          if ( isset($ro_settings['spec_price']) && $ro_settings['spec_price'] && $ro_price_data && (float)$ro_price_data['price'] ) {
            $ro_price_modificator = 0;
            if ($ro_price_data['price_prefix'] == '+' && isset($ro_settings['spec_price_prefix']) && $ro_settings['spec_price_prefix']) {
              $product_query->row['price'] += $ro_price_data['price'];
              $ro_price_modificator += $ro_price_data['price']; 
            } elseif ($ro_price_data['price_prefix'] == '-' && isset($ro_settings['spec_price_prefix']) && $ro_settings['spec_price_prefix']) {
              $product_query->row['price'] -= $ro_price_data['price'];
              $ro_price_modificator -= $ro_price_data['price']; 
            } else {
              $product_query->row['price'] = (float)$ro_price_data['price'];
            }
          }
          $ro_combs = $ro_price_data ? array($ro_price_data) : array();
        }
        // >> for RO
        
        // Product Currency compatibility
        if ( isset($product_query->row['currency_product']) ) {
          $product_query->row['price'] = $this->currency->convert($product_query->row['price'], $product_query->row['currency_product'], $this->config->get('config_currency'));
        }
        
        $product_query->row['price'] = $this->getCustomPrice($product_query->row, $options);
        
        $option_price = 0;
        $option_points = 0;
        $option_weight = 0;
        
				$product_option_data = $this->prepareDataOfProductOptions($product_id, $options);
				$options_types = $product_option_data['options_types'];
        //$options_values = $product_option_data['options_values'];
	      $product_option_ids = $product_option_data['product_option_ids'];
        //$product_option_value_ids = $product_option_data['product_option_value_ids'];
				
        if ( $product_option_ids ) {
          // Product Size Option
          if ($this->installedProductSizeOption()) {
            if ( $this->ProductHasSizeOption($options, $options_types) && $this->config->has('pso_exclude_product_price_in_total') && $this->config->get('pso_exclude_product_price_in_total') ) {
              $product_query->row['price'] = 0;
            }
          }
        }
        
        // << for RO 
        if ( $this->getRelatedOptionsType() == 'ropro' ) { // ROPRO or newer RO
          if ($ro_combs) {
            $ro_price_data = $this->model_module_related_options->calc_price_with_ro($product_query->row['price'], $ro_combs,0,0,0,$quantity);
            $product_query->row['price'] = $ro_price_data['price'];
            $ro_price_modificator = $ro_price_data['price_modificator'];
						
						if ( !empty($lp_settings['ropro_discounts_addition']) && isset($ro_price_data['discount_addition']) ) {
							$ro_discount_addition = $ro_price_data['discount_addition'];
						}
						if ( !empty($lp_settings['ropro_specials_addition']) && isset($ro_price_data['special_addition']) ) {
							$ro_special_addition = $ro_price_data['special_addition']; // to +/- product special by RO special if the setting is enabled
						}
					}
        }
        // >> for RO
				
				$customer_group_id = (int)$this->config->get('config_customer_group_id');

        $price = $product_query->row['price'];
				$price_wo_options = $price; // fix the price to exclude the influence of ro_price_modificator
        $prices['product_price'] = $price;
        
				if ( empty($ro_special_addition) ) {
					// standard way
					$special_price_data = $this->getProductSpecial($product_id, $price, $customer_group_id, isset($ro_combs)?$ro_combs:false);
				} else {
					// exclude $ro_price_modificator for calculation of special if there is RO addition to specials (enabled by the specific setting of Live Price )
					$special_price_data = $this->getProductSpecial($product_id, $price-$ro_price_modificator, $customer_group_id, isset($ro_combs)?$ro_combs:false);
				}
				$percent_special_to_total = !empty($lp_settings['percent_special_to_total']);
				$discount_like_special = false;
				
				if ( empty($special_price_data) && empty($ro_special_addition) ) { // calc discount only if no special is set
					if ( empty($ro_discount_addition) ) {
						// standard way
						$discount_price_data = $this->getProductDiscount($product_id, $price, $customer_group_id, $quantity, isset($ro_combs)?$ro_combs:false);
					} else {
						// exclude $ro_price_modificator for calculation of discount if there is RO addition to discounts (enabled by the specific setting of Live Price )
						$discount_price_data = $this->getProductDiscount($product_id, $price-$ro_price_modificator, $customer_group_id, $quantity, isset($ro_combs)?$ro_combs:false);
					}
					
					if ( !empty($discount_price_data) ) {
						
						if ( !empty($lp_settings['discount_like_special']) ) {
							$percent_special_to_total = !empty($lp_settings['percent_discount_to_total']);
							$special_price_data = $discount_price_data;
							$discount_price_data = false;
							$discount_like_special = true;
						}
						
						if ( !empty($discount_price_data) ) {
							if ( empty($ro_discount_addition) ) {
								// standard way
								$discount_data = $this->applyDiscountSpecialToPrices( $product_id, $quantity, $current_quantity, $price, $product_query->row['points'], $ro_price_modificator, $customer_group_id, $product_option_data, !empty($lp_settings['percent_discount_to_total']), true, $discount_price_data );
							} else {
								// because there is the specific addition for the discount:
								// - use basic price without affecting by RO additions for the calculation of the product discount
								// - do not use $ro_price_modificator
								$discount_data = $this->applyDiscountSpecialToPrices( $product_id, $quantity, $current_quantity, $price-$ro_price_modificator, $product_query->row['points'], 0, $customer_group_id, $product_option_data, !empty($lp_settings['percent_discount_to_total']), true, $discount_price_data );
								$discount_data['price']+= $ro_discount_addition; // basic discount is calculated, let's add the addition
							}
							$price 							= $discount_data['price'];
							$option_price_data 	= $discount_data['option_price_data'];
						}
					} else {
						// no basic discount
					
						if ( !empty($ro_discount_addition) ) { // no matter exists basic discount or not, this addition should be applyed (and $ro_price_modificator excluded)
							$price+= -$ro_price_modificator +$ro_discount_addition;
						}
					}
				}
				
				// save prices without special
				if ( empty($option_price_data) ) {
					$option_price_data = $this->calculateOptionPrice( $product_id, $price, $product_query->row['points'], $product_option_data, true, $quantity, $current_quantity, $option_data, $option_points, $option_weight, $stock );
				}
				$price_for_options = $price; // on this step it should not affect the price (on this step it is needed only to fix prices w/o special)
				if ( !empty($option_price_data['price_rewrited']) && !empty($ro_price_modificator) ) {
					$price_for_options+= $ro_price_modificator;
				}
				
				$prices['price_old'] 			= $price_wo_options;
				$prices['price_old_opt']  = $price_for_options + $option_price_data['option_price'];
				
				// apply special
				if ( !empty($special_price_data) ) {
					
					if ( empty($ro_special_addition) ) {
						// standard way
						$special_data = $this->applyDiscountSpecialToPrices( $product_id, $quantity, $current_quantity, $price, $product_query->row['points'], $ro_price_modificator, $customer_group_id, $product_option_data, $percent_special_to_total, $discount_like_special, $special_price_data );
					} else {
						// because there is the specific addition for the special:
						// - use basic price without affecting by RO additions for the calculation of the product special
						// - do not use $ro_price_modificator 
						
						$special_data = $this->applyDiscountSpecialToPrices( $product_id, $quantity, $current_quantity, $price-$ro_price_modificator, $product_query->row['points'], 0, $customer_group_id, $product_option_data, $percent_special_to_total, $discount_like_special, $special_price_data );
						$special_data['price']+= $ro_special_addition; // basic special calculated, let's add the addition
					}
					
					$price 							= $special_data['price'];
					$option_price_data 	= $special_data['option_price_data'];
					
				} else { // no basic special
					
					if ( !empty($ro_special_addition) ) { // not matter exists basic special or not, this addition should be applyed (and $ro_price_modificator excluded)
						$price+= -$ro_price_modificator +$ro_special_addition;
					}
				}
				
				$price_wo_options = $price;
				if ( !empty($option_price_data['price_rewrited']) && !empty($ro_price_modificator) ) {
					$price+= $ro_price_modificator;
				}
				
				$option_price   = $option_price_data['option_price'];
        $option_data    = $option_price_data['option_data'];
        $option_points  = $option_price_data['option_points'];
        $option_weight  = $option_price_data['option_weight'];
        $stock          = $option_price_data['stock'];
				
				if ( !empty($special_price_data) || !empty($ro_special_addition) ) {
					$prices['option_price_special'] = $option_price;
          $prices['special'] 							= $price_wo_options;
					$prices['special_opt']          = $price + $option_price;
				}
				
				$prices['price']        = $price;
				$prices['option_price'] = $option_price;
				$prices['price_opt']    = $price + $option_price;
				
        // Reward Points
        $product_reward_query = $this->db->query("SELECT points FROM " . DB_PREFIX . "product_reward
                                                  WHERE product_id = '" . (int)$product_id . "'
                                                    AND customer_group_id = '" . (int)$customer_group_id . "'");
        
        if ($product_reward_query->num_rows) {	
          $reward = $product_reward_query->row['points'];
        } else {
          $reward = 0;
        }
				
				if ( $this->installedImprovedOptions() ) {
					if (!$this->model_module_improvedoption) {
            $this->load->model('module/improvedoptions');
          }
          $io_settings = $this->model_module_improvedoptions->getSettings();
					if ( !empty($io_settings['reward_for_options']) ) {
						$reward = $this->model_module_improvedoptions->getReward((int)$product_id, $options);
					}
				}
        
        // Downloads		
        $download_data = array();     		
        
        $download_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download p2d
                                              LEFT JOIN " . DB_PREFIX . "download d ON (p2d.download_id = d.download_id)
                                              LEFT JOIN " . DB_PREFIX . "download_description dd ON (d.download_id = dd.download_id)
                                            WHERE p2d.product_id = '" . (int)$product_id . "'
                                              AND dd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
      
        foreach ($download_query->rows as $download) {
          $download_data[] = array(
            'download_id' => $download['download_id'],
            'name'        => $download['name'],
            'filename'    => $download['filename'],
            'mask'        => $download['mask'] //,
            //'remaining'   => $download['remaining']
          );
        }
        
        // Stock
        if (!$product_query->row['quantity'] || ($product_query->row['quantity'] < $quantity)) {
          $stock = false;
        }
        
        $recurring_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "recurring` `p` JOIN `" . DB_PREFIX . "product_recurring` `pp` ON `pp`.`recurring_id` = `p`.`recurring_id` AND `pp`.`product_id` = " . (int)$product_query->row['product_id'] . " JOIN `" . DB_PREFIX . "recurring_description` `pd` ON `pd`.`recurring_id` = `p`.`recurring_id` AND `pd`.`language_id` = " . (int)$this->config->get('config_language_id') . " WHERE `pp`.`recurring_id` = " . (int)$recurring_id . " AND `status` = 1 AND `pp`.`customer_group_id` = " . (int)$this->config->get('config_customer_group_id'));
  
        if ($recurring_query->num_rows) {
          $recurring = array(
            'recurring_id'    => $recurring_id,
            'name'            => $recurring_query->row['name'],
            'frequency'       => $recurring_query->row['frequency'],
            'price'           => $recurring_query->row['price'],
            'cycle'           => $recurring_query->row['cycle'],
            'duration'        => $recurring_query->row['duration'],
            'trial'           => $recurring_query->row['trial_status'],
            'trial_frequency' => $recurring_query->row['trial_frequency'],
            'trial_price'     => $recurring_query->row['trial_price'],
            'trial_cycle'     => $recurring_query->row['trial_cycle'],
            'trial_duration'  => $recurring_query->row['trial_duration']
          );
        } else {
          $recurring = false;
        }
        
        // некоторая избыточность в подготовке данных
        $product_data = array(
          //'key'             => $key,
          'product_id'      => $product_query->row['product_id'],
          'name'            => $product_query->row['name'],
          'model'           => $product_query->row['model'],
          'shipping'        => $product_query->row['shipping'],
          'image'           => $product_query->row['image'],
          'option'          => $option_data,
          'download'        => $download_data,
          'quantity'        => $quantity,
          'minimum'         => $product_query->row['minimum'],
          'subtract'        => $product_query->row['subtract'],
          'stock'           => $stock,
          'price'           => ($price + $option_price),
          'total'           => ($price + $option_price) * $real_quantity,
          //'total'           => ($price + $option_price) * $quantity,
          'reward'          => $reward * $quantity,
          'points'          => ($product_query->row['points'] || $option_points!=0 ? ($product_query->row['points'] + $option_points) * $quantity : 0),
          //'points'          => ($product_query->row['points'] ? ($product_query->row['points'] + $option_points) * $quantity : 0),
          'tax_class_id'    => $product_query->row['tax_class_id'],
          'weight'          => ($product_query->row['weight'] + $option_weight) * $quantity,
          'weight_class_id' => $product_query->row['weight_class_id'],
          'length'          => $product_query->row['length'],
          'width'           => $product_query->row['width'],
          'height'          => $product_query->row['height'],
          'length_class_id' => $product_query->row['length_class_id'],
          'recurring'       => $recurring
        );
        
        
        $price_multiplier = 1;
        if ($multiplied_price && isset($lp_settings['multiplied_price']) && $lp_settings['multiplied_price']) {
          $price_multiplier = MAX(1, $current_quantity);
          // multiplier should be applied only to formatted prices and to points
        }
        
        $prices['points']                   = ( ($product_query->row['points'] || $option_points!=0) ? ($product_query->row['points'] + $option_points) * $price_multiplier : 0) ;
				
				$prices['tax_class_id'] 						= $product_query->row['tax_class_id'];
        
        $prices['f_product_price_notax']    = $this->format($prices['product_price']);
        $prices['f_price_old_notax']        = $this->format($prices['price_old']);
        $prices['f_price_old_opt_notax']    = $this->format($prices['price_old_opt']);
        $prices['f_special_notax']          = $this->format($prices['special']);
        $prices['f_special_opt_notax']      = $this->format($prices['special_opt']);
        $prices['f_option_price_notax']     = $this->format($prices['option_price']);
        
        $prices['f_price_notax']            = $this->format($price_multiplier*$prices['price']);
        $prices['f_price_opt_notax']        = $this->format($price_multiplier*$prices['price_opt']);
        $prices['f_product_price']          = $this->format($price_multiplier*$this->tax->calculate($prices['product_price'], $product_query->row['tax_class_id'], $this->config->get('config_tax')));
        $prices['f_price_old']              = $this->format($price_multiplier*$this->tax->calculate($prices['price_old'], $product_query->row['tax_class_id'], $this->config->get('config_tax')));
        $prices['f_price_old_opt']          = $this->format($price_multiplier*$this->tax->calculate($prices['price_old_opt'], $product_query->row['tax_class_id'], $this->config->get('config_tax')));
        $prices['f_special']                = $this->format($price_multiplier*$this->tax->calculate($prices['special'], $product_query->row['tax_class_id'], $this->config->get('config_tax')));
        $prices['f_special_opt']            = $this->format($price_multiplier*$this->tax->calculate($prices['special_opt'], $product_query->row['tax_class_id'], $this->config->get('config_tax')));
        $prices['f_price']                  = $this->format($price_multiplier*$this->tax->calculate($prices['price'], $product_query->row['tax_class_id'], $this->config->get('config_tax')));
        $prices['f_price_opt']              = $this->format($price_multiplier*$this->tax->calculate($prices['price_opt'], $product_query->row['tax_class_id'], $this->config->get('config_tax')));
        $prices['f_option_price']           = $this->format($price_multiplier*$this->tax->calculate($prices['option_price'], $product_query->row['tax_class_id'], $this->config->get('config_tax')));
        
				$option_data = $this->putOptionDataFields($option_data, $option_data_fields); // place additional fields back
        
        $this->cache_price[$cache_price_key] = array('prices'=>$prices, 'product_data'=>$product_data, 'option_data'=>$option_data);
      }
      
			if ( !$without_discounts ) {
			
				// required for html generation, placed here for better related options compatibility
				// << for RO
				if ( $this->getRelatedOptionsType() ) { // (for both)
					if ( isset($ro_settings['spec_price']) && $ro_settings['spec_price'] && isset($ro_settings['spec_price_discount']) && $ro_settings['spec_price_discount'] ) {
						if ($ro_combs) {
							
							// for the case when there are standard discounts and RO discounts with setting 'ropro_discounts_addition', this way maybe incorrect
							
							foreach ($ro_combs as $ro_comb) {
								$ro_discount_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "relatedoptions_discount
																													WHERE relatedoptions_id = '" . (int)$ro_comb['relatedoptions_id'] . "'
																														AND customer_group_id = '" . (int)$customer_group_id . "'
																													ORDER BY quantity ASC, priority ASC, price ASC");
								if ($ro_discount_query->num_rows)	{
									$ro_discounts = $ro_discount_query->rows;
									foreach ($ro_discounts as &$ro_discount) {
										$ro_discount['ro_comb_price_prefix'] = $ro_comb['price_prefix'];
									}
									unset($ro_discount);
									break;
								}
							}
						}	
					}
				}
				// >> for RO
				if ( !empty($ro_discounts) ) {
					$discounts = $ro_discounts;
				} else {
					if ( !$this->model_catalog_product ) {
						$this->load->model('catalog/product');
					}
					$discounts = $this->model_catalog_product->getProductDiscounts($product_id);
				}
				
				$prices['discounts'] = array(); 
				foreach ($discounts as $discount) {
					if ( $discount['quantity'] > 1 ) {
						
						if ( !empty($lp_settings['percent_discount_to_total']) && !empty($discount['price_prefix']) && $discount['price_prefix'] != '=' ) {
							$prices['discounts'][] = array(
								'quantity' => $discount['quantity'],
								'price'    => ''.$discount['price_prefix'].' '.(float)$discount['price']
							);
						} else {
							
							if ( $this->getRelatedOptionsType() == 'ropro' && !empty($ro_discounts) ) {
							
								$discount_data = $this->getProductPriceByParamsArray(array(	'product_id'=>$product_id,
																																						'quantity'=>$discount['quantity'],
																																						'options'=>$options,
																																						'without_discounts'=>true,
																																						'ignore_cart'=>true,
																																					) );
								$discount_price = $discount_data['prices']['price_old_opt'];
							
							} else {
							
								$discount_price = $discount['price'];
								
								if ( $this->getRelatedOptionsType() == 'ropro' ) {
									if ($ro_combs) {
										$ro_discount_data = $this->model_module_related_options->calc_price_with_ro($discount_price, $ro_combs,0,0,0,$discount['quantity']);
										//$discount_price = $ro_discount_data['price'];
										$discount_price+= $ro_discount_modificator;
										$ro_discount_modificator = $ro_discount_data['price_modificator'];
									}
								}
								
								$calc_data = $this->calculateOptionPrice( (int)$product_id, $discount_price, 0, $product_option_data, false, 0, $discount['quantity'], $discount['quantity'] );
								
								if ($calc_data['price_rewrited'] && isset($ro_discount_modificator) && $ro_discount_modificator!=0 ) {
									$discount_price+= $ro_discount_modificator;
								}
								
								$discount_price = $discount_price+$calc_data['option_price'];
							}
							
							$prices['discounts'][] = array(
								'quantity' => $discount['quantity'],
								'price'    => $this->format($this->tax->calculate($discount_price, $product_data['tax_class_id'], $this->config->get('config_tax')))
							);
						}
					}
				}
			}
    }

    return array('prices'=>$prices, 'product_data'=>$product_data, 'option_data'=>$option_data, 'price'=>$prices['price_opt']);
    
  }
  
  public function getProductPriceWithHtml($product_id, $current_quantity=0, $options=array(), $prices=array(), $product_data=array(), $option_data=array(), $multiplied_price=false, $non_standard_theme='' ) {
    
    $lp_data = $this->getProductPrice( $product_id, $current_quantity, $options, 0, $prices, $product_data, $option_data, $multiplied_price );
    $prices       = $lp_data['prices'];
    $product_data = $lp_data['product_data'];
    $option_data  = $lp_data['option_data'];
    
    $simple_prices = array( 'price'       =>  $prices['f_price_old_opt'],
                            'special'     =>  ( ($prices['special'] || $prices['special_opt']) ? $prices['f_special_opt'] : '' ),
                            
                            'tax'         =>  ( $prices['config_tax'] ? $prices['f_price_opt_notax'] : $prices['config_tax'] ),
                            'discounts'   =>  $prices['discounts'],
                            'points'      =>  $prices['points'],
														'reward'      =>  isset($product_data['reward']) ? $product_data['reward'] : '',
                            'minimum'     =>  isset($product_data['minimum']) ? $product_data['minimum'] : '',
                            
                            'price_val'   =>  $this->tax->calculate($prices['price_old_opt'], $prices['tax_class_id'], $prices['config_tax']),
														'special_val' =>  $this->tax->calculate($prices['special_opt'], $prices['tax_class_id'], $prices['config_tax']),
                            
                            'product_id'  =>  $product_id,
                            );
    
    $prices['htmls'] = $this->getPriceHtmls($simple_prices, $non_standard_theme);
    $prices['ct'] = $this->getThemeName();
    
    return array('prices'=>$prices, 'product_data'=>$product_data, 'option_data'=>$option_data);
  }
	
	public function getProductTotalPriceForQuantityPerOptionWithHtml($p_product_id, $p_options, $p_quantity_per_options, $p_non_standard_theme) {
		
		$total_quantity = 0;
		$total_price_old_opt = 0;
		$total_special_opt = 0;
		$total_price_opt = 0;
		$total_points = 0;
		
		if ( !$this->model_extension_module_quantity_per_option ) { 
			$this->load->model('extension/module/quantity_per_option');
		}
		if ( $this->model_extension_module_quantity_per_option->installed() ) {
			
			$quantity_per_options = $this->model_extension_module_quantity_per_option->normalizeArrayOfQPO($p_quantity_per_options);
			$qpo_all_combinations = $this->model_extension_module_quantity_per_option->getCombinationsOfOptions($quantity_per_options, $p_options);
			
			$qpo_total_quantity = 0;
			foreach ($qpo_all_combinations as $qpo_of_options) {
				$qpo_total_quantity+= $qpo_of_options['quantity'];
			}
			
			$stored_discounts = array();
			foreach ( $qpo_all_combinations as $qpo_of_options ) { // get prices for all combinations of options
				
				if ( $qpo_of_options['quantity'] ) {
					
					$qpo_total_quantity_except_current = $qpo_total_quantity - $qpo_of_options['quantity'];
				
					$quantity = $qpo_of_options['quantity'];
					$lp_data = $this->getProductPriceByParamsArray( array('product_id' =>$p_product_id,
																																'quantity' => $quantity,
																																'options' => $qpo_of_options['options'],
																																'multiplied_price' => true,
																																'qpo_discount_quantity_addition' => $qpo_total_quantity_except_current,
																																) );
					
					$total_quantity+= $quantity;
					$current_product_data = $lp_data['product_data'];
					$current_tax_class_id = $lp_data['prices']['tax_class_id'];
					$current_config_tax = $lp_data['prices']['config_tax'];
					
					$current_price_old_opt = (float)$lp_data['prices']['price_old_opt'];
					$current_special_opt = $lp_data['prices']['special'] ? (float)$lp_data['prices']['special_opt'] : 0;
					$current_price_opt = (float)$lp_data['prices']['price_opt'];
					$current_points = $lp_data['prices']['points'];
		
					$total_price_old_opt+= $quantity*$current_price_old_opt;
					$total_special_opt+= $quantity*$current_special_opt;
					$total_price_opt+= $quantity*$current_price_opt;
					$total_points+= $current_points; // points are already multiplied
					
					if ( count($stored_discounts) == 0 ) {
						$stored_discounts[] = $lp_data['prices']['discounts'];
					} else {
						if ( $stored_discounts[ count($stored_discounts)-1 ] != $lp_data['prices']['discounts'] ) {
							$stored_discounts[] = $lp_data['prices']['discounts'];
						}
					}
				}
			}
		}
		
		if ( $total_quantity ) {
			
			$prices = array();
			$simple_prices = array( 'price'       =>  $this->format( $this->tax->calculate($total_price_old_opt, $current_tax_class_id, $current_config_tax) ), //$prices['f_price_old_opt']
															'special'     =>  $total_special_opt ? $this->format( $this->tax->calculate($total_special_opt, $current_tax_class_id, $current_config_tax) ) : '', // ($prices['special']?$prices['f_special_opt']:'')
															
															'tax'         =>  $current_config_tax ? $this->format( $this->tax->calculate($total_price_opt, $current_tax_class_id, $current_config_tax) ) : $current_config_tax, // ($prices['config_tax']?$prices['f_price_opt_notax']:$prices['config_tax'])
															'discounts'   =>  (!empty($stored_discounts) && count($stored_discounts) == 1 ? $stored_discounts[0] : array()),
															'points'      =>  $total_points, // $prices['points']
															'reward'      =>  $current_product_data['reward'],
															'minimum'     =>  $current_product_data['minimum'],
															
															'price_val'   =>  $this->tax->calculate($total_price_old_opt, $current_tax_class_id, $current_config_tax),
															'special_val' =>  $this->tax->calculate($total_special_opt, $current_tax_class_id, $current_tax_class_id),
															
															'product_id'  =>  $p_product_id,
														);
			
			$prices['htmls'] = $this->getPriceHtmls($simple_prices, $p_non_standard_theme);
			$prices['ct'] = $this->getThemeName();
			
			return array('prices'=>$prices);
			
		} else { // no quantity per options, use standard calculation
			return $this->model_module_liveprice->getProductPriceWithHtml( $p_product_id, 1, $p_options, array(), array(), array(), true, $p_non_standard_theme );
		}
		
	}
  
  function getPriceHtmls($prices, $non_standard_theme='') {
		
		$lp_settings = $this->config->get('liveprice_settings');
    
    $this->language->load('product/product');
    $text_price         = $this->language->get('text_price');
    $text_tax           = $this->language->get('text_tax');
    $text_discount      = $this->language->get('text_discount');
    $text_points        = $this->language->get('text_points');
    $text_reward        = $this->language->get('text_reward');
    $text_stock         = $this->language->get('text_stock');
    $text_minimum       = sprintf($this->language->get('text_minimum'), $prices['minimum']);
    $text_manufacturer  = $this->language->get('text_manufacturer');
    
    $price = $prices['price'];
    $special = $prices['special'];
		if ( !empty($lp_settings['hide_tax']) ) {
			$tax = '';
		} else {
			$tax = $prices['tax'];
		}
    $points = $prices['points'];
    $discounts = $prices['discounts'];
    
    $html = '';
    $html_d = '';
		$html_d1 = '';
    $html1 = '';
    $html2 = '';
		$html3 = '';
		$html4 = '';

      if (!$discounts) {
        $html .= "<h2>".$price."</h2>";
      }
      if ($discounts) {
          $discountPercent = $this->convertStringToInt($discounts[0]['price']);
          $price = $this->convertStringToInt($price);
          $bigPrice = (int) ((100 * $price) / (100 - $discountPercent));
          $html .= "<span class=\"product-page__price\"><span style=\"text-decoration: line-through;\">"
              . $this->currency->format(($bigPrice), $this->session->data['currency']) .
              "</span><span class=\"text--yellow text-sm text-uppercase product-page__reduction\"><span class=\"percent\">Скидка "
              . number_format((($bigPrice - $price) / $bigPrice) * 100) . "%</span><span class=\"rouble\">Скидка "
              . $this->currency->format(($bigPrice - $price), $this->session->data['currency']) . "</span></span></span>";
          $html .= "<h2 class=\"product-page__special\">". $this->currency->format(($price), $this->session->data['currency']) . "</h2>";
      }
      if ($tax) {
        $html .= "<li>".$text_tax." ".$tax."</li>";
      }
      if ($points) {
        $html .= "<li>".$text_points." ".$points."</li>";
      }
    
    return array('html'=>$html, 'html_d'=>$html_d, 'html_d1'=>$html_d1, 'html1'=>$html1, 'html2'=>$html2, 'html3'=>$html3, 'html4'=>$html4);
  }

  private function convertStringToInt($string)
  {
      return (int) preg_replace('/[^0-9]/', '', $string);
  }
}
