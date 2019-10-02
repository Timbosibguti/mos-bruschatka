<?php
class ControllerStartupSeoUrl extends Controller {
	public function index() {
		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);

      // OCFilter start
      if (!is_null($this->registry->get('ocfilter'))) {
  			$this->url->addRewrite($this->registry->get('ocfilter'));
  		}
      // OCFilter end
      
		}

		// Decode URL
		if (isset($this->request->get['_route_'])) {
			$parts = explode('/', $this->request->get['_route_']);

			// remove any empty arrays from trailing
			if (utf8_strlen(end($parts)) == 0) {
				array_pop($parts);
			}

			foreach ($parts as $part) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");

				if ($query->num_rows) {
					$url = explode('=', $query->row['query']);

					if ($url[0] == 'product_id') {
						$this->request->get['product_id'] = $url[1];
					}

					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}
					}


//lightshop start
					if ($url[0] == 'lightshopcatblog_id') { 
						if (!isset($this->request->get['lbpath'])) {

							$this->request->get['lbpath'] = $url[1];
						} else {
							$this->request->get['lbpath'] = $url[1];
//							$this->request->get['lbpath'] .= '_' . $url[1];
						}
					}

					if ($url[0] == 'news_id') {
						$this->request->get['news_id'] = $url[1];
					}

					if ($url[0] == 'blog_id') {
						$this->request->get['blog_id'] = $url[1];
					}
//lightshop end

			
					if ($url[0] == 'manufacturer_id') {
						$this->request->get['manufacturer_id'] = $url[1];
					}

					if ($url[0] == 'information_id') {
						$this->request->get['information_id'] = $url[1];
					}

					
					if ($query->row['query'] && $url[0] != 'information_id' && $url[0] != 'manufacturer_id' && $url[0] != 'category_id' && $url[0] != 'product_id' && $url[0] != 'blog_id' && $url[0] != 'news_id' && $url[0] != 'lightshopcatblog_id') { //lightshop comment add this
			
						$this->request->get['route'] = $query->row['query'];
					}
				} else {
					$this->request->get['route'] = 'error/not_found';

					break;
				}
			}

			if (!isset($this->request->get['route'])) {
				if (isset($this->request->get['product_id'])) {
					$this->request->get['route'] = 'product/product';
				} elseif (isset($this->request->get['path'])) {
					$this->request->get['route'] = 'product/category';
				} elseif (isset($this->request->get['manufacturer_id'])) {
					$this->request->get['route'] = 'product/manufacturer/info';
				} elseif (isset($this->request->get['information_id'])) {
					$this->request->get['route'] = 'information/information';

				} elseif (isset($this->request->get['news_id'])) {//lightshop
					$this->request->get['route'] = 'extension/module/lightshop_news/getnews';//lightshop
				} elseif (isset($this->request->get['blog_id'])) {//lightshop
					$this->request->get['lbpath'] = '2';

					$this->request->get['route'] = 'extension/module/lightshop_blog/getblog';//lightshop
				} elseif (isset($this->request->get['lbpath'])) {//lightshop

					$this->request->get['route'] = 'extension/module/lightshopcat_blog/getcat';//lightshop

			
				}
			}
		}
	}

	public function rewrite($link) {
		$url_info = parse_url(str_replace('&amp;', '&', $link));

		$url = '';

		$data = array();

		parse_str($url_info['query'], $data);

		foreach ($data as $key => $value) {
			if (isset($data['route'])) {
				
				if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id') || ($data['route'] == 'extension/module/lightshop_blog/getblog' && $key == 'blog_id') || ($data['route'] == 'extension/module/lightshop_news/getnews' && $key == 'news_id')) {//lightshop comment add this

			
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");

					if ($query->num_rows && $query->row['keyword']) {
						$url .= '/' . $query->row['keyword'];

						unset($data[$key]);
					}

//lightshop start
				} elseif ($key == 'lbpath') {
					$categories = explode('_', $value);
					if ($categories[0]) {
						array_unshift($categories, "0");
					}

					foreach ($categories as $category) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'lightshopcatblog_id=" . (int)$category . "'");

						if ($query->num_rows && $query->row['keyword']) {
							$url .= '/' . $query->row['keyword'];
						} else {
							$url = '';

							break;
						}
					}

					unset($data[$key]);	
				}elseif (($data['route'] == 'extension/module/lightshop_news/getnewslist')) {	
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($value) . "'");

					if ($query->num_rows && $query->row['keyword']) {
						$url .= '/' . $query->row['keyword'];

						unset($data[$key]);
					}				

//lightshop end

			
				} elseif ($key == 'path') {
					$categories = explode('_', $value);

					foreach ($categories as $category) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");

						if ($query->num_rows && $query->row['keyword']) {
							$url .= '/' . $query->row['keyword'];
						} else {
							$url = '';

							break;
						}
					}

					unset($data[$key]);
				}
			}
		}

		if ($url) {
			unset($data['route']);

			$query = '';

			if ($data) {
				foreach ($data as $key => $value) {
					$query .= '&' . rawurlencode((string)$key) . '=' . rawurlencode((is_array($value) ? http_build_query($value) : (string)$value));
				}

				if ($query) {
					$query = '?' . str_replace('&', '&amp;', trim($query, '&'));
				}
			}

			return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
		} else {
			return $link;
		}
	}
}
